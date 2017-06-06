# try to load any previously computed information for C on this platform
INCLUDE( ${CMAKE_BINARY_DIR}/CMakeFiles/CMakeCPlatform.cmake OPTIONAL)
# try to load any previously computed information for CXX on this platform
INCLUDE( ${CMAKE_BINARY_DIR}/CMakeFiles/CMakeCXXPlatform.cmake OPTIONAL)

SET(CMAKE_LIBRARY_PATH_FLAG "-LIBPATH:")
SET(CMAKE_LINK_LIBRARY_FLAG "")
SET(WIN32 1)
SET(MSVC 1)
IF(CMAKE_VERBOSE_MAKEFILE)
  SET(CMAKE_CL_NOLOGO)
ELSE(CMAKE_VERBOSE_MAKEFILE)
  SET(CMAKE_CL_NOLOGO "/nologo")
ENDIF(CMAKE_VERBOSE_MAKEFILE)
# create a shared C++ library 
SET(CMAKE_CXX_CREATE_SHARED_LIBRARY 
  "link ${CMAKE_CL_NOLOGO} ${CMAKE_START_TEMP_FILE} /out:<TARGET> /dll  <LINK_FLAGS> <OBJECTS> <LINK_LIBRARIES> ${CMAKE_END_TEMP_FILE}")
SET(CMAKE_CXX_CREATE_SHARED_MODULE "${CMAKE_CXX_CREATE_SHARED_LIBRARY}")

# create a C shared library
SET(CMAKE_C_CREATE_SHARED_LIBRARY "${CMAKE_CXX_CREATE_SHARED_LIBRARY}")

# create a C shared module just copy the shared library rule
SET(CMAKE_C_CREATE_SHARED_MODULE "${CMAKE_C_CREATE_SHARED_LIBRARY}")

# create a C++ static library
SET(CMAKE_CXX_CREATE_STATIC_LIBRARY  "lib ${CMAKE_CL_NOLOGO} <LINK_FLAGS> /out:<TARGET> <OBJECTS> ")

# create a C static library
SET(CMAKE_C_CREATE_STATIC_LIBRARY "${CMAKE_CXX_CREATE_STATIC_LIBRARY}")

# compile a C++ file into an object file
SET(CMAKE_CXX_COMPILE_OBJECT
    "<CMAKE_CXX_COMPILER>  ${CMAKE_START_TEMP_FILE}  ${CMAKE_CL_NOLOGO} <FLAGS>  /TP /Fo<OBJECT> -c <SOURCE>${CMAKE_END_TEMP_FILE}")

# compile a C file into an object file
SET(CMAKE_C_COMPILE_OBJECT
    "<CMAKE_C_COMPILER> ${CMAKE_START_TEMP_FILE} ${CMAKE_CL_NOLOGO} <FLAGS> /Fo<OBJECT>   -c <SOURCE>${CMAKE_END_TEMP_FILE}")


SET(CMAKE_C_LINK_EXECUTABLE
    "<CMAKE_C_COMPILER> ${CMAKE_CL_NOLOGO} ${CMAKE_START_TEMP_FILE} <FLAGS> <OBJECTS> /Fe<TARGET> -link <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <LINK_LIBRARIES>${CMAKE_END_TEMP_FILE}")

SET(CMAKE_CXX_LINK_EXECUTABLE
    "<CMAKE_CXX_COMPILER> ${CMAKE_CL_NOLOGO} ${CMAKE_START_TEMP_FILE} <FLAGS> <OBJECTS> /Fe<TARGET> -link <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <LINK_LIBRARIES>${CMAKE_END_TEMP_FILE}")

SET(CMAKE_CREATE_WIN32_EXE /subsystem:windows)
SET(CMAKE_CREATE_CONSOLE_EXE /subsystem:console)

IF(CMAKE_GENERATOR MATCHES "Visual Studio 6")
   SET (CMAKE_NO_BUILD_TYPE 1)
