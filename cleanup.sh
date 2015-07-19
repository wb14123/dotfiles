#!/bin/sh

brew cleanup
sudo gem cleanup

docker rm `docker ps -a | grep Exited | awk '{print $1 }'`
docker rmi `docker images -aq`
