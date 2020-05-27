FROM ubuntu:20.04

LABEL maintainer="team@appwrite.io"

ENV version latest

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends --no-install-suggests wget curl software-properties-common docker.io && \
  rm -rf /var/lib/apt/lists/* && \
  LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php && \
  apt-get update && \
  apt-get install -y --no-install-recommends --no-install-suggests php$PHP_VERSION php$PHP_VERSION-mbstring && \
  rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

RUN docker-compose --version

COPY . /install

RUN ls -ll /install/data

CMD [ "sh", "-c", "php /install/bin/installer start --version=${version}" ]
