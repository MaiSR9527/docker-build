#!/bin/bash
jdk=$1
if test -d ./docker; then
  echo "docker folder already exist."
else
  git clone https://github.com/jenkinsci/docker.git
fi

cd docker && rm -rf Dockerfile

if [[ $jdk = '17' ]]; then
  echo 'use debian jdk17'
  cp 17/debian/bookworm/hotspot/Dockerfile Dockerfile
elif [[ $jdk = '11' ]]; then
  echo 'use debian jdk11'
  cp 11/debian/bookworm/hotspot/Dockerfile Dockerfile
elif [[ $jdk = '21' ]]; then
  echo 'use debian jdk21'
  cp 21/debian/bookworm/hotspot/Dockerfile Dockerfile
else
  echo 'usage build-jenkins-hugo.sh 11/17/21'
fi
# macos 上使用gsed, linux 上使用sed
gsed -i '/ENV LANG C.UTF-8/i\RUN apt-get update && apt-get install -y hugo' Dockerfile
#sed -i '/ENV LANG C.UTF-8/i\RUN apt install hugo' Dockerfile
docker build . -t jenkins-hugo:latest

echo "build done."

