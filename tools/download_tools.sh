#!/bin/bash
set -e

mkdir -p tools/jdk tools/selenium tools/jenkins tools/bin

echo "=== 1. Installing Flask & Selenium in Python venv ==="
tools/venv/bin/pip install --upgrade pip flask selenium webdriver-manager

echo "=== 2. Downloading Adoptium OpenJDK 21 (macOS aarch64) ==="
if [ ! -d "tools/jdk/jdk-21" ]; then
  curl -sL "https://api.adoptium.net/v3/binary/latest/21/ga/mac/aarch64/jdk/hotspot/normal/eclipse" -o tools/jdk/openjdk21.tar.gz
  mkdir -p tools/jdk/jdk-21
  tar -xzf tools/jdk/openjdk21.tar.gz -C tools/jdk/jdk-21 --strip-components=1
  rm -f tools/jdk/openjdk21.tar.gz
fi
tools/jdk/jdk-21/Contents/Home/bin/java -version

echo "=== 3. Downloading Selenium Server (Standalone JAR) & JUnit 4 ==="
if [ ! -f "tools/selenium/selenium-server.jar" ]; then
  curl -sL "https://github.com/SeleniumHQ/selenium/releases/download/selenium-4.25.0/selenium-server-4.25.0.jar" -o tools/selenium/selenium-server.jar
fi
if [ ! -f "tools/selenium/junit-4.13.2.jar" ]; then
  curl -sL "https://repo1.maven.org/maven2/junit/junit/4.13.2/junit-4.13.2.jar" -o tools/selenium/junit-4.13.2.jar
fi
if [ ! -f "tools/selenium/hamcrest-core-1.3.jar" ]; then
  curl -sL "https://repo1.maven.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar" -o tools/selenium/hamcrest-core-1.3.jar
fi

echo "=== 4. Downloading ChromeDriver ==="
if [ ! -f "tools/bin/chromedriver" ]; then
  CHROME_VER=$("/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --version | awk '{print $3}')
  echo "Detected Chrome version: $CHROME_VER"
  # Try exact milestone or latest stable from Chrome for Testing JSON
  DRIVER_URL=$(tools/venv/bin/python -c "
import urllib.request, json
data = json.loads(urllib.request.urlopen('https://googlechromelabs.github.io/chrome-for-testing/known-good-versions-with-downloads.json').read())
versions = [v for v in data['versions'] if 'chromedriver' in v['downloads']]
best = versions[-1]
for d in best['downloads']['chromedriver']:
    if d['platform'] == 'mac-arm64':
        print(d['url'])
        break
")
  echo "Downloading ChromeDriver from $DRIVER_URL"
  curl -sL "$DRIVER_URL" -o tools/selenium/chromedriver.zip
  unzip -q -o tools/selenium/chromedriver.zip -d tools/selenium/
  mv tools/selenium/chromedriver-mac-arm64/chromedriver tools/bin/chromedriver
  chmod +x tools/bin/chromedriver
  rm -rf tools/selenium/chromedriver.zip tools/selenium/chromedriver-mac-arm64
fi
tools/bin/chromedriver --version || true

echo "=== 5. Downloading kubectl ==="
if [ ! -f "tools/bin/kubectl" ]; then
  KUBE_VER=$(curl -sL https://dl.k8s.io/release/stable.txt)
  curl -sL "https://dl.k8s.io/release/${KUBE_VER}/bin/darwin/arm64/kubectl" -o tools/bin/kubectl
  chmod +x tools/bin/kubectl
fi
tools/bin/kubectl version --client

echo "=== 6. Downloading Jenkins LTS (jenkins.war) ==="
if [ ! -f "tools/jenkins/jenkins.war" ]; then
  curl -sL "https://get.jenkins.io/war-stable/latest/jenkins.war" -o tools/jenkins/jenkins.war
fi
ls -lh tools/jenkins/jenkins.war

echo "=== ALL DOWNLOADS COMPLETE ==="
