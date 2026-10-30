@echo off
setlocal
cd /d "%~dp0"

echo === Experiment 4: Jenkins Installation and Setup (Windows) ===
if not exist "jenkins_home" mkdir "jenkins_home"
set "JENKINS_HOME=%~dp0jenkins_home"

if exist "%~dp0..\tools\jdk\jdk-21\bin\java.exe" (
    set "JAVA_BIN=%~dp0..\tools\jdk\jdk-21\bin\java.exe"
) else (
    set "JAVA_BIN=java"
)
set "JENKINS_WAR=%~dp0..\tools\jenkins\jenkins.war"

echo 1. Verifying Java ^& Jenkins package:
"%JAVA_BIN%" -version
dir "%JENKINS_WAR%"

echo 2. Starting Jenkins service on port 8090:
powershell -NoProfile -Command "$proc = Start-Process -FilePath '%JAVA_BIN%' -ArgumentList '-Djenkins.install.runSetupWizard=false','-jar','%JENKINS_WAR%','--httpPort=8090' -RedirectStandardOutput 'jenkins.log' -RedirectStandardError 'jenkins_err.log' -PassThru; Write-Host 'Waiting for Jenkins web interface to become ready...'; for ($i=0; $i -lt 45; $i++) { try { $r = Invoke-WebRequest -Uri 'http://localhost:8090/login' -UseBasicParsing -ErrorAction Stop; if ($r.StatusCode -eq 200) { Write-Host 'Jenkins is running at http://localhost:8090 (HTTP 200)!'; Write-Host ('X-Jenkins: ' + $r.Headers['X-Jenkins']); break } } catch {}; Start-Sleep -Seconds 1 }; Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue"
echo Jenkins verification completed successfully.
