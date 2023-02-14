#!/bin/sh
rm -r -f build/
cmake -H. -Bbuild
cmake --build ./build
ls -l ./build/wxHello