ENDIF(CMAKE_GENERATOR MATCHES "Visual Studio 6")
IF(CMAKE_GENERATOR MATCHES "Visual Studio 7" OR CMAKE_GENERATOR MATCHES "Visual Studio 8")
  SET (CMAKE_NO_BUILD_TYPE 1)
  SET (CMAKE_CONFIGURATION_TYPES "Debug;Release;MinSizeRel;RelWithDebInfo" CACHE STRING 
     "Semicolon separated list of supported configuration types, only supports Debug, Release, MinSizeRel, and RelWithDebInfo, anything else will be ignored.")
  SET (CMAKE_CXX_WARNING_LEVEL "3" CACHE STRING
       "Default compiler warning level for C++.")
  SET (CMAKE_CXX_STACK_SIZE "10000000" CACHE STRING
       "Size of stack for programs.")
  MARK_AS_ADVANCED(CMAKE_CONFIGURATION_TYPES CMAKE_CXX_STACK_SIZE CMAKE_CXX_WARNING_LEVEL)
ENDIF(CMAKE_GENERATOR MATCHES "Visual Studio 7" OR CMAKE_GENERATOR MATCHES "Visual Studio 8")
# does the compiler support pdbtype and is it the newer compiler
IF(CMAKE_GENERATOR MATCHES  "Visual Studio 8")
  SET(CMAKE_COMPILER_2005 1)
ENDIF(CMAKE_GENERATOR MATCHES  "Visual Studio 8")

# make sure to enable languages after setting configuration types
ENABLE_LANGUAGE(RC)
SET(CMAKE_COMPILE_RESOURCE "rc <FLAGS> /fo<OBJECT> <SOURCE>")

# for nmake we need to compute some information about the compiler 
# that is being used.
# the compiler may be free command line, 6, 7, or 71, and
# each have properties that must be determined.  
# to avoid running these tests with each cmake run, the
# test results are saved in CMakeCPlatform.cmake, a file
# that is automatically copied into try_compile directories
# by the global generator.
IF(CMAKE_GENERATOR MATCHES "NMake Makefiles")
  IF(NOT CMAKE_VC_COMPILER_TESTS_RUN)
    SET(CMAKE_VC_COMPILER_TESTS 1)
    SET(testNmakeCLVersionFile
      "${CMAKE_ROOT}/Modules/CMakeTestNMakeCLVersion.c")
    STRING(REGEX REPLACE "/" "\\\\" testNmakeCLVersionFile "${testNmakeCLVersionFile}")
    MESSAGE(STATUS "Check for CL compiler version")
    EXEC_PROGRAM(${CMAKE_C_COMPILER} 
      ARGS /nologo -EP \"${testNmakeCLVersionFile}\" 
      OUTPUT_VARIABLE CMAKE_COMPILER_OUTPUT 
      RETURN_VALUE CMAKE_COMPILER_RETURN
      )
    IF(NOT CMAKE_COMPILER_RETURN)
      FILE(APPEND ${CMAKE_BINARY_DIR}/CMakeFiles/CMakeOutput.log 
        "Determining the version of compiler passed with the following output:\n"
        "${CMAKE_COMPILER_OUTPUT}\n\n")
      STRING(REGEX REPLACE "\n" " " compilerVersion "${CMAKE_COMPILER_OUTPUT}")
      STRING(REGEX REPLACE ".*VERSION=(.*)" "\\1"
        compilerVersion "${compilerVersion}")
      MESSAGE(STATUS "Check for CL compiler version - ${compilerVersion}")
      IF("${CMAKE_COMPILER_OUTPUT}" MATCHES ".*VERSION=1[3-9][0-9][0-9].*" )
        SET(CMAKE_COMPILER_SUPPORTS_PDBTYPE 0)
      ELSE("${CMAKE_COMPILER_OUTPUT}" MATCHES ".*VERSION=1[3-9][0-9][0-9].*" )
        SET(CMAKE_COMPILER_SUPPORTS_PDBTYPE 1)
      ENDIF("${CMAKE_COMPILER_OUTPUT}" MATCHES ".*VERSION=1[3-9][0-9][0-9].*" )
      IF("${CMAKE_COMPILER_OUTPUT}" MATCHES ".*VERSION=1[4-9][0-9][0-9].*" )
        SET(CMAKE_COMPILER_2005 1)
      ELSE("${CMAKE_COMPILER_OUTPUT}" MATCHES ".*VERSION=1[4-9][0-9][0-9].*" )
        SET(CMAKE_COMPILER_2005 0)
      ENDIF("${CMAKE_COMPILER_OUTPUT}" MATCHES ".*VERSION=1[4-9][0-9][0-9].*" )
    ELSE(NOT CMAKE_COMPILER_RETURN)
      MESSAGE(STATUS "Check for CL compiler version - failed")
      FILE(APPEND ${CMAKE_BINARY_DIR}/CMakeFiles/CMakeError.log 
        "Determining the version of compiler failed with the following output:\n"
        "${CMAKE_COMPILER_OUTPUT}\n\n")
    ENDIF(NOT CMAKE_COMPILER_RETURN)
    # try to figure out if we are running the free command line
    # tools from Microsoft.  These tools do not provide debug libraries,
    # so the link flags used have to be different.
    MAKE_DIRECTORY("${CMAKE_BINARY_DIR}/CMakeFiles/CMakeTmp2")
    SET(testForFreeVCFile
      "${CMAKE_ROOT}/Modules/CMakeTestForFreeVC.cxx")
    STRING(REGEX REPLACE "/" "\\\\" testForFreeVCFile "${testForFreeVCFile}")
    MESSAGE(STATUS "Check if this is a free VC compiler")
    EXEC_PROGRAM(${CMAKE_C_COMPILER} ${CMAKE_BINARY_DIR}/CMakeFiles/CMakeTmp2
      ARGS /nologo /MD /EHsc
      \"${testForFreeVCFile}\"
      OUTPUT_VARIABLE CMAKE_COMPILER_OUTPUT 
      RETURN_VALUE CMAKE_COMPILER_RETURN
      )
    IF(CMAKE_COMPILER_RETURN)
      FILE(APPEND ${CMAKE_BINARY_DIR}/CMakeFiles/CMakeError.log 
        "Determining if this is a free VC compiler failed with the following output:\n"
        "${CMAKE_COMPILER_OUTPUT}\n\n")
      MESSAGE(STATUS "Check if this is a free VC compiler - yes")
      SET(CMAKE_USING_VC_FREE_TOOLS 1)
    ELSE(CMAKE_COMPILER_RETURN)
      FILE(APPEND ${CMAKE_BINARY_DIR}/CMakeFiles/CMakeOutput.log 
        "Determining if this is a free VC compiler passed with the following output:\n"
        "${CMAKE_COMPILER_OUTPUT}\n\n")
      MESSAGE(STATUS "Check if this is a free VC compiler - no")
      SET(CMAKE_USING_VC_FREE_TOOLS 0)
    ENDIF(CMAKE_COMPILER_RETURN)
  ENDIF(NOT CMAKE_VC_COMPILER_TESTS_RUN)
