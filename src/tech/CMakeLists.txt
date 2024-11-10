add_library(tech
    dlist.cpp
    list.cpp
    hashtab.cpp
    error.cpp
    str.cpp
    dynstr.cpp
    substr.cpp
    memmgr.cpp
    hash_c.cpp
    slist.cpp
)
target_include_directories(tech PUBLIC "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>")

if(MGL_PLATFORM_LINUX)
    add_executable(hashtst test/hashtst.cpp)
    target_link_libraries(hashtst PRIVATE tech)
endif()
add_executable(tststr test/tststr.cpp)
target_link_libraries(tststr PRIVATE tech)
