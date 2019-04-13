@echo off
cd wxWidgets-3.1.2
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
REM set WX_INSTALL_PATH=%HOMEDRIVE%%HOMEPATH%\wx_install_target
REM set WX_INSTALL_PATH=E:\cpp-pkg
if "%WX_INSTALL_PATH%"=="" set WX_INSTALL_PATH=C:\third_cpp
if not exist %WX_INSTALL_PATH% mkdir %WX_INSTALL_PATH%
if exist build_cmake rmdir /S /Q build_cmake
mkdir build_cmake
pushd build_cmake
cmake -G "%GENERATOR%" -A %target% -DwxBUILD_TESTS=%BUILD_TESTS% -DCMAKE_INSTALL_PREFIX=%WX_INSTALL_PATH% -DwxBUILD_SHARED=%SHARED% %CMAKE_CONFIGURE_FLAGS% ..
if ERRORLEVEL 1 goto error
echo.
echo --- Starting the build
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

    echo.
    echo --- Test installed library
    echo.
    set WXWIN=%WX_INSTALL_PATH%
	if exist build_%BUILD%_%arch%_%linking%_minimal RMDIR /S /Q build_%BUILD%_%arch%_%linking%_minimal
    mkdir build_%BUILD%_%arch%_%linking%_minimal
    pushd build_%BUILD%_%arch%_%linking%_minimal
    echo --- Configure minimal sample
    cmake -G "%GENERATOR%" -A %target% ..\samples\minimal
    if ERRORLEVEL 1 goto error
    echo --- Building minimal sample with installed library
    cmake --build . --config %BUILD% -- 
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
