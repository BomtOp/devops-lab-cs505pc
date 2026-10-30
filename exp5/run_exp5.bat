@echo off
setlocal
cd /d "%~dp0"

if exist "%~dp0..\tools\jdk\jdk-21\bin\java.exe" (
    set "PATH=%~dp0..\tools\jdk\jdk-21\bin;%PATH%"
)

echo === Experiment 5: Continuous Integration and Development using Jenkins (Windows) ===

echo Step 1: Initialize Git repository and commit Java application
if exist "git_repo" rmdir /s /q "git_repo"
if exist "build" rmdir /s /q "build"
if exist "prod_deploy" rmdir /s /q "prod_deploy"
mkdir git_repo build prod_deploy

copy /Y HelloWorld.java git_repo\ >nul
cd git_repo
git init
git config user.name "DevOps Student"
git config user.email "student@smec.ac.in"
git add HelloWorld.java
git commit -m "Initial commit of HelloWorld Java application"
for /f "delims=" %%h in ('git rev-parse --short HEAD') do set COMMIT_HASH=%%h
cd ..

echo Step 2: Jenkins Job Triggered (SCM Poll -^> Commit %COMMIT_HASH% detected)
echo [Jenkins CI] Cloning repository from %CD%\git_repo ...
git clone ./git_repo build/workspace

echo Step 3: Compiling code, running unit tests, and packaging executable JAR
cd build\workspace
javac HelloWorld.java
java HelloWorld
echo Main-Class: HelloWorld> Manifest.txt
jar cfm HelloWorld.jar Manifest.txt HelloWorld.class
cd ..\..

echo Step 4: Deploying artifact to production environment
copy /Y build\workspace\HelloWorld.jar prod_deploy\HelloWorld.jar >nul
echo [Jenkins CD] Running deployed production JAR:
java -jar prod_deploy\HelloWorld.jar

echo Step 5: Repeating CI/CD process for subsequent code change
cd git_repo
powershell -NoProfile -Command "(Get-Content HelloWorld.java) -replace '15, 25','20, 30' -replace '15 \+ 25','20 + 30' -replace '!= 40','!= 50' | Set-Content HelloWorld.java"
git add HelloWorld.java
git commit -m "Update calculation values to 20 + 30"
for /f "delims=" %%h in ('git rev-parse --short HEAD') do set NEW_HASH=%%h
cd ..

echo [Jenkins CI] Change detected (%NEW_HASH%). Rebuilding and redeploying...
cd build\workspace
git pull origin main 2>nul || git pull origin master 2>nul
javac HelloWorld.java
java HelloWorld
jar cfm HelloWorld.jar Manifest.txt HelloWorld.class
copy /Y HelloWorld.jar ..\..\prod_deploy\HelloWorld.jar >nul
cd ..\..
echo [Jenkins CD] Running updated production JAR:
java -jar prod_deploy\HelloWorld.jar
