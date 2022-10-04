#!/bin/bash

docker pull jenkins/jenkins
docker run -d -p 8080:8080 --rm -v "$HOME/app":/app jenkins/jenkins