ENDIF(CMAKE_GENERATOR MATCHES "NMake Makefiles")


# default to Debug builds
IF(CMAKE_COMPILER_2005)
  # for 2005 make sure the manifest is put in the dll with mt
  SET(CMAKE_CXX_CREATE_SHARED_LIBRARY "${CMAKE_CXX_CREATE_SHARED_LIBRARY}" 
    "mt /manifest <TARGET>.manifest /outputresource:<TARGET>\;#2")
  SET(CMAKE_CXX_CREATE_SHARED_MODULE "${CMAKE_CXX_CREATE_SHARED_LIBRARY}")
  # create a C shared library
  SET(CMAKE_C_CREATE_SHARED_LIBRARY "${CMAKE_CXX_CREATE_SHARED_LIBRARY}")
  # create a C shared module just copy the shared library rule
  SET(CMAKE_C_CREATE_SHARED_MODULE "${CMAKE_C_CREATE_SHARED_LIBRARY}")
  SET(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_LINK_EXECUTABLE}"
    "mt /manifest <TARGET>.manifest /outputresource:<TARGET>\;#2")
  SET(CMAKE_C_LINK_EXECUTABLE "${CMAKE_C_LINK_EXECUTABLE}"
    "mt /manifest <TARGET>.manifest /outputresource:<TARGET>\;#2")
  SET(CMAKE_BUILD_TYPE_INIT Debug)
  SET (CMAKE_CXX_FLAGS_INIT "/DWIN32 /D_WINDOWS /W3 /Zm1000 /EHsc /GR")
  SET (CMAKE_CXX_FLAGS_DEBUG_INIT "/D_DEBUG /MDd /Zi /Ob0 /Od /RTC1")
  SET (CMAKE_CXX_FLAGS_MINSIZEREL_INIT "/MD /O1 /Ob1 /D NDEBUG")
  SET (CMAKE_CXX_FLAGS_RELEASE_INIT "/MD /O2 /Ob2 /D NDEBUG")
  SET (CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT "/MD /Zi /O2 /Ob1 /D NDEBUG")
  SET (CMAKE_C_FLAGS_INIT "/DWIN32 /D_WINDOWS /W3 /Zm1000")
  SET (CMAKE_C_FLAGS_DEBUG_INIT "/D_DEBUG /MDd /Zi  /Ob0 /Od /RTC1")
  SET (CMAKE_C_FLAGS_MINSIZEREL_INIT "/MD /O1 /Ob1 /D NDEBUG")
  SET (CMAKE_C_FLAGS_RELEASE_INIT "/MD /O2 /Ob2 /D NDEBUG")
  SET (CMAKE_C_FLAGS_RELWITHDEBINFO_INIT "/MD /Zi /O2 /Ob1 /D NDEBUG")
  SET (CMAKE_STANDARD_LIBRARIES "kernel32.lib user32.lib gdi32.lib winspool.lib shell32.lib ole32.lib oleaut32.lib uuid.lib comdlg32.lib advapi32.lib " CACHE STRING 
      "Libraries linked by defalut with all applications.")
