@echo off
setlocal
cd /d "%~dp0"
if exist "%~dp0..\tools\jdk\jdk-21\bin\java.exe" (
    set "PATH=%~dp0..\tools\jdk\jdk-21\bin;%PATH%"
)
set "CP=.;%~dp0..\tools\selenium\selenium-server.jar;%~dp0..\tools\selenium\junit-4.13.2.jar;%~dp0..\tools\selenium\hamcrest-core-1.3.jar"
if exist "%~dp0..\tools\venv\Scripts\python.exe" (
    set "PY_BIN=%~dp0..\tools\venv\Scripts\python.exe"
) else (
    set "PY_BIN=python"
)
powershell -NoProfile -Command "try { Invoke-WebRequest -Uri 'http://localhost:8080/' -UseBasicParsing -ErrorAction Stop | Out-Null } catch { $fl = Start-Process -FilePath '%PY_BIN%' -ArgumentList 'app.py' -WorkingDirectory '%~dp0..\exp1' -RedirectStandardOutput '%~dp0..\exp1\flask.log' -RedirectStandardError '%~dp0..\exp1\flask_err.log' -PassThru; $fl.Id | Out-File '%~dp0..\exp1\flask_exp12.pid'; Start-Sleep -Seconds 2 }"
javac -cp "%CP%" Main.java
java -ea -Dapp.url=http://localhost:8080 -cp "%CP%" Main 2>nul
if exist "%~dp0..\exp1\flask_exp12.pid" (
    powershell -NoProfile -Command "$pidVal = Get-Content '%~dp0..\exp1\flask_exp12.pid'; Stop-Process -Id $pidVal -Force -ErrorAction SilentlyContinue; Remove-Item '%~dp0..\exp1\flask_exp12.pid' -Force -ErrorAction SilentlyContinue"
)
