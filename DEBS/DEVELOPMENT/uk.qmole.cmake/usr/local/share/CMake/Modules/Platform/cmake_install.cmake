# Install script for directory: /home/chris/cmake-2.3.4-20060317/Modules/Platform

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/usr/local")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME Release)
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT CMAKE_INSTALL_CONFIG_NAME)

FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/AIX.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/BSDOS.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/CYGWIN-g77.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/CYGWIN.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Darwin-xlc.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Darwin.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/FreeBSD.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/HP-UX.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/IRIX.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/IRIX64.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Linux-como.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Linux-icpc.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Linux-ifort.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Linux.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/MP-RAS.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/NetBSD.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/OSF1.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/OpenBSD.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/QNX.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/RISCos.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/SCO_SV.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/SINIX.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/SunOS.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Tru64.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/ULTRIX.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/UNIX_SV.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/UnixPaths.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/UnixWare.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Windows-bcc32.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Windows-cl.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Windows-g++.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Windows-g77.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Windows-gcc.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Windows-icl.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Windows-ifort.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Windows-wcl386.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Windows.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/WindowsPaths.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Xenix.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/cmake_install.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/g77.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/gcc.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/kFreeBSD.cmake")
FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/CMake/Modules/Platform" TYPE FILE FILES "/home/chris/cmake-2.3.4-20060317/Modules/Platform/Windows-cl.cmake.in")
