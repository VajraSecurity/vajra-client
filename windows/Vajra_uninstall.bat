@echo off

REM Vajra EDR client installer script
REM Author: Arjun Sable, IEOR, IIT Bombay
REM Date: 2023-07-25

set scriptVersion=1.0.0.1
set "bits32=false"
set "LogFile=vajra_uninstall_log.txt"
set kServiceName=vajra
set kServiceDescription=Vajra EDR client service
set kServiceDisplayName=vajra

echo [+] Cleaning up Vajra EDR client installation files

echo [+] Checking if Vajra EDR client is installed

sc query %kServiceName% | findstr /C:"SERVICE_NAME: %kServiceName%" >nul
if %errorlevel% neq 0 (
    echo [-] The Vajra EDR service does not exist
    pause
    exit /b 1
)


echo [+] Stopping the Vajra EDR service
sc stop %kServiceName% >nul 2>> "%LogFile%"
rmdir /s /q "%ProgramFiles%\osquery" >nul 2>> "%LogFile%"
if %errorlevel% equ 0 (
    echo [+] Cleared all the installation directories
) else (
    echo [-] Failed to clear all the installation directories
)

rmdir /s /q "%ProgramFiles%\plgx_osquery\" >nul 2>> "%LogFile%"

@REM Remove service
echo [+] Removing Vajra EDR client service

sc delete %kServiceName% >nul 2>> "%LogFile%"

echo [+] Cleanup completed

echo [+] Vajra EDR is successfully removed
pause 