FROM taosnet/ssh_server
MAINTAINER Chris Batis <clbatis@taosnet.com>

RUN apk --no-cache add git
COPY createRepository /usr/bin/createRepository
