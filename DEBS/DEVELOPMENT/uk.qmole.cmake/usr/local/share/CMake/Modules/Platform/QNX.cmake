# GCC is the default compiler on QNX 6.3.
INCLUDE(${CMAKE_ROOT}/Modules/Platform/gcc.cmake)

SET(CMAKE_DL_LIBS "")
SET(CMAKE_SHARED_LIBRARY_C_FLAGS "")
SET(CMAKE_SHARED_LIBRARY_CXX_FLAGS "")
SET(CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS "-shared")
SET(CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG "-Wl,-rpath,")
SET(CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG_SEP ":")
SET(CMAKE_SHARED_LIBRARY_SONAME_C_FLAG "-Wl,-soname,")
SET(CMAKE_SHARED_LIBRARY_SONAME_CXX_FLAG "-Wl,-soname,")
