@echo off
IF EXIST %VCPKG% (
echo Make sure your VCPKG directory is not conflicting with this build.
echo It is recommended to rename your %VCPKG% directory temporarily to %VCPKG%.old
pause
)
CALL initwx.bat
IF "%1"=="" ( 
echo Please specify build conf
echo For example: installwx.bat Win64 Release static samples
GOTO END
)

CALL buildwx.bat %1 %2 %3 %4

REM it works only when both Debug and Release exists
if not exist %WX_INSTALL_PATH%\lib\vc_lib\mswu GOTO SKIP
if not exist %WX_INSTALL_PATH%\lib\vc_lib\mswud GOTO SKIP
CALL installed_library_minimal_test.bat

:SKIP
CALL build-wxhello.bat  %1 %2 %3
:END
