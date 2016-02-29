#!/bin/sh

brew cleanup
sudo gem cleanup

docker-machine env docker-vm
docker rm `docker ps -a | grep Exited | awk '{print $1 }'`
docker rmi `docker images -aq`
