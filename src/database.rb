require 'rubygems'
require 'sequel'

DB = Sequel.sqlite # Change to something proper and scalable at some point.

module CourseDatabase

    def self.install(admin_username, admin_password)
        setup_tables()
        create_user(username, password, User::ROLES[:ADMIN])
        puts "Databases installed."
    end

    def self.setup_tables()
        # USERS
        DB.create_table :users do
            primary_key :user_id
            String      :user_name
            String      :user_password # Plaintext? Really? Ugh.
        end
        # ROLES
        DB.create_table :roles do
            primary_key :role_id
            String      :role_name
        end
        roles = DB[:roles]
        User::ROLES.each do |key, value|
            roles.insert(:role_name => value)
        end
        # USER ROLES
        DB.create_table :user_roles do
            foreign_key :user, :users
            foreign_key :role, :roles
        end
        # JOBS
        DB.create_table :jobs do
            primary_key :job_id
            String      :job_name
        end
        # WORKFLOWS
        DB.create_table :workflows do
            primary_key :workflow_id
            String      :workflow_name
            String      :workflow_description
        end
        # DEPENDENCIES
        DB.create_table :dependencies do
            foreign_key :job_id, :jobs
            TrueClass   :dependency_is_job
            foreign_key :dependency_job_id, :jobs
            TrueClass   :dependency_is_workflow
            foreign_key :dependency_workflow_id, :workflows
        end
    end

    def self.create_user(username, password, role_name)
        foo = DB[:users].insert(:user_name => username, :user_password => password)
        puts "Is #{foo} a user ID? I hope so."
        role_id = DB[:roles].where(:role_name => role_name).first
        DB[:user_roles].insert(:user_id => foo, :role_id => role_id)
    end

    def self.uninstall()
        # TODO: uninstall
        puts "Databases uninstalled."
    end

end