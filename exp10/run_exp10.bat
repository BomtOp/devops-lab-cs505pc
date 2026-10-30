@echo off
setlocal
cd /d "%~dp0"
if exist "%~dp0..\tools\jdk\jdk-21\bin\java.exe" (
    set "PATH=%~dp0..\tools\jdk\jdk-21\bin;%PATH%"
)
set "CP=.;%~dp0..\tools\selenium\selenium-server.jar;%~dp0..\tools\selenium\junit-4.13.2.jar;%~dp0..\tools\selenium\hamcrest-core-1.3.jar"
javac -cp "%CP%" Main.java
java -ea -cp "%CP%" Main 2>nul
