#!/bin/bash
set -e
export PATH="/Users/rohitpranavnaidu/Documents/antigravity/brave-pythagoras/tools/bin:$PATH"

echo "=== Experiment 7: Develop a Simple Containerized Application using Docker ==="

echo "1. Building Docker image: docker build -t myimage ."
docker build -t myimage .

echo "2. Running Docker container: docker run --name mycontainer myimage"
docker run --name mycontainer myimage

echo "3. Verifying the output: docker logs mycontainer"
docker logs mycontainer
