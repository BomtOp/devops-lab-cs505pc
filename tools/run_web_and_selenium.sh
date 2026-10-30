#!/bin/bash
set -e
ROOT_DIR="/Users/rohitpranavnaidu/Documents/antigravity/brave-pythagoras"
export PATH="$ROOT_DIR/tools/bin:$ROOT_DIR/tools/jdk/jdk-21/Contents/Home/bin:$PATH"
CP=".:$ROOT_DIR/tools/selenium/selenium-server.jar:$ROOT_DIR/tools/selenium/junit-4.13.2.jar:$ROOT_DIR/tools/selenium/hamcrest-core-1.3.jar"

echo "========== EXPERIMENT 1: Flask Registration Form & Docker =========="
cd "$ROOT_DIR/exp1"
docker build -t simple-flask-app .
docker run -p 5000:5000 simple-flask-app
"$ROOT_DIR/tools/venv/bin/python" app.py > flask.log 2>&1 &
FLASK_PID=$!
sleep 2
echo "--- GET http://localhost:8080/register ---"
curl -s http://localhost:8080/register
echo "--- POST http://localhost:8080/register ---"
curl -s -X POST -d "name=John+Doe&email=john.doe@example.com&password=secret" http://localhost:8080/register

echo "========== EXPERIMENT 4: Jenkins Installation & Setup =========="
cd "$ROOT_DIR/exp4"
./run_exp4.sh

echo "========== EXPERIMENT 10: Install and Explore Selenium =========="
cd "$ROOT_DIR/exp10"
javac -cp "$CP" Main.java
java -ea -cp "$CP" Main

echo "========== EXPERIMENT 11: JavaScript Program & Selenium Test =========="
cd "$ROOT_DIR/exp11"
javac -cp "$CP" Main.java
java -ea -cp "$CP" Main

echo "========== EXPERIMENT 12: Selenium Test Cases for Containerized App =========="
cd "$ROOT_DIR/exp12"
javac -cp "$CP" Main.java
java -ea -Dapp.url=http://localhost:8080 -cp "$CP" Main

kill $FLASK_PID 2>/dev/null || true
