@echo off
REM IF "%1"=="" ( 
REM SET "arch=Win64"
REM ) ELSE ( 
REM SET "arch=%1"
REM )

REM IF "%arch%"=="Win64" ( 
REM SET "target=x64"
REM ) ELSE ( 
REM SET "target=Win32"
REM )

REM IF "%arch%"=="Win64" (
REM SET "generator=Visual Studio 15 2017 Win64"
REM ) ELSE (
REM SET "generator=Visual Studio 15 2017"
REM )

REM IF "%WX_VS_VER%"=="2019" ( 
REM SET "generator=Visual Studio 16 2019"
REM ) ELSE (
REM SET "generator=Visual Studio 15 2017"
REM )

REM IF "%2"=="" ( SET "build=Release" ) ELSE ( SET "build=%2" )
REM IF "%3"=="" ( SET "linking=static" ) ELSE ( SET "linking=%3" )

IF NOT EXIST .\wxWidgets-3.1.2.7z (
powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.2/wxWidgets-3.1.2.7z -OutFile .\wxWidgets-3.1.2.7z"
)

IF NOT EXIST .\Get-ExecutableType.ps1 (
powershell -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest https://gallery.technet.microsoft.com/scriptcenter/Identify-16-bit-32-bit-and-522eae75/file/111292/4/Get-ExecutableType.ps1 -OutFile .\Get-ExecutableType.ps1"
)

WHERE 7z
IF %ERRORLEVEL% NEQ 0 (
ECHO 7z command not found. Please install 7zip and make sure it is in your path.
EXIT /B
)
7z x .\wxWidgets-3.1.2.7z -o"wxWidgets-3.1.2" -aoa

IF "%linking%"=="static" (
SET SHARED=OFF
) ELSE (
SET SHARED=ON
)

IF "%WX_INSTALL_PATH%"=="" SET WX_INSTALL_PATH=C:\wxlibs
echo Installing wxWidgets to directory %WX_INSTALL_PATH%".
echo You can change destination modifying WX_INSTALL_PATH environment variable.