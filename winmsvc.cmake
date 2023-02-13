if(NOT LINKING_TYPE)
    message(FATAL_ERROR "Please specify -DLINKING_TYPE=static or -DLINKING_TYPE=dynamic")
    return()
endif()

if(NOT CMAKE_TOOLCHAIN_FILE)
    message(FATAL_ERROR "Please specify CMAKE_TOOLCHAIN_FILE, for example -DCMAKE_TOOLCHAIN_FILE=C:\vcpkg\scripts\buildsystems\vcpkg.cmake")
    message(FATAL_ERROR "Please clean CMake cache and start again")
    return()
endif()


if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    if(LINKING_TYPE MATCHES "static")
        set(VCPKG_TARGET_TRIPLET "x64-windows-static")
    else()
        set(VCPKG_TARGET_TRIPLET "x64-windows")
    endif()
else()
    if(LINKING_TYPE MATCHES "static")
        set(VCPKG_TARGET_TRIPLET "x86-windows-static")
    else()
        set(VCPKG_TARGET_TRIPLET "x86-windows")
    endif()
endif()

message(STATUS "VCPKG_TARGET_TRIPLET:${VCPKG_TARGET_TRIPLET}")

if (VCPKG_TARGET_TRIPLET MATCHES "static")
    message(STATUS "static")
    add_definitions(-D_UNICODE -DUNICODE -DwxUSE_GUI=1 -D__WXMSW__)
    set(CompilerFlags
        CMAKE_CXX_FLAGS
        CMAKE_CXX_FLAGS_DEBUG
        CMAKE_CXX_FLAGS_RELEASE
        CMAKE_C_FLAGS
        CMAKE_C_FLAGS_DEBUG
        CMAKE_C_FLAGS_RELEASE
        )
    foreach(CompilerFlag ${CompilerFlags})
      string(REPLACE "/MD" "/MT" ${CompilerFlag} "${${CompilerFlag}}")
    endforeach()
else()
    message(STATUS "dynamic")
    add_definitions(-D_UNICODE -DUNICODE -DWXUSINGDLL -DwxUSE_GUI=1 -D__WXMSW__)
endif()

if("${CMAKE_BUILD_TYPE}" MATCHES "Debug")
	add_definitions(-D_DEBUG)
	include_directories(${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib/mswud ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include)
	set(wxWidgets_LIB_DIR ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib)
	set(wxWidgets_LIBRARIES
		${wxWidgets_LIB_DIR}/wxbase32ud_net.lib
		${wxWidgets_LIB_DIR}/wxmsw32ud_core.lib
		${wxWidgets_LIB_DIR}/wxbase32ud.lib
        ${wxWidgets_LIB_DIR}/libpng16d.lib
        ${wxWidgets_LIB_DIR}/zlibd.lib
        comctl32 Rpcrt4
		)
elseif("${CMAKE_BUILD_TYPE}" MATCHES "Release")
	include_directories(${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib/mswu ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include)
	set(wxWidgets_LIB_DIR ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib)
	set(wxWidgets_LIBRARIES
		${wxWidgets_LIB_DIR}/wxbase32u_net.lib
		${wxWidgets_LIB_DIR}/wxmsw32u_core.lib
		${wxWidgets_LIB_DIR}/wxbase32u.lib
        ${wxWidgets_LIB_DIR}/libpng16.lib
        ${wxWidgets_LIB_DIR}/zlib.lib
        comctl32 Rpcrt4
		)
endif()

#if (NOT VCPKG_TARGET_TRIPLET MATCHES "static")
#file(COPY ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/bin/pcre2-16.dll DESTINATION ${APP_BIN_PATH}${CMAKE_BUILD_TYPE})
#endif()