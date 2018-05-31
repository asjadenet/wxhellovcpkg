#!/bin/sh
rm -r -f msys2build64/
cmake -G "MSYS Makefiles" -H. -Bmsys2build64
cmake --build ./msys2build64
./msys2build64/wxHello.exe

