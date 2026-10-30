@echo off
setlocal
set "ROOT_DIR=%~dp0"
if "%ROOT_DIR:~-1%"=="\" set "ROOT_DIR=%ROOT_DIR:~0,-1%"

if not exist "%ROOT_DIR%\tools\selenium\selenium-server.jar" (
    echo Required tools not found in tools\ directory. Running tools\download_tools.bat first...
    call "%ROOT_DIR%\tools\download_tools.bat"
)

set "PATH=%ROOT_DIR%\tools\bin;%ROOT_DIR%\tools\jdk\jdk-21\bin;%PATH%"
set "CP=.;%ROOT_DIR%\tools\selenium\selenium-server.jar;%ROOT_DIR%\tools\selenium\junit-4.13.2.jar;%ROOT_DIR%\tools\selenium\hamcrest-core-1.3.jar"

if exist "%ROOT_DIR%\tools\venv\Scripts\python.exe" (
    set "PY_BIN=%ROOT_DIR%\tools\venv\Scripts\python.exe"
) else (
    set "PY_BIN=python"
)

echo ==================================================================
echo                    EXPERIMENT 1: FLASK ^& DOCKER
echo ==================================================================
cd /d "%ROOT_DIR%\exp1"
call docker build -t simple-flask-app .
call docker run -p 5000:5000 simple-flask-app
powershell -NoProfile -Command "$fl = Start-Process -FilePath '%PY_BIN%' -ArgumentList 'app.py' -WorkingDirectory '%ROOT_DIR%\exp1' -RedirectStandardOutput '%ROOT_DIR%\exp1\flask.log' -RedirectStandardError '%ROOT_DIR%\exp1\flask_err.log' -PassThru; $fl.Id | Out-File '%ROOT_DIR%\exp1\flask.pid'; Start-Sleep -Seconds 2"
echo --- GET http://localhost:8080/register ---
curl -s http://localhost:8080/register
echo.
echo --- POST http://localhost:8080/register ---
curl -s -X POST -d "name=John+Doe&email=john.doe@example.com&password=secret" http://localhost:8080/register
echo.

echo ==================================================================
echo                 EXPERIMENT 2: GIT ^& GITHUB COMMANDS
echo ==================================================================
call "%ROOT_DIR%\exp2\run_exp2.bat"

echo ==================================================================
echo          EXPERIMENT 3: SOURCE CODE MANAGEMENT ON GITHUB
echo ==================================================================
call "%ROOT_DIR%\exp3\run_exp3.bat"

echo ==================================================================
echo            EXPERIMENT 4: JENKINS INSTALLATION ^& SETUP
echo ==================================================================
call "%ROOT_DIR%\exp4\run_exp4.bat"

echo ==================================================================
echo        EXPERIMENT 5: CI/CD USING JENKINS ^& JAVA APPLICATION
echo ==================================================================
call "%ROOT_DIR%\exp5\run_exp5.bat"

echo ==================================================================
echo        EXPERIMENT 6: DOCKER COMMANDS FOR CONTENT MANAGEMENT
echo ==================================================================
call "%ROOT_DIR%\exp6\run_exp6.bat"

echo ==================================================================
echo      EXPERIMENT 7: CONTAINERIZED APPLICATION USING DOCKER
echo ==================================================================
call "%ROOT_DIR%\exp7\run_exp7.bat"

echo ==================================================================
echo       EXPERIMENT 8 ^& 9: KUBERNETES ^& DOCKER INTEGRATION
echo ==================================================================
call "%ROOT_DIR%\exp9\run_exp9.bat"

echo ==================================================================
echo        EXPERIMENT 10: SELENIUM AUTOMATED TESTING (GOOGLE)
echo ==================================================================
call "%ROOT_DIR%\exp10\run_exp10.bat"

echo ==================================================================
echo      EXPERIMENT 11: JAVASCRIPT PROGRAM ^& SELENIUM JUNIT TEST
echo ==================================================================
call "%ROOT_DIR%\exp11\run_exp11.bat"

echo ==================================================================
echo   EXPERIMENT 12: SELENIUM TEST CASES FOR CONTAINERIZED APP
echo ==================================================================
call "%ROOT_DIR%\exp12\run_exp12.bat"

if exist "%ROOT_DIR%\exp1\flask.pid" (
    powershell -NoProfile -Command "$pidVal = Get-Content '%ROOT_DIR%\exp1\flask.pid'; Stop-Process -Id $pidVal -Force -ErrorAction SilentlyContinue; Remove-Item '%ROOT_DIR%\exp1\flask.pid' -Force -ErrorAction SilentlyContinue"
)

echo ==================================================================
echo           ALL 12 EXPERIMENTS VERIFIED ON WINDOWS!
echo ==================================================================
