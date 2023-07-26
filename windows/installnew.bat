@echo on

set scriptVersion=1.0.0.0
set "bits32=false"

@REM Get Windows version and architecture
@REM /////////////////////////////////////////////////////////////////////////////////////////////////////////////

@REM Check Windows version
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

@REM Check architecture
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

@REM Check if 32 bit or 64 bit
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
set ExtnFilename=plgx_win_extension.ext.exe
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

@REM Create necessary directories
mkdir "%ProgramFiles%\osquery"
mkdir "%ProgramFiles%\osquery\osqueryd"
mkdir "%ProgramFiles%\osquery\packs"
mkdir "%ProgramFiles%\osquery\log"
mkdir "%ProgramFiles%\osquery\certs"

REM Copy files

echo %~dp0%OsquerydFilename%
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

@REM Set the service variables

set kServiceName=osqueryd
set kServiceDescription=osquery daemon service
set kServiceDisplayName=osqueryd
set kServiceBinaryPath="%ProgramFiles%\osquery\osqueryd\osqueryd.exe"
set welManifestPath="%ProgramFiles%\osquery\osquery.man"
set startupArgs=--flagfile="%ProgramFiles%\osquery\osquery.flags"

echo %kServiceName%
echo %kServiceDescription%
echo %kServiceDisplayName%
echo %kServiceBinaryPath%
echo %welManifestPath%
echo %startupArgs%


@REM Create the service
@REM sc create %kServiceName% binPath= %kServiceBinaryPath% %startupArgs% start= auto DisplayName= %kServiceDisplayName% description= %kServiceDescription%

@REM sc create osqueryd binPath= "C:\osquery\osqueryd\osqueryd.exe --flagfile C:\Program Files\osquery\osquery.flags" start= auto DisplayName= osqueryd

REM Check if the service was created successfully
if %errorlevel% equ 0 (
    echo Service created successfully.
) else (
    echo Failed to create service.
)
pause