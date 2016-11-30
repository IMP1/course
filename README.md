# Course

Course is a workflow management tool. 
It schedules jobs to be run, and allows users to specify jobs' dependencies on other jobs.

## Terminology

A *'workflow'* contains many *'jobs'*, which run a *'task'*.
A workflow has a *'schedule'* which determines when it runs.
A workflows jobs have dependencies which are other jobs.
A *'run'* is the process of executing a workflow, and is created when a workflow begins.

The scheduler also handles running jobs upon the completion of all their dependencies.
Workflows may also have workflows within them (so long as this doesn't get cyclical and weird). 
This allows (concurrent) jobs to be logically grouped (and then reused). 
These workflows may or may not have a schedule and also run independantly as their own workflow, or separately in other workflows (or both).

## Success & Failure

Workflows and Jobs, at any given time, are in one of the following states:

 - `new`        (workflow has not been run)
 - `executing`  (workflow has begun)
 - `success`    (workflow has completed successfully)
 - `failure`    (workflow has completed unsuccessfully)

Both success and failure repesent the termination of a job/workflow, and both can have events associated with them (emails, debugging, etc.).
Success of a job/workflow, however, propogates to jobs/workflows depending on it, and may cause them to run.

## Architecture

Course is made up of the following:

**Course Scheduler**: Polls for the timings of workflows. 
Upon the beginning of a workflow, a scheduler thread is created to oversee the running of the workflow's jobs and manage their dependencies.

**Course Database**: Contains information regarding workflows, jobs, and runs. It also holds information regarding users and usergroups.

**Course User Session**: An API which allows users to create workflows, jobs, set schedules and perform tasks they need to set up and maintain Course.

**Executors**: These processes manges the running of tasks and returning their results. 
The processes can reside externally to Course, which means there need not be a network between them and the task they're running.

**Webserver**: A webserver can be set up which gives users a GUI which calls to the Course API, as well as showing users visualisations of workflows in real time.

## Development

All of the above speaks about Course as though it already exists. This is unfortunately not the case. It is in development. You can check out the [Projects Page](https://github.com/IMP1/course/projects) to see what sprints are happening and the [Wiki](https://github.com/IMP1/course/wiki), both for contributing and finding out more both about Course and its development.

