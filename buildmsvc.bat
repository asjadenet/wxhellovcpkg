@echo off
IF "%VCPKG%"=="" (
ECHO Environment variable VCPKG is NOT defined, for example SET VCPKG=C:\VCPKG
EXIT /B
)
IF "%1"=="" ( 
SET "arch=Win64"
) ELSE ( 
SET "arch=%1"
)
IF "%arch%"=="Win64" (
SET "generator=Visual Studio 15 2017 Win64"
) ELSE (
SET "generator=Visual Studio 15 2017"
)
IF "%2"=="" ( SET "build=Release" ) ELSE ( SET "build=%2" )
IF "%3"=="" ( SET "linking=static" ) ELSE ( SET "linking=%3" )
set "builddir=%build%%arch%%linking%" 
RMDIR .\%builddir% /S /Q
echo Building %build% %arch% using %linking% libraries..
cmake -G "%generator%" -DCMAKE_BUILD_TYPE=%build% -H. -B%builddir% -DCMAKE_TOOLCHAIN_FILE=%VCPKG%\scripts\buildsystems\vcpkg.cmake -DLINKING_TYPE=%linking%
cmake --build .\%builddir% --config %build%
echo starting application %builddir%\%build%\wxHello.exe
%builddir%\%build%\wxHello.exe