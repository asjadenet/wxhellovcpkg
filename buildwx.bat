@echo off
cd wxWidgets-3.2.2
IF "%WX_INSTALL_PATH%"=="" (
ECHO Environment variable WX_INSTALL_PATH is NOT defined, for example SET WX_INSTALL_PATH=C:\wxlibs
EXIT /B
)
cmake --version
REM vcpkg integrate remove

REM set GENERATOR=Visual Studio 15 2017 Win64

IF "%1"=="" ( 
SET "arch=Win64"
) ELSE ( 
SET "arch=%1"
)


SET "generator=Visual Studio 17 2022"

IF "%arch%"=="Win64" ( 
SET "target=x64"
) ELSE ( 
SET "target=Win32"
)

echo using generator %GENERATOR%
echo using target %TARGET%

SET "build=%2"

if "%BUILD%"=="" (
SET "build=Release"
)

echo using build %BUILD%

if "%linking%"=="" (
IF "%3"=="" ( SET "linking=static" ) ELSE ( SET "linking=%3" )
)

IF "%4"=="" ( SET "samples=SOME" ) ELSE ( SET "samples=ALL" )

IF "%linking%"=="static" (
SET SHARED=OFF
) ELSE (
SET SHARED=ON
)

if "%SKIPTESTS%"=="1" (
    set BUILD_TESTS=OFF
) else (
    set BUILD_TESTS=ALL
)
echo.
echo --- Generating project files
echo.

if "%WX_INSTALL_PATH%"=="" set WX_INSTALL_PATH=C:\third_cpp
if not exist %WX_INSTALL_PATH% mkdir %WX_INSTALL_PATH%
if exist build_cmake rmdir /S /Q build_cmake
mkdir build_cmake
pushd build_cmake
cmake -G "%GENERATOR%" -A %target% -DWXUSINGDLL=ON -DwxBUILD_SAMPLES=%samples% -DwxBUILD_TESTS=%BUILD_TESTS% -DCMAKE_INSTALL_PREFIX=%WX_INSTALL_PATH% -DwxBUILD_SHARED=%SHARED% %CMAKE_CONFIGURE_FLAGS% ..
if ERRORLEVEL 1 goto error
echo.
echo --- Starting the %BUILD% build
echo.
cmake --build . --config %BUILD% -- %CMAKE_NATIVE_FLAGS%
if ERRORLEVEL 1 goto error


:cmake_test
if NOT "%SKIPINSTALL%"=="1" (
    echo.
    echo --- Installing
    echo.
    cmake --build . --config %BUILD% --target install -- 
    if ERRORLEVEL 1 goto error
    popd
)
popd
cd ..
goto :eof

:error
echo.
echo --- Build failed !
echo.
