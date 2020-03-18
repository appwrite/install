#!/bin/bash bash

RED='\033[0;31m'
NC='\033[0m' # No Color

echo 'Starting build...'

docker build --tag appwrite/install:"$1" .

echo 'Pushing build to registry...'

docker push appwrite/install:"$1"
