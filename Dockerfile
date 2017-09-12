FROM alpine:edge
MAINTAINER Chris Batis <clbatis@taosnet.com>

RUN apk --no-cache add perl-cgi git-gitweb hiawatha --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted
ENTRYPOINT ["/usr/sbin/hiawatha"]
CMD ["-c", "/etc/hiawatha", "-d"]
EXPOSE 80/tcp 443/tcp
VOLUME "/pub/git"
COPY hiawatha.conf /etc/hiawatha/hiawatha.conf
