@echo off
CALL renvcpkg.bat %VCPKG%
IF "%1"=="" ( 
SET "arch=Win64"
) ELSE ( 
SET "arch=%1"
)
REM IF "%arch%"=="Win64" (
REM SET "generator=Visual Studio 15 2017 Win64"
REM ) ELSE (
REM SET "generator=Visual Studio 15 2017"
REM )

IF "%WX_VS_VER%"=="2019" ( 
SET "generator=Visual Studio 16 2019"
) ELSE (
SET "generator=Visual Studio 15 2017"
)

IF "%arch%"=="Win64" ( 
SET "target=x64"
) ELSE ( 
SET "target=Win32"
)

echo using generator %GENERATOR%
echo using target %TARGET%

if "%BUILD%"=="" (
IF "%2"=="" ( SET "build=Release" ) ELSE ( SET "build=%2" )
)
if "%linking%"=="" (
IF "%3"=="" ( SET "linking=static" ) ELSE ( SET "linking=%3" )
)
if "%WX_INSTALL_PATH%"=="" set WX_INSTALL_PATH=C:\wxlibs
IF not exist %WX_INSTALL_PATH% (
ECHO Installed wxWidgets directory %WX_INSTALL_PATH% does not exist, cannot continue
goto error
)

set WXWIN=%WX_INSTALL_PATH%
if exist build_%BUILD%_%arch%_%linking%_wxhello rmdir /S /Q build_%BUILD%_%arch%_%linking%_wxhello
mkdir build_%BUILD%_%arch%_%linking%_wxhello
pushd build_%BUILD%_%arch%_%linking%_wxhello
echo --- Configure wxhello sample
cmake -DWXSOURCE=On -G "%GENERATOR%" -A %target% -DCMAKE_BUILD_TYPE=%build% -DwxBUILD_SHARED=%SHARED% ..
if ERRORLEVEL 1 goto error
echo --- Building wxhello sample with installed library %WX_INSTALL_PATH%
cmake --build . --config %BUILD%
dir %build%\wxHello.exe

if ERRORLEVEL 1 goto error
:error
popd

Powershell.exe -executionpolicy remotesigned -command  ". .\Get-ExecutableType.ps1 ; Get-ExecutableType -Path   .\build_%BUILD%_%arch%_%linking%_wxhello\%build%\wxHello.exe"
CALL renvcpkg-back.bat %VCPKG%