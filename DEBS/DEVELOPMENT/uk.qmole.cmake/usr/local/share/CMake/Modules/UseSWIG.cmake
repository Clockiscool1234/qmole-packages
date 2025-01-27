# - SWIG module for CMake
# Defines the following macros:
#   SWIG_ADD_MODULE(name language [ files ])
#     - Define swig module with given name and specified language
#   SWIG_LINK_LIBRARIES(name [ libraries ])
#     - Link libraries to swig module
# All other macros are for internal use only.
# To get the actual name of the swig module,
# use: ${SWIG_MODULE_name_REAL_NAME}.
# Set Source files properties such as CPLUSPLUS and SWIG_FLAGS to specify
# special behavior of SWIG. Also global CMAKE_SWIG_FLAGS can be used to add
# special flags to all swig calls.
# Another special variable is CMAKE_SWIG_OUTDIR, it allows one to specify 
# where to write all the swig generated module (swig -outdir option)

SET(SWIG_CXX_EXTENSION "cxx")
SET(SWIG_EXTRA_LIBRARIES "")

SET(SWIG_PYTHON_EXTRA_FILE_EXTENSION "py")

#
# For given swig module initialize variables associated with it
#
MACRO(SWIG_MODULE_INITIALIZE name language)
  STRING(TOUPPER "${language}" swig_uppercase_language)
  STRING(TOLOWER "${language}" swig_lowercase_language)
  SET(SWIG_MODULE_${name}_LANGUAGE "${swig_uppercase_language}")
  SET(SWIG_MODULE_${name}_SWIG_LANGUAGE_FLAG "${swig_lowercase_language}")

  IF("x${SWIG_MODULE_${name}_LANGUAGE}x" MATCHES "^xUNKNOWNx$")
    MESSAGE(FATAL_ERROR "SWIG Error: Language \"${language}\" not found")
  ENDIF("x${SWIG_MODULE_${name}_LANGUAGE}x" MATCHES "^xUNKNOWNx$")

  SET(SWIG_MODULE_${name}_REAL_NAME "${name}")
  IF("x${SWIG_MODULE_${name}_LANGUAGE}x" MATCHES "^xPYTHONx$")
    SET(SWIG_MODULE_${name}_REAL_NAME "_${name}")
  ENDIF("x${SWIG_MODULE_${name}_LANGUAGE}x" MATCHES "^xPYTHONx$")
  IF("x${SWIG_MODULE_${name}_LANGUAGE}x" MATCHES "^xPERLx$")
    SET(SWIG_MODULE_${name}_EXTRA_FLAGS "-shadow")
  ENDIF("x${SWIG_MODULE_${name}_LANGUAGE}x" MATCHES "^xPERLx$")
ENDMACRO(SWIG_MODULE_INITIALIZE)

#
# For a given language, input file, and output file, determine extra files that
# will be generated. This is internal swig macro.
#

MACRO(SWIG_GET_EXTRA_OUTPUT_FILES language outfiles generatedpath infile)
  FOREACH(it ${SWIG_PYTHON_EXTRA_FILE_EXTENSION})
    SET(outfiles ${outfiles}
      "${generatedpath}/${infile}.${it}")
  ENDFOREACH(it)
ENDMACRO(SWIG_GET_EXTRA_OUTPUT_FILES)

