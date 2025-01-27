IF(CMAKE_SYSTEM MATCHES "SunOS-4.*")
   SET(CMAKE_SHARED_LIBRARY_C_FLAGS "-PIC") 
   SET(CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS "-shared -Wl,-r") 
   SET(CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG "-Wl,-R")
   SET(CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG_SEP ":")  
   SET(CMAKE_SHARED_LIBRARY_SONAME_C_FLAG "-h")
   SET(CMAKE_SHARED_LIBRARY_SONAME_CXX_FLAG "-h")
ENDIF(CMAKE_SYSTEM MATCHES "SunOS-4.*")

IF(CMAKE_SYSTEM MATCHES "SunOS-5*.")
  SET(CMAKE_SHARED_LIBRARY_C_FLAGS "-KPIC") 
  SET(CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS "-G")
  SET(CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG "-R")
  SET(CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG_SEP ":")
  SET(CMAKE_SHARED_LIBRARY_SONAME_C_FLAG "-h")
  SET(CMAKE_SHARED_LIBRARY_SONAME_CXX_FLAG "-h")
  SET(CMAKE_SHARED_LIBRARY_CXX_FLAGS "-KPIC") 
  SET(CMAKE_SHARED_LIBRARY_CREATE_CXX_FLAGS "-G")
  SET(CMAKE_SHARED_LIBRARY_RUNTIME_CXX_FLAG "-R")
  SET(CMAKE_SHARED_LIBRARY_RUNTIME_CXX_FLAG_SEP ":")
  IF(CMAKE_COMPILER_IS_GNUCC)
    SET(CMAKE_SHARED_LIBRARY_C_FLAGS "-fPIC") 
    SET(CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS "-shared")
    SET(CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG "-Wl,-R")
    SET(CMAKE_SHARED_LIBRARY_RUNTIME_C_FLAG_SEP ":")  
    SET(CMAKE_SHARED_LIBRARY_SONAME_C_FLAG "-Wl,-h")
  ELSE(CMAKE_COMPILER_IS_GNUCC)
    SET (CMAKE_C_FLAGS_INIT "")
    SET (CMAKE_C_FLAGS_DEBUG_INIT "-g")
    SET (CMAKE_C_FLAGS_MINSIZEREL_INIT "-O3 -DNDEBUG")
    SET (CMAKE_C_FLAGS_RELEASE_INIT "-O2 -DNDEBUG")
    SET (CMAKE_C_FLAGS_RELWITHDEBINFO_INIT "-O2")
  ENDIF(CMAKE_COMPILER_IS_GNUCC)
  IF(CMAKE_COMPILER_IS_GNUCXX)
    SET(CMAKE_SHARED_LIBRARY_CXX_FLAGS "-fPIC") 
    SET(CMAKE_SHARED_LIBRARY_CREATE_CXX_FLAGS "-shared")
    SET(CMAKE_SHARED_LIBRARY_RUNTIME_CXX_FLAG "-Wl,-R")
    SET(CMAKE_SHARED_LIBRARY_RUNTIME_CXX_FLAG_SEP ":")  
    SET(CMAKE_SHARED_LIBRARY_SONAME_CXX_FLAG "-Wl,-h")
  ELSE(CMAKE_COMPILER_IS_GNUCXX)
    SET (CMAKE_CXX_FLAGS_INIT "")
    SET (CMAKE_CXX_FLAGS_DEBUG_INIT "-g")
    SET (CMAKE_CXX_FLAGS_MINSIZEREL_INIT "-O3 -DNDEBUG")
    SET (CMAKE_CXX_FLAGS_RELEASE_INIT "-O2 -DNDEBUG")
    SET (CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT "-O2")
  ENDIF(CMAKE_COMPILER_IS_GNUCXX)
ENDIF(CMAKE_SYSTEM MATCHES "SunOS-5*.")

IF(CMAKE_COMPILER_IS_GNUCXX)
  IF(CMAKE_COMPILER_IS_GNUCC)
    SET(CMAKE_CXX_CREATE_SHARED_LIBRARY
        "<CMAKE_C_COMPILER> <CMAKE_SHARED_LIBRARY_CXX_FLAGS> <LINK_FLAGS> <CMAKE_SHARED_LIBRARY_CREATE_CXX_FLAGS>  <CMAKE_SHARED_LIBRARY_SONAME_CXX_FLAG><TARGET_SONAME> -o <TARGET> <OBJECTS> <LINK_LIBRARIES>")
  ELSE(CMAKE_COMPILER_IS_GNUCC)
    # Take default rule from CMakeDefaultMakeRuleVariables.cmake.
  ENDIF(CMAKE_COMPILER_IS_GNUCC)
ELSE(CMAKE_COMPILER_IS_GNUCXX)
  IF(CMAKE_CXX_COMPILER)
     SET(CMAKE_CXX_CREATE_STATIC_LIBRARY
      "<CMAKE_CXX_COMPILER> -xar -o <TARGET> <OBJECTS> "
      "<CMAKE_RANLIB> <TARGET> ")
  ENDIF(CMAKE_CXX_COMPILER)
ENDIF(CMAKE_COMPILER_IS_GNUCXX)
INCLUDE(Platform/UnixPaths)
