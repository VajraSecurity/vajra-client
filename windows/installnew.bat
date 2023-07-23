@echo off

@REM Authon information
@Rem Last modified 24/07/2023
set scriptVersion=1.0.0.1
set "bits32=false"

    @REM Get Windows version and architecture
    @REM /////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @REM ver | findstr /i "10." > nul
    @REM if %errorlevel% equ 0 (
    @REM     set "windows_version=10"
    @REM ) else (
    @REM     reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | findstr /i "6.3." > nul
    @REM     if %errorlevel% equ 0 (
    @REM         set "windows_version=8"
    @REM     ) else (
    @REM         reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | findstr /i "6.2." > nul
    @REM         if %errorlevel% equ 0 (
    @REM             set "windows_version=8"
    @REM         ) else (
    @REM             reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | findstr /i "6.1." > nul
    @REM             if %errorlevel% equ 0 (
    @REM                 set "windows_version=7"
    @REM             ) else (
    @REM                 set "windows_version=Unsupported Windows version"
    @REM             )
    @REM         )
    @REM     )
    @REM )

@REM Get Windows version
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "10.0" set "windows_version=10"
if "%version%" == "6.3" set "windows_version=8.1"
if "%version%" == "6.2" set "windows_version=8"
if "%version%" == "6.1" set "windows_version=7"
if "%version%" == "6.0" set "windows_version=vista"
if "%version%" == "5.2" set "windows_version=XP64"
if "%version%" == "5.1" set "windows_version=XP"
if "%version%" == "5.0" set "windows_version=2000"
if "%version%" == "4.10" set "windows_version=98"

@REM Check architecture
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL
if %errorlevel% equ 0 (
    set "architecture=32"
    set "bits32=true"
) else (
    set "architecture=64"
    set "bits32=false"
)

@REM Set the service variables
set kServiceName=osqueryd
set kServiceDescription=osquery daemon service
set kServiceDisplayName=osqueryd
set kServiceBinaryPath="%ProgramFiles%\osquery\osqueryd\osqueryd.exe"
set welManifestPath="%ProgramFiles%\osquery\osquery.man"
set startupArgs=--flagfile="%ProgramFiles%\osquery\osquery.flags"


@REM Set filenames
set OsquerydFilename=osqueryd.exe
set VcFilePath=%~dp0x86\vc_redist.x86.exe
set filename = "x86\vc_redist.x86.exe"

