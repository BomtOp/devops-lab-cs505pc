@echo off
setlocal
cd /d "%~dp0"
set "PATH=%~dp0..\tools\bin;%PATH%"

echo === Experiment 6: Explore Docker Commands for Content Management ===

echo 1. docker pull ubuntu:16.04
call docker pull ubuntu:16.04

echo 2. docker images
call docker images

echo 3. docker run --name mycontainer -it ubuntu:16.04 /bin/bash
call docker run --name mycontainer -it ubuntu:16.04 /bin/bash

echo 4. docker ps
call docker ps

echo 5. docker stop mycontainer
call docker stop mycontainer

echo 6. docker start mycontainer
call docker start mycontainer

echo 7. docker push myimage
call docker push myimage

echo 8. docker stop mycontainer ^&^& docker rm mycontainer
call docker stop mycontainer
call docker rm mycontainer
