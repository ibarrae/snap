# Changelog for snap
## 1.0.6
    - Added the feature of deleting a user with a DELETE request.
    - Added tests for user queries.
    
## 1.0.5
    - Changed names of migration files and EnvRead module.
    - Added persistence for inserting new user into DB.
    - Added validations for the user form using digestive-functors
    - Added user form templates and module.
    - Added handler and e2e test for new user.
    - Fixed circle CI config.

## 1.0.4
    - Added a base template.
    - Added the User query, persistence and handler modules.
    - Added the user list template.
    - Changed init of db snaplet with the loading of .env values.

## 1.0.3
    - Changed snaplet-persistent for snaplet-postgresql-simple.
    - Changed SnapUser model for User data type.
    - Created ToRow and FromRow instances for User and Gender.
    - Added migration for gender column of snap_user table.
    - Changed folder structure for src.

## 1.0.2
    - Created moo.cfg and dbmigrations.
    - Changed to lts-11.17 due to package compatibility
    - Changed to ghc 8.2.2 for travis.
    - Added the snaplet-persistent package to the app.
    - Created the SnapUser model
    - Changed travis setup to add the flag --allow-newer to build up the project.

## 1.0.1
    - Added a package.yaml for the project.
    - Untracked the .ghci file.
    - Upgraded to lts-12.1
    - Removed unnecesary comments on stack.yaml
    - Updated version in package.yaml
    - Updated readme.me
## 1.0
    - Added a change log.
    - Set up the initial folder structure for a snap project.
    - Set up project structure for a 'stack' structure.