#!/bin/sh

brew update
brew upgrade
npm update
sudo gem update

docker-machine upgrade docker-vm
