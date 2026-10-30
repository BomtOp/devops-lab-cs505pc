#!/bin/bash
set -e
JAVA_HOME="/Users/rohitpranavnaidu/Documents/antigravity/brave-pythagoras/tools/jdk/jdk-21/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

echo "=== Experiment 5: Continuous Integration and Development using Jenkins ==="

echo "Step 1: Initialize Git repository and commit Java application"
rm -rf git_repo build prod_deploy
mkdir -p git_repo build prod_deploy
cp HelloWorld.java git_repo/
cd git_repo
git init
git config user.name "DevOps Student"
git config user.email "student@smec.ac.in"
git add HelloWorld.java
git commit -m "Initial commit of HelloWorld Java application"
COMMIT_HASH=$(git rev-parse --short HEAD)
cd ..

echo "Step 2: Jenkins Job Triggered (SCM Poll -> Commit $COMMIT_HASH detected)"
echo "[Jenkins CI] Cloning repository from $(pwd)/git_repo ..."
git clone ./git_repo build/workspace

echo "Step 3: Compiling code, running unit tests, and packaging executable JAR"
cd build/workspace
javac HelloWorld.java
java HelloWorld
echo "Main-Class: HelloWorld" > Manifest.txt
jar cfm HelloWorld.jar Manifest.txt HelloWorld.class
cd ../..

echo "Step 4: Deploying artifact to production environment"
cp build/workspace/HelloWorld.jar prod_deploy/HelloWorld.jar
echo "[Jenkins CD] Running deployed production JAR:"
java -jar prod_deploy/HelloWorld.jar

echo "Step 5: Repeating CI/CD process for subsequent code change"
cd git_repo
sed -i '' 's/15, 25/20, 30/g' HelloWorld.java
sed -i '' 's/15 + 25/20 + 30/g' HelloWorld.java
sed -i '' 's/!= 40/!= 50/g' HelloWorld.java
git add HelloWorld.java
git commit -m "Update calculation values to 20 + 30"
NEW_HASH=$(git rev-parse --short HEAD)
cd ..

echo "[Jenkins CI] Change detected ($NEW_HASH). Rebuilding and redeploying..."
cd build/workspace
git pull origin master 2>/dev/null || git pull origin main 2>/dev/null
javac HelloWorld.java
java HelloWorld
jar cfm HelloWorld.jar Manifest.txt HelloWorld.class
cp HelloWorld.jar ../../prod_deploy/HelloWorld.jar
cd ../..
echo "[Jenkins CD] Running updated production JAR:"
java -jar prod_deploy/HelloWorld.jar
