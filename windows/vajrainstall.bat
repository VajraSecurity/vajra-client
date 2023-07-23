@echo off

set scriptVersion=1.0.0.0
set "bits32=false"

@REM Get Windows version and architecture
@REM /////////////////////////////////////////////////////////////////////////////////////////////////////////////
ver | findstr /i "10." > nul
if %errorlevel% equ 0 (
    set "windows_version=10"
) else (
    reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | findstr /i "6.3." > nul
    if %errorlevel% equ 0 (
        set "windows_version=8"
    ) else (
        reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | findstr /i "6.2." > nul
        if %errorlevel% equ 0 (
            set "windows_version=8"
        ) else (
            reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | findstr /i "6.1." > nul
            if %errorlevel% equ 0 (
                set "windows_version=7"
            ) else (
                set "windows_version=Unsupported Windows version"
            )
        )
    )
)
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL
if %errorlevel% equ 0 (
    set "architecture=32"
    set "bits32=true"
) else (
    set "architecture=64"
    set "bits32=false"
)

echo Windows Version: %windows_version%
echo System Architecture: %architecture%


@REM ////////////////////////////////////////////Set URLS/////////////////////////////////////////////////////////////////

if "%architecture%"=="32" (
    set osquerydDownloadUrl=https://github.com/VajraSecurity/vajra-client/raw/main/windows/x86/osqueryd.exe
    set osqueryFlagsDownloadUrl=https://github.com/VajraSecurity/vajra-client/raw/main/windows/x86/osquery.flags
    set vcredistDownloadUrl=https://github.com/VajraSecurity/vajra-client/raw/main/windows/x86/vc_redist.x86.exe
    set boostDllDownloadUrl=https://github.com/VajraSecurity/vajra-client/raw/main/windows/x86/boost_context-vc140-mt-x32-1_66.dll
) else (
    set osquerydDownloadUrl=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/osqueryd.exe
    set osqueryFlagsDownloadUrl=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/osquery.flags
    set extnDownloadUrl=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/plgx_win_extension.ext.exe
)

@REM set osqueryConfDownloadUrl=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/osquery.conf
@REM set osqueryEnrollmentSecretDownloadUrl=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/enrollment_secret.txt
@REM set osqueryCertDownloadUrl=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/certs/cert.pem
@REM set osqueryManifestDownloadUrl=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/osquery.man
@REM set extnLoadDownloadUrl=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/extensions.load

@REM REM Globals for packs files
@REM set osqueryPack1Url=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/packs/hardware-monitoring.conf
@REM set osqueryPack2Url=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/packs/incident-response.conf
@REM set osqueryPack3Url=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/packs/it-compliance.conf
@REM set osqueryPack4Url=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/packs/osquery-monitoring.conf
@REM set osqueryPack5Url=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/packs/ossec-rootkit.conf
@REM set osqueryPack6Url=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/packs/osx-attacks.conf
@REM set osqueryPack7Url=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/packs/unwanted-chrome-extensions.conf
@REM set osqueryPack8Url=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/packs/vuln-management.conf
@REM set osqueryPack9Url=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/packs/windows-attacks.conf
@REM set osqueryPack10Url=https://github.com/VajraSecurity/Osquery-Hands-on/raw/main/Osquery/packs/windows-hardening.conf

@REM REM Define the DownloadFileFromUrl function
@REM :DownloadFileFromUrl
@REM powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%~1', '%~2')"

@REM REM Download the files
@REM call :DownloadFileFromUrl %osquerydDownloadUrl% osqueryd.exe
@REM call :DownloadFileFromUrl %osqueryFlagsDownloadUrl% osquery.flags
@REM call :DownloadFileFromUrl %osqueryConfDownloadUrl% osquery.conf
@REM call :DownloadFileFromUrl %osqueryEnrollmentSecretDownloadUrl% enrollment_secret.txt
@REM call :DownloadFileFromUrl %osqueryCertDownloadUrl% cert.pem
@REM call :DownloadFileFromUrl %osqueryManifestDownloadUrl% osquery.man
@REM call :DownloadFileFromUrl %extnLoadDownloadUrl% extensions.load
@REM call :DownloadFileFromUrl %osqueryPack1Url% hardware-monitoring.conf
@REM call :DownloadFileFromUrl %osqueryPack2Url% incident-response.conf
@REM call :DownloadFileFromUrl %osqueryPack3Url% it-compliance.conf
@REM call :DownloadFileFromUrl %osqueryPack4Url% osquery-monitoring.conf
@REM call :DownloadFileFromUrl %osqueryPack5Url% ossec-rootkit.conf
@REM call :DownloadFileFromUrl %osqueryPack6Url% osx-attacks.conf
@REM call :DownloadFileFromUrl %osqueryPack7Url% unwanted-chrome-extensions.conf
@REM call :DownloadFileFromUrl %osqueryPack8Url% vuln-management.conf
@REM call :DownloadFileFromUrl %osqueryPack9Url% windows-attacks.conf
@REM call :DownloadFileFromUrl %osqueryPack10Url% windows-hardening.conf

