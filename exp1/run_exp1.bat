@echo off
setlocal
cd /d "%~dp0"
set "PATH=%~dp0..\tools\bin;%PATH%"

echo === Experiment 1: Simple User Registration Form (Flask ^& Docker) ===
call docker build -t simple-flask-app .
call docker run -p 5000:5000 simple-flask-app
