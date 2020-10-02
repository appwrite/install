FROM alpine:3.12

LABEL maintainer="team@appwrite.io"

ENV version latest \
    TZ=Asia/Tel_Aviv

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN \
    echo http://dl-cdn.alpinelinux.org/alpine/v3.12/main > /etc/apk/repositories \
	echo http://dl-cdn.alpinelinux.org/alpine/v3.12/community >> /etc/apk/repositories

RUN \
    apk update && apk add --no-cache wget curl docker php php-mbstring
  
RUN curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

RUN docker-compose --version

COPY . /install

RUN ls -ll /install/data

CMD [ "sh", "-c", "php /install/bin/installer start --version=${version}" ]
