@echo off
setlocal
cd /d "%~dp0"
set "PATH=%~dp0..\tools\bin;%PATH%"

echo === Experiment 8 ^& 9: Integrate Kubernetes and Docker ^& Automate Containerized App Deployment ===

echo 1. Building Docker image from Exercise 7:
call docker build -t myimage ..\exp7

echo 2. Pushing Docker image to registry:
call docker push myimage

echo 3. Applying Kubernetes Deployment (deployment.yaml):
call kubectl apply -f deployment.yaml

echo 4. Applying Kubernetes Service (service.yaml):
call kubectl apply -f service.yaml

echo 5. Verifying Pods (kubectl get pods):
call kubectl get pods

echo 6. Verifying Services (kubectl get services):
call kubectl get services

echo 7. Scaling Deployment to 4 replicas (Kubernetes container management):
call kubectl scale deployment myapp --replicas=4
call kubectl get pods
