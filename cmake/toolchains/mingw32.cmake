set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86)

set(CMAKE_SHARED_LINKER_FLAGS "-lssp")

find_program(CMAKE_C_COMPILER NAMES i686-w64-mingw32-gcc)
find_program(CMAKE_CXX_COMPILER NAMES i686-w64-mingw32-g++)
find_program(CMAKE_ASM-ATT_COMPILER NAMES i686-w64-mingw32-as)

if(NOT CMAKE_C_COMPILER)
	message(FATAL_ERROR "Failed to find CMAKE_C_COMPILER.")
endif()

if(NOT CMAKE_CXX_COMPILER)
	message(FATAL_ERROR "Failed to find CMAKE_CXX_COMPILER.")
endif()

execute_process(COMMAND "${CMAKE_C_COMPILER}" -print-search-dirs
	RESULT_VARIABLE CC_SEARCH_DIRS_RESULT
	OUTPUT_VARIABLE CC_SEARCH_DIRS_OUTPUT)

if(CC_SEARCH_DIRS_RESULT)
	message(FATAL_ERROR "Could not determine search dirs")
endif()

string(REGEX MATCH ".*libraries: (.*).*" CC_SD_LIBS "${CC_SEARCH_DIRS_OUTPUT}")
string(STRIP "${CMAKE_MATCH_1}" CC_SEARCH_DIRS)
string(REPLACE ":" ";" CC_SEARCH_DIRS "${CC_SEARCH_DIRS}")

foreach(CC_SEARCH_DIR ${CC_SEARCH_DIRS})
	if(CC_SEARCH_DIR MATCHES "=.*")
		string(REGEX MATCH "=(.*)" CC_LIB "${CC_SEARCH_DIR}")
		set(CC_SEARCH_DIR "${CMAKE_MATCH_1}")
	endif()
	if(IS_DIRECTORY "${CC_SEARCH_DIR}")
		if(IS_DIRECTORY "${CC_SEARCH_DIR}/../include" OR IS_DIRECTORY "${CC_SEARCH_DIR}/../lib" OR IS_DIRECTORY "${CC_SEARCH_DIR}/../bin")
			list(APPEND CC_ROOTS "${CC_SEARCH_DIR}/..")
		else()
			list(APPEND CC_ROOTS "${CC_SEARCH_DIR}")
		endif()
	endif()
endforeach()

list(APPEND CMAKE_FIND_ROOT_PATH ${CC_ROOTS})

# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

if(OVERRIDE_FIND_ROOT_PATH_MODE)
	set(_OVERRIDE_FIND_ROOT_PATH_MODE BOTH)
else()
	set(_OVERRIDE_FIND_ROOT_PATH_MODE ONLY)
endif()
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ${_OVERRIDE_FIND_ROOT_PATH_MODE})
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ${_OVERRIDE_FIND_ROOT_PATH_MODE})
