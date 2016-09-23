## Description

Simple docker image to run git on the host machine.

## Usage

The images sets the current working directory within the container to */git*. It is best to mount a data volume in /git to get the expected result.

If you setup an alias command, you can run the image as if git were installed on the host machine:
```
alias git='docker run --rm -ti -v `pwd`:/git:Z taosnet/git
```
Make sure that you use **'** instead of **"**. This makes it so that the **pwd** command is executed everytime the command is run. **"** would run **pwd** when the command is created.

To create a new repository with the above alias, just run these series of commands:
```
cd /path/to/new/repository
git init
git config user.name "My Name"
git config user.email "email@domain.com"
git add file1 file2 ...
git commit -m "Initial commit"
```
