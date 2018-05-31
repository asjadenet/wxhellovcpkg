# wxhellovcpkg
Simple sample wxWidgets CMake project for all platforms, especially using [Vcpkg](https://github.com/Microsoft/vcpkg) and Visual Studio on Windows
## Overview
There has not been an almost standard way to organize C++ development packages on Windows. 
On Linux or MasOS it's much simpler.
Microsoft [Vcpkg](https://github.com/Microsoft/vcpkg) is quite a good package manager for Windows, that can help a lot. It was hard to get started with wxWidgets and it could take hours to everything set up. Here is simple sample project for a quick start. C++ layout files are generated with [wxFormBuilder](https://github.com/wxFormBuilder/wxFormBuilder).

## Prerequisites:
- Windows 10, 8.1, 7, Linux, or MacOS
- Visual Studio 2017 or Visual Studio 2015 Update 3 (on Windows)
- Git
- CMake
- [wxFormBuilder](https://github.com/wxFormBuilder/wxFormBuilder)

# Quick Start

## Windows

### Visual Studio and Vcpkg
First, install [Vcpkg](https://github.com/Microsoft/vcpkg) according to instructions.
You can install wxWidgets all available targets:

```
.\vcpkg install wxwidgets:x64-windows
.\vcpkg install wxwidgets:x64-windows-static
.\vcpkg install wxwidgets:x86-windows
.\vcpkg install wxwidgets:x86-windows-static
```
Batch file *buildmsvc.bat* is using environment variable *VCPKG*. Set it according to your Vcpkg directory location before running:
```
SET VCPKG=C:\VCPKG
```
Then clone git directory and build:
```
git clone https://github.com/asjadenet/wxhellovcpkg.git
cd wxhellovcpkg
buildmsvc.bat
```

### MSYS2
Install build environment and all dependencies. Here is example how to install cmake and wxWidgets:
```
pacman -S mingw-w64-i686-cmake mingw-w64-x86_64-cmake
pacman -S mingw-w64-i686-wxWidgets mingw-w64-x86_64-wxWidgets
```
Then clone git directory and build:
```
git clone https://github.com/asjadenet/wxhellovcpkg.git
cd wxhellovcpkg
```
In 64-bit shell run:
```
./buildmsys64.sh
```
In 32-bit shell run:
```
./buildmsys32.sh
```
## Linux
Your can install wxwidgets on Ununtu Linux using command:
```
sudo apt-get install libwxgtk3.0-dev
```
Then clone git directory and build:
```
git clone https://github.com/asjadenet/wxhellovcpkg.git
cd wxhellovcpkg
chmod +x buildmaclinux.sh
./buildmaclinux.sh
```
Note:

If you get error warning like this:
```
Warning: Mismatch between the program and library build versions detected.
The library used 3.0 (wchar_t,compiler with C++ ABI 1009,wx containers,compatible with 2.8),
and your program used 3.0 (wchar_t,compiler with C++ ABI 1011,wx containers,compatible with 2.8).
```
It's better to install wxWidgets from source using:
```
sudo apt-get install libgtk-3-dev
./configure
make
sudo make install
sudo  ldconfig
```
## Mac OS X
Your can just install wxwidgets using command:
```
brew install wxmac
```
Then clone git directory and build:
```
git clone https://github.com/asjadenet/wxhellovcpkg.git
cd wxhellovcpkg
chmod +x buildmaclinux.sh
./buildmaclinux.sh
```
