# wxhellovcpkg
Simple sample wxWidgets CMake project for all platforms, especially using [Vcpkg](https://github.com/Microsoft/vcpkg) and Visual Studio on Windows
## Overview
There has not been an almost standard way to organize C++ development packages on Windows. 
On Linux or MacOS it's much simpler.
Microsoft [Vcpkg](https://github.com/Microsoft/vcpkg) is quite a good package manager for Windows, that can help a lot. It was hard to get started with wxWidgets and it could take hours to everything set up. Here is simple sample project for a quick start. C++ layout files are generated with [wxFormBuilder](https://github.com/wxFormBuilder/wxFormBuilder).

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

| Build status          | Systems / Compilers         |   CI    |
| ----------------------|-----------------------------|---------|
|[![Build status](https://ci.appveyor.com/api/projects/status/nwy0sbejq3g43l0i/branch/master?svg=true)](https://ci.appveyor.com/project/asjadenet/wxhellovcpkg-68a32/branch/master)|Windows VCPKG|AppVeyor|
|[![Build status](https://ci.appveyor.com/api/projects/status/npa74uehfufer6hl/branch/master?svg=true)](https://ci.appveyor.com/project/asjadenet/wxhellovcpkg-jgqmr)|Windows wxWidgets source Win64|AppVeyor|
|[![Build status](https://ci.appveyor.com/api/projects/status/jxo9banw18at40wr/branch/master?svg=true)](https://ci.appveyor.com/project/asjadenet/wxhellovcpkg-u9bdg)|Windows wxWidgets source Win32|AppVeyor|
|[![Build status](https://ci.appveyor.com/api/projects/status/bim8mq9csh0u6eeq?svg=true)](https://ci.appveyor.com/project/asjadenet/wxhellovcpkg)|Ununtu Linux GNU 5.4.0|AppVeyor|
|[![Build status](https://ci.appveyor.com/api/projects/status/n71pdgf75njvqh1t?svg=true)](https://ci.appveyor.com/project/asjadenet/wxhellovcpkg-b5on7)|MacOS|AppVeyor|

## Prerequisites:
- Windows 10, 8.1, 7, Linux, or MacOS
- Visual Studio 2017 or Visual Studio 2019 (on Windows)
- Git
- CMake (version 3.14 or later for Visual Studio 2019)
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

You can specify different targets using command line arguments. For example:

```
buildmsvc.bat Win32 Debug dynamic
```

For using Visual Studio 2019, set envionment variable WX_VS_VER before building:

```
SET WX_VS_VER=2019
```

### Visual Studio and building from source
Sometimes it's better to build wxWidgets libraries from source. For example, source code examples are easier to build and run. Use batch file installwx.bat for this:

Environment variable WX_INSTALL_PATH default value is C:\wxlibs, but you can modify it whenever you want to put wxWidgets libraries and headers.

```
installwx.bat
```
It calls batch file initwx.bat. 7zip is necessary for unzipping. Make sure 7z is in your path.

For different targets use command line arguments:

```
installwx.bat Win32 Debug dynamic
```

If you want to build samples also, add fourth parameter *samples*.

```
installwx.bat Win64 Release static samples
```

For using Visual Studio 2019, set envionment variable WX_VS_VER before building:

```
SET WX_VS_VER=2019
```

If you want to modify helloworld app source code and build, it's necessary only to call build-wxhello.bat.

```
build-wxhello.bat
```

For different targets use command line arguments:

```
build-wxhello.bat Win32 Release static
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
Your can install wxwidgets on Ubuntu Linux using command:
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
