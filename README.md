## Description

A collection of simple docker images to handle basic tasks with git. There are three tags to handle three tasks:

1. [git:latest](#taosnetgitlatest) - A git client.
2. [git:ssh](#taosnetgitssh) - A ssh based git server.
3. [git:web](#taosnetgitweb) - A GitWeb server.

## Usage

### taosnet/git:latest

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

### taosnet/git:ssh

This image is designed to be a git repository server accessible via ssh. This image uses [taosnet/ssh_server](https://hub.docker.com/r/taosnet/ssh_server/) as the base image, so associated environmental variables and utilities apply. This image adds a utility **createRepository** to make it easy to create empty repositories.

#### Example

Create a repository accessible by two users:

```
docker run --name myrepo -d -p 2222:22 -v myrepo:/repos -e SSH_USER=gitrepo taosnet/git:ssh
docker exec myrepo addgroup repousers
docker exec setupUser.sh -g repousers -k 'user1 ssh key...' user1
docker exec setupUser.sh -g repousers -k 'user2 ssh key...' user2
docker exec createRepository -u gitrepo -g repousers /repos/project1
```

#### Utilities

* **createRepository**: Creates a new empty repository at the given path. Usage: `createRepository [-u user] [-g group] pathToRepository`. Repository path should not already exist. If given, the repository will be set with _user_ as the owner and _group_ as the group.

### taosnet/git:web

This image is a simple GitWeb server. This gives you a web based view into your git repositories. This is a very simple image, with not a lot of configuration. The path to your repositories is expected to be _/pub/git_.

#### Example

First you need a git repository server running with a repository:

```
docker run --name git-server -d -p 2222:22 -v myrepo:/repos -e SSH_USER=gitrepo taosnet/git:ssh
docker exec git-server createRepository -u gitrepo /repos/myproject1
```

Next you connect your web server to the repositories:

```
docker run --name git-web -d -p 1234:80 -v myrepo:/pub/git taosnet/git:web
```

Now you will be able to browse your repositories at http://myserver:1234/.
