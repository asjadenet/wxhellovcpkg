echo.
echo --- Test installed library
echo.
if exist build_%BUILD%_%arch%_%linking%_minimal RMDIR /S /Q build_%BUILD%_%arch%_%linking%_minimal
mkdir build_%BUILD%_%arch%_%linking%_minimal
pushd build_%BUILD%_%arch%_%linking%_minimal
echo --- Configure minimal sample
cmake -G "%GENERATOR%" -A %target% ..\samples\minimal -DwxWidgets_DIR=%WX_INSTALL_PATH%/lib/cmake/wxWidgets
if ERRORLEVEL 1 goto error
echo --- Building minimal sample with installed library
cmake --build . --config %BUILD% -- 
if ERRORLEVEL 1 goto error
popd