@REM REM Optional: Display a message for each successful download
@REM echo Download completed successfully.


@REM @REM \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\Set filenames\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
set ExtnFilename=plgx_win_extension.ext.exe
if "%bits32%"=="true" (
    if not exist "%cd%\x86" (
        mkdir "%cd%\x86"
    )
    set OsquerydFilename=x86\osqueryd.exe
) else (
    if not exist "%cd%\x64" (
        mkdir "%cd%\x64"
    )
    set OsquerydFilename=x64\osqueryd.exe
)
set OsqueryConfFilename=osquery.conf
set OsqueryFlagsFilename=osquery.flags
set OsqueryExtnLoadFilename=extensions.load
set OsqueryCertFilename=cert.pem
set OsqueryEnrollmentSecretFilename=enrollment_secret.txt
set vcredistFileName=vc_redist.x86.exe
set boostDllFileName=boost_context-vc140-mt-x32-1_66.dll
set OsqueryManifestFilename=osquery.man
set OsqueryPackFile1=hardware-monitoring.conf
set OsqueryPackFile2=incident-response.conf
set OsqueryPackFile3=it-compliance.conf
set OsqueryPackFile4=osquery-monitoring.conf
set OsqueryPackFile5=ossec-rootkit.conf
set OsqueryPackFile6=osx-attacks.conf
set OsqueryPackFile7=unwanted-chrome-extensions.conf
set OsqueryPackFile8=vuln-management.conf
set OsqueryPackFile9=windows-attacks.conf
set OsqueryPackFile10=windows-hardening.conf



@REM \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\Copy files\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

:CopyFilesToDirectory
REM Create directories
mkdir "%ProgramFiles%\osquery"
mkdir "%ProgramFiles%\osquery\osqueryd"
mkdir "%ProgramFiles%\osquery\packs"
mkdir "%ProgramFiles%\osquery\log"
mkdir "%ProgramFiles%\osquery\certs"

REM Copy files
copy /Y "%~dp0%OsquerydFilename%" "%ProgramFiles%\osquery\osqueryd\osqueryd.exe"
copy /Y "%~dp0%OsqueryConfFilename%" "%ProgramFiles%\osquery\%OsqueryConfFilename%"
copy /Y "%~dp0%OsqueryCertFilename%" "%ProgramFiles%\osquery\certs\%OsqueryCertFilename%"
copy /Y "%~dp0%OsqueryEnrollmentSecretFilename%" "%ProgramFiles%\osquery\%OsqueryEnrollmentSecretFilename%"

if "%architecture%"=="64" (
    copy /Y "%~dp0x64\%OsqueryFlagsFilename%" "%ProgramFiles%\osquery\osquery.flags"
) else (
    copy /Y "%~dp0x86\%OsqueryFlagsFilename%" "%ProgramFiles%\osquery\osquery.flags"
)

if "%bits32%"=="false" (
    copy /Y "%~dp0%ExtnFilename%" "%ProgramFiles%\osquery\%ExtnFilename%"
    copy /Y "%~dp0%OsqueryManifestFilename%" "%ProgramFiles%\osquery\%OsqueryManifestFilename%"
    copy /Y "%~dp0%OsqueryExtnLoadFilename%" "%ProgramFiles%\osquery\%OsqueryExtnLoadFilename%"
)

copy /Y "%~dp0%OsqueryPackFile1%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile1%"
copy /Y "%~dp0%OsqueryPackFile2%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile2%"
copy /Y "%~dp0%OsqueryPackFile3%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile3%"
copy /Y "%~dp0%OsqueryPackFile4%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile4%"
copy /Y "%~dp0%OsqueryPackFile5%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile5%"
copy /Y "%~dp0%OsqueryPackFile6%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile6%"
copy /Y "%~dp0%OsqueryPackFile7%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile7%"
copy /Y "%~dp0%OsqueryPackFile8%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile8%"
copy /Y "%~dp0%OsqueryPackFile9%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile9%"
copy /Y "%~dp0%OsqueryPackFile10%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile10%"


set kServiceName=osqueryd
set kServiceDescription=osquery daemon service
set kServiceBinaryPath="%ProgramFiles%\osquery\osqueryd\osqueryd.exe"
set welManifestPath="%ProgramFiles%\osquery\osquery.man"
set startupArgs=--flagfile="%ProgramFiles%\osquery\osquery.flags"

REM Set the service variables
set kServiceBinaryPath="%ProgramFiles%\osquery\osqueryd\osqueryd.exe"
set kServiceName=osqueryd
set kServiceDisplayName=osqueryd
set kServiceDescription=osquery daemon service

REM Create the service
sc create %kServiceName% binPath= %kServiceBinaryPath% start= auto DisplayName= %kServiceDisplayName% description= %kServiceDescription%

REM Check if the service was created successfully
if %errorlevel% equ 0 (
    echo Service created successfully.
) else (
    echo Failed to create service.
)
pause
