FROM ubuntu:19.04

LABEL maintainer="team@appwrite.io"

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends --no-install-suggests wget curl software-properties-common docker.io && \
  LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php && \
  apt-get update && \
  apt-get install -y --no-install-recommends --no-install-suggests php$PHP_VERSION

RUN curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

RUN docker-compose --version

COPY . /install

RUN ls -ll /install/data

CMD [ "php", "/install/bin/installer", "start" ]