#
# Take swig (*.i) file and add proper custom commands for it
#
MACRO(SWIG_ADD_SOURCE_TO_MODULE name outfiles infile)
  SET(swig_full_infile ${infile})
  GET_FILENAME_COMPONENT(swig_source_file_path "${infile}" PATH)
  GET_FILENAME_COMPONENT(swig_source_file_name_we "${infile}" NAME_WE)
  GET_SOURCE_FILE_PROPERTY(swig_source_file_generated ${infile} GENERATED)
  GET_SOURCE_FILE_PROPERTY(swig_source_file_cplusplus ${infile} CPLUSPLUS)
  GET_SOURCE_FILE_PROPERTY(swig_source_file_flags ${infile} SWIG_FLAGS)
  IF("${swig_source_file_flags}" STREQUAL "NOTFOUND")
    SET(swig_source_file_flags "")
  ENDIF("${swig_source_file_flags}" STREQUAL "NOTFOUND")
  SET(swig_source_file_fullname "${infile}")
  IF(${swig_source_file_path} MATCHES "^${CMAKE_CURRENT_SOURCE_DIR}")
    STRING(REGEX REPLACE 
      "^${CMAKE_CURRENT_SOURCE_DIR}" ""
      swig_source_file_relative_path
      "${swig_source_file_path}")
  ELSE(${swig_source_file_path} MATCHES "^${CMAKE_CURRENT_SOURCE_DIR}")
    IF(${swig_source_file_path} MATCHES "^${CMAKE_CURRENT_BINARY_DIR}")
      STRING(REGEX REPLACE 
        "^${CMAKE_CURRENT_BINARY_DIR}" ""
        swig_source_file_relative_path
        "${swig_source_file_path}")
      SET(swig_source_file_generated 1)
    ELSE(${swig_source_file_path} MATCHES "^${CMAKE_CURRENT_BINARY_DIR}")
      SET(swig_source_file_relative_path "${swig_source_file_path}")
      IF(swig_source_file_generated)
        SET(swig_source_file_fullname "${CMAKE_CURRENT_BINARY_DIR}/${infile}")
      ELSE(swig_source_file_generated)
        SET(swig_source_file_fullname "${CMAKE_CURRENT_SOURCE_DIR}/${infile}")
      ENDIF(swig_source_file_generated)
    ENDIF(${swig_source_file_path} MATCHES "^${CMAKE_CURRENT_BINARY_DIR}")
  ENDIF(${swig_source_file_path} MATCHES "^${CMAKE_CURRENT_SOURCE_DIR}")

  SET(swig_generated_file_fullname
    "${CMAKE_CURRENT_BINARY_DIR}")
  IF(swig_source_file_relative_path)
    SET(swig_generated_file_fullname
      "${swig_generated_file_fullname}/${swig_source_file_relative_path}")
  ENDIF(swig_source_file_relative_path)
  SWIG_GET_EXTRA_OUTPUT_FILES(${SWIG_MODULE_${name}_LANGUAGE}
    swig_extra_generated_files
    "${swig_generated_file_fullname}"
    "${swig_source_file_name_we}")
  SET(swig_generated_file_fullname
    "${swig_generated_file_fullname}/${swig_source_file_name_we}")
  # add the language into the name of the file (i.e. TCL_wrap)
  # this allows for the same .i file to be wrapped into different languages
  SET(swig_generated_file_fullname
    "${swig_generated_file_fullname}${SWIG_MODULE_${name}_LANGUAGE}_wrap")

  IF(swig_source_file_cplusplus)
    SET(swig_generated_file_fullname
      "${swig_generated_file_fullname}.${SWIG_CXX_EXTENSION}")
  ELSE(swig_source_file_cplusplus)
    SET(swig_generated_file_fullname
      "${swig_generated_file_fullname}.c")
  ENDIF(swig_source_file_cplusplus)

  #MESSAGE("Full path to source file: ${swig_source_file_fullname}")
  #MESSAGE("Full path to the output file: ${swig_generated_file_fullname}")
  GET_DIRECTORY_PROPERTY(cmake_include_directories INCLUDE_DIRECTORIES)
  SET(swig_include_dirs)
  FOREACH(it ${cmake_include_directories})
    SET(swig_include_dirs ${swig_include_dirs} "-I${it}")
  ENDFOREACH(it)

  SET(swig_special_flags)
  # default is c, so add c++ flag if it is c++
  IF(swig_source_file_cplusplus)
    SET(swig_special_flags ${swig_special_flags} "-c++")
  ENDIF(swig_source_file_cplusplus)
  SET(swig_extra_flags)
  IF(SWIG_MODULE_${name}_EXTRA_FLAGS)
    SET(swig_extra_flags ${swig_extra_flags} ${SWIG_MODULE_${name}_EXTRA_FLAGS})
  ENDIF(SWIG_MODULE_${name}_EXTRA_FLAGS)
  # If CMAKE_SWIG_OUTDIR was specified then pass it to -outdir
  IF(CMAKE_SWIG_OUTDIR)
    ADD_CUSTOM_COMMAND(
      OUTPUT "${swig_generated_file_fullname}"
      COMMAND "${SWIG_EXECUTABLE}"
      ARGS "-${SWIG_MODULE_${name}_SWIG_LANGUAGE_FLAG}"
      ${swig_source_file_flags}
      ${CMAKE_SWIG_FLAGS}
      -outdir ${CMAKE_SWIG_OUTDIR}
      ${swig_special_flags}
      ${swig_extra_flags}
      ${swig_include_dirs}
      -o "${swig_generated_file_fullname}"
      "${swig_source_file_fullname}"
      MAIN_DEPENDENCY "${swig_source_file_fullname}"
      COMMENT "Swig source") 
  ELSE(CMAKE_SWIG_OUTDIR)
    ADD_CUSTOM_COMMAND(
      OUTPUT "${swig_generated_file_fullname}"
      COMMAND "${SWIG_EXECUTABLE}"
      ARGS "-${SWIG_MODULE_${name}_SWIG_LANGUAGE_FLAG}"
      ${swig_source_file_flags}
      ${CMAKE_SWIG_FLAGS}
      ${swig_outdir_flags}
      ${swig_special_flags}
      ${swig_extra_flags}
      ${swig_include_dirs}
      -o "${swig_generated_file_fullname}"
      "${swig_source_file_fullname}"
      MAIN_DEPENDENCY "${swig_source_file_fullname}"
      COMMENT "Swig source") 
  ENDIF(CMAKE_SWIG_OUTDIR)
  SET_SOURCE_FILES_PROPERTIES("${swig_generated_file_fullname}"
    PROPERTIES GENERATED 1)
  SET(${outfiles} "${swig_generated_file_fullname}")
