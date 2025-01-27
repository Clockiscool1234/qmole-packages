SET(CMAKE_SHARED_LIBRARY_PREFIX "lib")          # lib
SET(CMAKE_SHARED_LIBRARY_SUFFIX ".so")          # .so
SET(CMAKE_DL_LIBS "-lld")
SET(CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS "-G -Wl,-brtl")  # -shared
SET(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "-Wl,-brtl,-bexpall")  # +s, flag for exe link to use shared lib

# CXX Compiler
IF(CMAKE_COMPILER_IS_GNUCXX) 
  SET(CMAKE_SHARED_LIBRARY_CREATE_CXX_FLAGS "-shared -Wl,-G")       # -shared
ELSE(CMAKE_COMPILER_IS_GNUCXX) 
  SET(CMAKE_SHARED_LIBRARY_CREATE_CXX_FLAGS "-G -Wl,-brtl")       # -shared
  SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "-Wl,-brtl,-bexpall")  # +s, flag for exe link to use shared lib
  SET(CMAKE_SHARED_LIBRARY_CXX_FLAGS " ")
  SET(CMAKE_SHARED_MODULE_CXX_FLAGS  " ")
  SET (CMAKE_CXX_FLAGS_DEBUG_INIT "-g")
  SET (CMAKE_CXX_FLAGS_RELEASE_INIT "-O -DNDEBUG") 
  SET (CMAKE_CXX_FLAGS_MINSIZEREL_INIT "-O -DNDEBUG")
  SET (CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT "-g")
ENDIF(CMAKE_COMPILER_IS_GNUCXX) 

# C Compiler
IF(CMAKE_COMPILER_IS_GNUCC)
  SET(CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS "-shared -Wl,-G")       # -shared
ELSE(CMAKE_COMPILER_IS_GNUCC)
  SET(CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS "-G -Wl,-brtl")  # -shared
  SET(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "-Wl,-brtl,-bexpall")  # +s, flag for exe link to use shared lib
  SET(CMAKE_SHARED_LIBRARY_C_FLAGS " ")
  SET(CMAKE_SHARED_MODULE_C_FLAGS  " ")
  SET (CMAKE_C_FLAGS_DEBUG_INIT "-g")
  SET (CMAKE_C_FLAGS_RELEASE_INIT "-O -DNDEBUG") 
  SET (CMAKE_C_FLAGS_MINSIZEREL_INIT "-O -DNDEBUG")
  SET (CMAKE_C_FLAGS_RELWITHDEBINFO_INIT "-g")
ENDIF(CMAKE_COMPILER_IS_GNUCC)
