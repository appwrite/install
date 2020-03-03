FROM php:7.4-cli

COPY . /install

WORKDIR /install/bin/intsall.php

CMD [ "php", "/install/bin/intsall.php" ]