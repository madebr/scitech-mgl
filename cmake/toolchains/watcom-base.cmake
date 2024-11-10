set(WATCOM 1)

set(WATCOM_ROOT "$ENV{WATCOM}" CACHE PATH "Root of WatCom compiler")
mark_as_advanced(WATCOM_ROOT)

if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
    set(WATCOM_BIN_DIR "${WATCOM_ROOT}/binl")
else()
    message(FATAL_ERROR "Unsupported build platform")
endif()

if(NOT WATCOM_ROOT)
    message(FATAL_ERROR "WATCOM environment variable not set")
endif()

# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

if(OVERRIDE_FIND_ROOT_PATH_MODE OR "$ENV{OVERRIDE_FIND_ROOT_PATH_MODE}")
    set(_OVERRIDE_FIND_ROOT_PATH_MODE BOTH)
else()
    set(_OVERRIDE_FIND_ROOT_PATH_MODE ONLY)
endif()
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ${_OVERRIDE_FIND_ROOT_PATH_MODE})
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ${_OVERRIDE_FIND_ROOT_PATH_MODE})
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ${_OVERRIDE_FIND_ROOT_PATH_MODE})
