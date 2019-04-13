CALL renvcpkg.bat %VCPKG%
CALL initwx.bat
CALL buildwx.bat %1 %2 %3
CALL build-wxhello.bat  %1 %2 %3
CALL renvcpkg-back.bat %VCPKG%
