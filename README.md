## Description

Simple docker container to run git.

## Usage

  1. Run the container as if it were a git command. **Note:** you need to use volumes mounted at /git to maintain changes.
         alias git-repository="docker run --rm -ti -v /path/to/reposity:/git:Z taosnet/git"
         git-repository init
         git-repository config user.name="My Name"
         git-repository config user.email="email@domain.com"
         git-repository commit -m "Initial commit"
