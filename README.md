# SNAP FRAMEWORK 
The purpose of this repo is to get an insight of how the SNAP framework for haskell web development works.

To achieve this, a simple CRUD with simple validation for an user table is going to be developed.

Furthermore, the following links were used as a guide for installation and compiling the project:
- http://snapframework.com/docs/quickstart
- http://markbucciarelli.com/posts/2017-03-07_how_to_build_snap_with_stack.html

## Installation and compiling:

Following the next steps, you should be able to compile and execute the project with a stack structure:
- Switch to your project folder (in this case, snap).
- Create a snap initial structure with the command `snap init barebones`
- Initialize stack with the command `stack init`
- Install the haskell compiler with the command `stack build`
- Install GHC with the command `stack setup`
- Confirm that your project compiles correctly with stack with the command `stack build`
- Create a temporary project with stack, in this case the new project is called "tmp" with the command `stack new tmp`
- Move directories with the following commands 
  - `mv src app` 
  - `mv tmp/src .` 
  - `mv tmp/test .`
- Create backups for the .cabal files created (optional).
- Copy the package.yaml to the root folder.
- Add dependencies from the tmp.cabal to the package.yaml
- Replace all `tmp` ocurrences with `snap` in the package.yaml file.
  - Compare the snap.cabal.orig and package.yaml (optional).
- Recompile the project.
- Finally, start the web server with the command `stack exec snap`
  - It listens on the port 8000 for default.