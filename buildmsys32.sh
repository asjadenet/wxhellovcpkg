#!/bin/sh
rm -r -f msys2build32/
cmake -G "MSYS Makefiles" -H. -Bmsys2build32
cmake --build ./msys2build32
./msys2build32/wxHello.exe

