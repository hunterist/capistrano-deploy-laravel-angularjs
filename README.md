Centralized Lumen/Laravel + AngularJS Deploy By Capistrano
================================================================================

This repository contains a [Capistrano](http://capistranorb.com/) project that builds centralized applications [CapHub – multiple applications deployment with Capistrano](http://railsware.com/blog/2011/11/18/caphub-multiple-applications-deployment-with-capistrano/).


Requirements
--------------------------------------------------------------------------------

**I. Local (remote build)**

Tool        | Version      | Purpose
----------- | ------------ | ----------------------------------------------------
Capistrano  | 3.6.1        | Deploy backend+frontend source code
NodeJS      | 4.6.1        | Frontend runtime environment
Gulp        | 3.9.1        | Build frontend


**II. Backend servers**

Tool        | Version      | Purpose
----------- | ------------ | ----------------------------------------------------
PHP         | 7.0          | Server language
PHP7.0-FPM  | 7.0          | FastCGI process manager
Cachetool   | master       | On the backend servers, you must install [cachetool](https://github.com/gordalina/cachetool) to /usr/local/bin/ first to make sure symlink correctly.

**III. Frontend servers**

Tool        | Version      | Purpose
----------- | ------------ | ----------------------------------------------------

**Note:**
If you want to upgrade capistrano to version 3.7.x, please follow at https://github.com/capistrano/capistrano/blob/master/UPGRADING-3.7.md


Getting Started 
--------------------------------------------------------------------------------

Rename .env.example to .env in backend & frontend folder.

```sh
$ mv backend/.env.example .env
$ mv frontend/.env.example .env
```

Check backend commands:

```sh
cd backend
$ cap -T
```

Check frontend commands:

```sh
cd frontend
$ cap -T
```

Deploy backend:

```sh
$ cd backend
$ terraform hunterist-admin-backend:dev deploy
$ terraform hunterist-admin-backend:staging deploy
$ terraform hunterist-admin-backend:production deploy
$ terraform hunterist-company-backend:dev deploy
$ terraform hunterist-company-backend:staging deploy
$ terraform hunterist-company-backend:production deploy
```

Deploy frontend:

```sh
$ cd frontend
$ terraform hunterist-admin-frontend:dev deploy
$ terraform hunterist-admin-frontend:staging deploy
$ terraform hunterist-admin-frontend:production deploy
$ terraform hunterist-company-frontend:dev deploy
$ terraform hunterist-company-frontend:staging deploy
$ terraform hunterist-company-frontend:production deploy
```