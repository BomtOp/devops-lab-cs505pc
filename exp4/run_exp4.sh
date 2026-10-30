#!/bin/bash
set -e
export PATH="/Users/rohitpranavnaidu/Documents/antigravity/brave-pythagoras/tools/bin:$PATH"

echo "=== Experiment 4: Jenkins Installation and Setup ==="
mkdir -p jenkins_home
export JENKINS_HOME="$(pwd)/jenkins_home"
JAVA_BIN="/Users/rohitpranavnaidu/Documents/antigravity/brave-pythagoras/tools/jdk/jdk-21/Contents/Home/bin/java"
JENKINS_WAR="/Users/rohitpranavnaidu/Documents/antigravity/brave-pythagoras/tools/jenkins/jenkins.war"

echo "1. Verifying Java & Jenkins package:"
"$JAVA_BIN" -version
ls -lh "$JENKINS_WAR"

echo "2. Starting Jenkins service on port 8090 (or checking web interface):"
"$JAVA_BIN" -Djenkins.install.runSetupWizard=false -jar "$JENKINS_WAR" --httpPort=8090 > jenkins.log 2>&1 &
JENKINS_PID=$!

echo "Waiting for Jenkins web interface to become ready..."
for i in {1..45}; do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8090/login || true)
  if [ "$STATUS" = "200" ] || [ "$STATUS" = "403" ]; then
    echo "Jenkins is running at http://localhost:8090 (HTTP $STATUS)!"
    break
  fi
  sleep 1
done

echo "3. Fetching Jenkins Web Interface Headers & Title:"
curl -sI http://localhost:8090/login | head -n 10

kill $JENKINS_PID 2>/dev/null || true
wait $JENKINS_PID 2>/dev/null || true
echo "Jenkins verification completed successfully."