echo VC Location is : %VcFilePath%
        if exist "%VcFilePath%" (
            set "Arguments=/install /passive /norestart"
            echo %VcFilePath% %Arguments%
            start %VcFilePath% /install /passive /norestart
        ) else (
            echo [-] Failed to find %VcFilePath% for installation, Please Check Manually that VC Redistributables are installed
            pause
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

echo Installing Vajra EDR client on your system. Your system is running on Windows %windows_version% %architecture% bits. 

REM Copy files
@REM if "%bits32%"=="false" (
@REM     copy /Y "%~dp0x64\%OsqueryFlagsFilename%" "%ProgramFiles%\osquery\osquery.flags"
@REM     copy /Y "%~dp0%ExtnFilename%" "%ProgramFiles%\osquery\%ExtnFilename%"
@REM     copy /Y "%~dp0%OsqueryManifestFilename%" "%ProgramFiles%\osquery\%OsqueryManifestFilename%"
@REM     copy /Y "%~dp0%OsqueryExtnLoadFilename%" "%ProgramFiles%\osquery\%OsqueryExtnLoadFilename%"
@REM )
@REM else (
@REM     copy /Y "%~dp0x86\%OsqueryFlagsFilename%" "%ProgramFiles%\osquery\osquery.flags"
@REM )
@REM copy /Y "%~dp0%OsquerydFilename%" "%ProgramFiles%\osquery\osqueryd\osqueryd.exe"
@REM copy /Y "%~dp0%OsqueryConfFilename%" "%ProgramFiles%\osquery\%OsqueryConfFilename%"
@REM copy /Y "%~dp0%OsqueryCertFilename%" "%ProgramFiles%\osquery\certs\%OsqueryCertFilename%"
@REM copy /Y "%~dp0%OsqueryEnrollmentSecretFilename%" "%ProgramFiles%\osquery\%OsqueryEnrollmentSecretFilename%"
@REM copy /Y "%~dp0%OsqueryPackFile1%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile1%"
@REM copy /Y "%~dp0%OsqueryPackFile2%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile2%"
@REM copy /Y "%~dp0%OsqueryPackFile3%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile3%"
@REM copy /Y "%~dp0%OsqueryPackFile4%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile4%"
@REM copy /Y "%~dp0%OsqueryPackFile5%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile5%"
@REM copy /Y "%~dp0%OsqueryPackFile6%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile6%"
@REM copy /Y "%~dp0%OsqueryPackFile7%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile7%"
@REM copy /Y "%~dp0%OsqueryPackFile8%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile8%"
@REM copy /Y "%~dp0%OsqueryPackFile9%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile9%"
@REM copy /Y "%~dp0%OsqueryPackFile10%" "%ProgramFiles%\osquery\packs\%OsqueryPackFile10%"

setlocal enabledelayedexpansion
set "SourceFolder=%~dp0"
set "ProgramFilesFolder=%ProgramFiles%\osquery"
set "CertFolderName=%ProgramFiles%\osquery\certs"
set "OsquerydFolderName=%ProgramFiles%\osquery\osqueryd"

if "%bits32%"=="false" (
    set "ArchSubfolder=x64"
    set "FilesToCopy=%OsqueryFlagsFilename% %ExtnFilename% %OsqueryManifestFilename% %OsqueryExtnLoadFilename%"
) else (
    set "ArchSubfolder=x86"
    set "FilesToCopy=%OsqueryFlagsFilename%"
)

for %%F in (%FilesToCopy%) do (
    echo "!SourceFolder!%ArchSubfolder%\%%F" "%ProgramFilesFolder%\%%F"
    copy /Y "!SourceFolder!%ArchSubfolder%\%%F" "%ProgramFilesFolder%\%%F"
)

for %%F in (%OsqueryConfFilename% %OsqueryEnrollmentSecretFilename% %OsqueryPackFile1% %OsqueryPackFile2% %OsqueryPackFile3% %OsqueryPackFile4% %OsqueryPackFile5% %OsqueryPackFile6% %OsqueryPackFile7% %OsqueryPackFile8% %OsqueryPackFile9% %OsqueryPackFile10%) do (
    echo "!SourceFolder!%%F" "%ProgramFilesFolder%\%%F"
    copy /Y "!SourceFolder!%%F" "%ProgramFilesFolder%\%%F"
)

@REM Copying osqueryd file 
echo "%SourceFolder%x%architecture%\%OsquerydFilename%" "%OsquerydFolderName%\%OsquerydFilename%"
copy /Y "%SourceFolder%x%architecture%\%OsquerydFilename%" "%OsquerydFolderName%\%OsquerydFilename%"

@REM Copying certificate file
echo "%SourceFolder%%OsqueryCertFilename%" "%CertFolderName%\%OsqueryCertFilename%"
copy /Y "%SourceFolder%%OsqueryCertFilename%" "%CertFolderName%\%OsqueryCertFilename%"

echo All files copied successfully!




@REM Create the service
@REM echo sc create %kServiceName% binPath= %kServiceBinaryPath% %startupArgs% start= auto DisplayName= %kServiceDisplayName% description= %kServiceDescription%

sc create osqueryd binPath= "\"C:\Program Files\osquery\osqueryd\osqueryd.exe\" \"--flagfile\" \"C:\Program Files\osquery\osquery.flags\" \"--allow_unsafe\"" start= auto DisplayName= osqueryd
sc start osqueryd

@REM sc create osqueryd binPath= "C:\Program Files\osquery\osqueryd\osqueryd.exe" --flagfile="C:\Program Files\osquery\osquery.flags" start= auto DisplayName= osqueryd description= osquery daemon service

REM Check if the service was created successfully
if %errorlevel% equ 0 (
    echo Service created successfully.
) else (
    echo Failed to create service.
)
pause