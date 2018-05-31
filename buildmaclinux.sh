#!/bin/sh
rm -r -f build/
cmake -H. -Bbuild
cmake --build ./build
./build/wxHello

