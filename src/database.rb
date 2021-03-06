require 'rubygems'
require 'sequel'

DB = Sequel.sqlite('./course.db') # Change to something proper and scalable at some point.

module CourseDatabase

    def self.install(admin_username, admin_password)
        setup_tables()
        create_user(admin_username, admin_password, User::ROLES[:ADMIN])
        create_user("test", "password")
        puts "Databases installed."
    end

    def self.setup_tables()
        DB.create_table :users do
            primary_key :user_id
            String      :user_name
            String      :user_password # Plaintext? Really? Ugh.
        end
        DB.create_table :roles do
            primary_key :role_id
            String      :role_name
        end
        DB.create_table :user_roles do
            foreign_key :user_id, :users
            foreign_key :role_id, :roles
        end
        roles = DB[:roles]
        User::ROLES.each do |key, value|
            roles.insert(:role_name => value)
        end
    end

    def self.create_user(username, password, role_name=User::ROLES[:USER])
        new_user_id = DB[:users].insert(:user_name => username, :user_password => password)
        role = DB[:roles].where(:role_name => role_name).first
        DB[:user_roles].insert(:user_id => new_user_id, :role_id => role[:role_id])
    end

    def self.uninstall()
        # TODO: uninstall
        puts "Databases uninstalled."
    end

end