ELSE(CMAKE_COMPILER_2005)
  IF(CMAKE_USING_VC_FREE_TOOLS)
    MESSAGE(STATUS "Using FREE VC TOOLS, NO DEBUG available")
    SET(CMAKE_BUILD_TYPE_INIT Release)
    SET (CMAKE_CXX_FLAGS_INIT "/DWIN32 /D_WINDOWS /W3 /Zm1000 /GX /GR")
    SET (CMAKE_CXX_FLAGS_DEBUG_INIT "/D_DEBUG /MTd /Zi  /Ob0 /Od /GZ")
    SET (CMAKE_CXX_FLAGS_MINSIZEREL_INIT "/MT /O1 /Ob1")
    SET (CMAKE_CXX_FLAGS_RELEASE_INIT "/MT /O2 /Ob2")
    SET (CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT "/MT /Zi /O2 /Ob1")
    SET (CMAKE_C_FLAGS_INIT "/DWIN32 /D_WINDOWS /W3 /Zm1000 /GX /GR")
    SET (CMAKE_C_FLAGS_DEBUG_INIT "/D_DEBUG /MTd /Zi  /Ob0 /Od /GZ")
    SET (CMAKE_C_FLAGS_MINSIZEREL_INIT "/MT /O1 /Ob1")
    SET (CMAKE_C_FLAGS_RELEASE_INIT "/MT /O2 /Ob2")
    SET (CMAKE_C_FLAGS_RELWITHDEBINFO_INIT "/MT /Zi /O2 /Ob1")
    SET (CMAKE_STANDARD_LIBRARIES "kernel32.lib user32.lib gdi32.lib advapi32.lib rpcrt4.lib" CACHE STRING
      "Libraries linked by defalut with all applications.")
    SET (CMAKE_STANDARD_LIBRARIES "kernel32.lib user32.lib gdi32.lib advapi32.lib rpcrt4.lib winspool.lib shell32.lib ole32.lib oleaut32.lib uuid.lib comdlg32.lib" CACHE STRING
      "Libraries linked by defalut with all applications.")
  ELSE(CMAKE_USING_VC_FREE_TOOLS)
    SET(CMAKE_BUILD_TYPE_INIT Debug)
    SET (CMAKE_CXX_FLAGS_INIT "/DWIN32 /D_WINDOWS /W3 /Zm1000 /GX /GR")
    SET (CMAKE_CXX_FLAGS_DEBUG_INIT "/D_DEBUG /MDd /Zi  /Ob0 /Od /GZ")
    SET (CMAKE_CXX_FLAGS_MINSIZEREL_INIT "/MD /O1 /Ob1 /D NDEBUG")
    SET (CMAKE_CXX_FLAGS_RELEASE_INIT "/MD /O2 /Ob2 /D NDEBUG")
    SET (CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT "/MD /Zi /O2 /Ob1 /D NDEBUG")
    SET (CMAKE_C_FLAGS_INIT "/DWIN32 /D_WINDOWS /W3 /Zm1000")
    SET (CMAKE_C_FLAGS_DEBUG_INIT "/D_DEBUG /MDd /Zi /Ob0 /Od /GZ")
    SET (CMAKE_C_FLAGS_MINSIZEREL_INIT "/MD /O1 /Ob1 /D NDEBUG")
    SET (CMAKE_C_FLAGS_RELEASE_INIT "/MD /O2 /Ob2 /D NDEBUG")
    SET (CMAKE_C_FLAGS_RELWITHDEBINFO_INIT "/MD /Zi /O2 /Ob1 /D NDEBUG")
    SET (CMAKE_STANDARD_LIBRARIES "kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib" CACHE STRING 
      "Libraries linked by defalut with all applications.")
  ENDIF(CMAKE_USING_VC_FREE_TOOLS)
