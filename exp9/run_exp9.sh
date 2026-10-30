#!/bin/bash
set -e
export PATH="/Users/rohitpranavnaidu/Documents/antigravity/brave-pythagoras/tools/bin:$PATH"

echo "=== Experiment 8 & 9: Integrate Kubernetes and Docker & Automate Containerized App Deployment ==="

echo "1. Building Docker image from Exercise 7:"
docker build -t myimage ../exp7

echo "2. Pushing Docker image to registry:"
docker push myimage

echo "3. Applying Kubernetes Deployment (deployment.yaml):"
kubectl apply -f ../exp9/deployment.yaml

echo "4. Applying Kubernetes Service (service.yaml):"
kubectl apply -f ../exp9/service.yaml

echo "5. Verifying Pods (kubectl get pods):"
kubectl get pods

echo "6. Verifying Services (kubectl get services):"
kubectl get services

echo "7. Scaling Deployment to 4 replicas (Kubernetes container management):"
kubectl scale deployment myapp --replicas=4
kubectl get pods
