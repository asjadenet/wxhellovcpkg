PUSHD
CALL renvcpkg.bat %VCPKG%
CALL initwx.bat
CALL buildwx.bat %1 %2 %3 %4
POPD
CALL build-wxhello.bat  %1 %2 %3
CALL renvcpkg-back.bat %VCPKG%
