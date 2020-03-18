#!/bin/bash bash

RED='\033[0;31m'
NC='\033[0m' # No Color

echo "Updating git repository $1 / $2"

git fetch origin
git reset --hard origin/master

echo 'Starting build...'

composer update --ignore-platform-reqs --optimize-autoloader --no-plugins --no-scripts --prefer-dist --no-dev

docker build --tag appwrite/install:"$1" .

echo 'Pushing build to registry...'

docker push appwrite/install:"$1"
