@echo off
setlocal enabledelayedexpansion

echo === Windows DevOps Lab Tool Downloader ===
cd /d "%~dp0.."

if not exist "tools\jdk" mkdir "tools\jdk"
if not exist "tools\selenium" mkdir "tools\selenium"
if not exist "tools\jenkins" mkdir "tools\jenkins"
if not exist "tools\bin" mkdir "tools\bin"

echo === 1. Creating Python Virtual Environment and Installing Flask ^& Selenium ===
if not exist "tools\venv" (
    python -m venv tools\venv
)
call tools\venv\Scripts\python.exe -m pip install --upgrade pip flask selenium webdriver-manager

echo === 2. Downloading Adoptium OpenJDK 21 (Windows x64) ===
if not exist "tools\jdk\jdk-21\bin\java.exe" (
    echo Downloading OpenJDK 21 ZIP...
    curl -sL "https://api.adoptium.net/v3/binary/latest/21/ga/windows/x64/jdk/hotspot/normal/eclipse" -o tools\jdk\openjdk21.zip
    powershell -NoProfile -Command "Expand-Archive -Path 'tools\jdk\openjdk21.zip' -DestinationPath 'tools\jdk\extracted' -Force; $dir = Get-ChildItem 'tools\jdk\extracted' | Select-Object -First 1; Move-Item $dir.FullName 'tools\jdk\jdk-21' -Force; Remove-Item 'tools\jdk\extracted' -Recurse -Force"
    del /q tools\jdk\openjdk21.zip
)
tools\jdk\jdk-21\bin\java.exe -version

echo === 3. Downloading Selenium Server (Standalone JAR) ^& JUnit 4 ===
if not exist "tools\selenium\selenium-server.jar" (
    curl -sL "https://github.com/SeleniumHQ/selenium/releases/download/selenium-4.25.0/selenium-server-4.25.0.jar" -o tools\selenium\selenium-server.jar
)
if not exist "tools\selenium\junit-4.13.2.jar" (
    curl -sL "https://repo1.maven.org/maven2/junit/junit/4.13.2/junit-4.13.2.jar" -o tools\selenium\junit-4.13.2.jar
)
if not exist "tools\selenium\hamcrest-core-1.3.jar" (
    curl -sL "https://repo1.maven.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar" -o tools\selenium\hamcrest-core-1.3.jar
)

echo === 4. Downloading ChromeDriver (Windows win64) ===
if not exist "tools\bin\chromedriver.exe" (
    powershell -NoProfile -Command "$chromeVer = (Get-ItemProperty 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Google Chrome' -ErrorAction SilentlyContinue).DisplayVersion; if (-not $chromeVer) { $chromeVer = (Get-Item 'C:\Program Files\Google\Chrome\Application\chrome.exe' -ErrorAction SilentlyContinue).VersionInfo.ProductVersion }; $major = if ($chromeVer) { $chromeVer.Split('.')[0] + '.' } else { '' }; $json = Invoke-RestMethod 'https://googlechromelabs.github.io/chrome-for-testing/known-good-versions-with-downloads.json'; $versions = $json.versions | Where-Object { $_.downloads.chromedriver -ne $null -and ($major -eq '' -or $_.version.StartsWith($major)) }; $best = $versions[-1]; $url = ($best.downloads.chromedriver | Where-Object { $_.platform -eq 'win64' }).url; Write-Host ('Downloading ChromeDriver ' + $best.version + ' from ' + $url); Invoke-WebRequest -Uri $url -OutFile 'tools\selenium\chromedriver.zip'; Expand-Archive 'tools\selenium\chromedriver.zip' -DestinationPath 'tools\selenium' -Force; Move-Item 'tools\selenium\chromedriver-win64\chromedriver.exe' 'tools\bin\chromedriver.exe' -Force; Remove-Item 'tools\selenium\chromedriver.zip','tools\selenium\chromedriver-win64' -Recurse -Force"
)
if exist "tools\bin\chromedriver.exe" tools\bin\chromedriver.exe --version

echo === 5. Downloading kubectl (Windows amd64) ===
if not exist "tools\bin\kubectl-bin.exe" (
    for /f "delims=" %%v in ('curl -sL https://dl.k8s.io/release/stable.txt') do set KUBE_VER=%%v
    curl -sL "https://dl.k8s.io/release/!KUBE_VER!/bin/windows/amd64/kubectl.exe" -o tools\bin\kubectl-bin.exe
)

echo === 6. Downloading Jenkins LTS (jenkins.war) ===
if not exist "tools\jenkins\jenkins.war" (
    curl -sL "https://get.jenkins.io/war-stable/latest/jenkins.war" -o tools\jenkins\jenkins.war
)

echo === ALL WINDOWS DOWNLOADS COMPLETE ===
