FROM resin/rpi-raspbian
MAINTAINER Nuno Sousa <nunofgs@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\
    apt-get install -y avahi-daemon git golang &&\
    apt-get clean

ENV GOPATH /opt/go
ENV PATH $PATH:$GOPATH/bin
RUN go get -u github.com/iLem0n/docker-gen && go get -u github.com/ddollar/forego

ADD avahi-daemon.conf /etc/avahi/avahi-daemon.conf
ADD data/ /opt/app
WORKDIR /opt/app

ENV DOCKER_HOST unix:///tmp/docker.sock

CMD ["forego", "start", "-r"]