ENDIF(CMAKE_COMPILER_2005)


MARK_AS_ADVANCED(CMAKE_STANDARD_LIBRARIES)



# executable linker flags
SET (CMAKE_LINK_DEF_FILE_FLAG "/DEF:")
SET (CMAKE_EXE_LINKER_FLAGS_INIT "/STACK:10000000 /machine:I386 /INCREMENTAL:YES")
IF (CMAKE_COMPILER_SUPPORTS_PDBTYPE)
  SET (CMAKE_EXE_LINKER_FLAGS_DEBUG_INIT "/debug /pdbtype:sept")
  SET (CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO_INIT "/debug /pdbtype:sept")
ELSE (CMAKE_COMPILER_SUPPORTS_PDBTYPE)
  SET (CMAKE_EXE_LINKER_FLAGS_DEBUG_INIT "/debug")
  SET (CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO_INIT "/debug")
ENDIF (CMAKE_COMPILER_SUPPORTS_PDBTYPE)

SET (CMAKE_SHARED_LINKER_FLAGS_INIT ${CMAKE_EXE_LINKER_FLAGS_INIT})
SET (CMAKE_SHARED_LINKER_FLAGS_DEBUG_INIT ${CMAKE_EXE_LINKER_FLAGS_DEBUG_INIT})
SET (CMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO_INIT ${CMAKE_EXE_LINKER_FLAGS_DEBUG_INIT})
SET (CMAKE_MODULE_LINKER_FLAGS_INIT ${CMAKE_SHARED_LINKER_FLAGS_INIT})
SET (CMAKE_MODULE_LINKER_FLAGS_DEBUG_INIT ${CMAKE_SHARED_LINKER_FLAGS_DEBUG_INIT})
SET (CMAKE_MODULE_LINKER_FLAGS_RELWITHDEBINFO_INIT ${CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO_INIT})


# save computed information for this platform
IF(NOT EXISTS "${CMAKE_BINARY_DIR}/CMakeFiles/CMakeCPlatform.cmake")
  CONFIGURE_FILE(${CMAKE_ROOT}/Modules/Platform/Windows-cl.cmake.in 
    ${CMAKE_BINARY_DIR}/CMakeFiles/CMakeCPlatform.cmake IMMEDIATE)
ENDIF(NOT EXISTS "${CMAKE_BINARY_DIR}/CMakeFiles/CMakeCPlatform.cmake")

IF(NOT EXISTS "${CMAKE_BINARY_DIR}/CMakeFiles/CMakeCXXPlatform.cmake")
  CONFIGURE_FILE(${CMAKE_ROOT}/Modules/Platform/Windows-cl.cmake.in 
               ${CMAKE_BINARY_DIR}/CMakeFiles/CMakeCXXPlatform.cmake IMMEDIATE)
ENDIF(NOT EXISTS "${CMAKE_BINARY_DIR}/CMakeFiles/CMakeCXXPlatform.cmake")

INCLUDE(Platform/WindowsPaths)