ENDMACRO(SWIG_ADD_SOURCE_TO_MODULE)

#
# Create Swig module
#
MACRO(SWIG_ADD_MODULE name language)
  SWIG_MODULE_INITIALIZE(${name} ${language})
  SET(swig_dot_i_sources)
  SET(swig_other_sources)
  FOREACH(it ${ARGN})
    IF(${it} MATCHES ".*\\.i$")
      SET(swig_dot_i_sources ${swig_dot_i_sources} "${it}")
    ELSE(${it} MATCHES ".*\\.i$")
      SET(swig_other_sources ${swig_other_sources} "${it}")
    ENDIF(${it} MATCHES ".*\\.i$")
  ENDFOREACH(it)

  SET(swig_generated_sources)
  FOREACH(it ${swig_dot_i_sources})
    SWIG_ADD_SOURCE_TO_MODULE(${name} swig_generated_source ${it})
    SET(swig_generated_sources ${swig_generated_sources} "${swig_generated_source}")
  ENDFOREACH(it)
  GET_DIRECTORY_PROPERTY(swig_extra_clean_files ADDITIONAL_MAKE_CLEAN_FILES)
  SET_DIRECTORY_PROPERTIES(PROPERTIES
    ADDITIONAL_MAKE_CLEAN_FILES "${swig_extra_clean_files};${swig_generated_sources}")
  ADD_LIBRARY(${SWIG_MODULE_${name}_REAL_NAME}
    MODULE
    ${swig_generated_sources}
    ${swig_other_sources})
  SET_TARGET_PROPERTIES(${SWIG_MODULE_${name}_REAL_NAME}
    PROPERTIES PREFIX "")
ENDMACRO(SWIG_ADD_MODULE)

#
# Like TARGET_LINK_LIBRARIES but for swig modules
#
MACRO(SWIG_LINK_LIBRARIES name)
  IF(SWIG_MODULE_${name}_REAL_NAME)
    TARGET_LINK_LIBRARIES(${SWIG_MODULE_${name}_REAL_NAME} ${ARGN})
  ELSE(SWIG_MODULE_${name}_REAL_NAME)
    MESSAGE(SEND_ERROR "Cannot find Swig library \"${name}\".")
  ENDIF(SWIG_MODULE_${name}_REAL_NAME)
ENDMACRO(SWIG_LINK_LIBRARIES name)

