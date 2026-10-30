@echo off
setlocal
cd /d "%~dp0"
set "PATH=%~dp0..\tools\bin;%PATH%"

echo === Experiment 7: Develop a Simple Containerized Application using Docker ===

echo 1. Building Docker image: docker build -t myimage .
call docker build -t myimage .

echo 2. Running Docker container: docker run --name mycontainer myimage
call docker run --name mycontainer myimage

echo 3. Verifying the output: docker logs mycontainer
call docker logs mycontainer
