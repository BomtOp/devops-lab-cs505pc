#!/bin/bash
set -e
export PATH="/Users/rohitpranavnaidu/Documents/antigravity/brave-pythagoras/tools/bin:$PATH"

echo "=== Experiment 6: Explore Docker Commands for Content Management ==="

echo "1. docker pull ubuntu:16.04"
docker pull ubuntu:16.04

echo "2. docker images"
docker images

echo "3. docker run --name mycontainer -it ubuntu:16.04 /bin/bash"
docker run --name mycontainer -it ubuntu:16.04 /bin/bash

echo "4. docker ps"
docker ps

echo "5. docker stop mycontainer"
docker stop mycontainer

echo "6. docker start mycontainer"
docker start mycontainer

echo "7. docker push myimage"
docker push myimage

echo "8. docker stop mycontainer && docker rm mycontainer"
docker stop mycontainer
docker rm mycontainer
