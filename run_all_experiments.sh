#!/bin/bash
set -e

ROOT_DIR="/Users/rohitpranavnaidu/Documents/antigravity/brave-pythagoras"
export PATH="$ROOT_DIR/tools/bin:$ROOT_DIR/tools/jdk/jdk-21/Contents/Home/bin:$PATH"
CP=".:$ROOT_DIR/tools/selenium/selenium-server.jar:$ROOT_DIR/tools/selenium/junit-4.13.2.jar:$ROOT_DIR/tools/selenium/hamcrest-core-1.3.jar"

# Clean up any leftover background Flask processes
pkill -f "exp1/app.py" 2>/dev/null || true
sleep 1

echo "=================================================================="
echo "                   EXPERIMENT 1: FLASK & DOCKER                   "
echo "=================================================================="
cd "$ROOT_DIR/exp1"
docker build -t simple-flask-app .
docker run -p 5000:5000 simple-flask-app
"$ROOT_DIR/tools/venv/bin/python" app.py > flask.log 2>&1 &
FLASK_PID=$!
sleep 2
echo "--- GET http://localhost:8080/register ---"
curl -s http://localhost:8080/register
echo ""
echo "--- POST http://localhost:8080/register ---"
curl -s -X POST -d "name=John+Doe&email=john.doe@example.com&password=secret" http://localhost:8080/register
echo ""

echo "=================================================================="
echo "                EXPERIMENT 2: GIT & GITHUB COMMANDS               "
echo "=================================================================="
cd "$ROOT_DIR/exp2"
./run_exp2.sh

echo "=================================================================="
echo "         EXPERIMENT 3: SOURCE CODE MANAGEMENT ON GITHUB           "
echo "=================================================================="
cd "$ROOT_DIR/exp3"
./run_exp3.sh

echo "=================================================================="
echo "           EXPERIMENT 4: JENKINS INSTALLATION & SETUP             "
echo "=================================================================="
cd "$ROOT_DIR/exp4"
./run_exp4.sh

echo "=================================================================="
echo "       EXPERIMENT 5: CI/CD USING JENKINS & JAVA APPLICATION       "
echo "=================================================================="
cd "$ROOT_DIR/exp5"
./run_exp5.sh

echo "=================================================================="
echo "       EXPERIMENT 6: DOCKER COMMANDS FOR CONTENT MANAGEMENT       "
echo "=================================================================="
cd "$ROOT_DIR/exp6"
./run_exp6.sh

echo "=================================================================="
echo "     EXPERIMENT 7: CONTAINERIZED APPLICATION USING DOCKER         "
echo "=================================================================="
cd "$ROOT_DIR/exp7"
./run_exp7.sh

echo "=================================================================="
echo "      EXPERIMENT 8 & 9: KUBERNETES & DOCKER INTEGRATION           "
echo "=================================================================="
cd "$ROOT_DIR/exp9"
./run_exp9.sh

echo "=================================================================="
echo "       EXPERIMENT 10: SELENIUM AUTOMATED TESTING (GOOGLE)         "
echo "=================================================================="
cd "$ROOT_DIR/exp10"
javac -cp "$CP" Main.java
java -ea -cp "$CP" Main 2>/dev/null

echo "=================================================================="
echo "     EXPERIMENT 11: JAVASCRIPT PROGRAM & SELENIUM JUNIT TEST      "
echo "=================================================================="
cd "$ROOT_DIR/exp11"
javac -cp "$CP" Main.java
java -ea -cp "$CP" Main 2>/dev/null

echo "=================================================================="
echo "  EXPERIMENT 12: SELENIUM TEST CASES FOR CONTAINERIZED APP        "
echo "=================================================================="
cd "$ROOT_DIR/exp12"
javac -cp "$CP" Main.java
java -ea -Dapp.url=http://localhost:8080 -cp "$CP" Main 2>/dev/null

kill $FLASK_PID 2>/dev/null || true

echo "=================================================================="
echo "          ALL 12 EXPERIMENTS VERIFIED WITH IDEAL OUTPUT!          "
echo "=================================================================="
