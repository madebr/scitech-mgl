option(MGL_DEBUG_FLIP "Enable page flip debugging" OFF)

set(SOURCES
    mglgm.rc
    gm.c
    ../common/cmdline.c
    dlist.cpp
    sprbmp.cpp
    sprmgr.cpp
    sprite.cpp
    ../mgl/mglrgn.cpp
)

add_library(gm-static STATIC
    ${SOURCES}
)
target_include_directories(gm-static PRIVATE "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include>")
target_include_directories(gm-static PRIVATE "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include/snapgl>")
target_link_libraries(gm-static PRIVATE mgl-static)
if(MGL_DEBUG_FLIP)
    target_compile_definitions(gm-static PRIVATE DEBUG_FLIP)
endif()
set_property(TARGET gm-static PROPERTY OUTPUT_NAME gm)

if(MGL_PLATFORM_LINUX OR MGL_PLATFORM_WINDOWS)
    add_library(gm-shared SHARED
        ${SOURCES}
    )
    target_include_directories(gm-shared PRIVATE "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include>")
    target_link_libraries(gm-shared PRIVATE mgl-shared)
    target_link_option_no_undefined(gm-shared)
    if(MGL_DEBUG_FLIP)
        target_compile_definitions(gm-shared PRIVATE DEBUG_FLIP)
    endif()
    set_property(TARGET gm-shared PROPERTY DEFINE_SYMBOL BUILD_DLL)
    set_property(TARGET gm-shared PROPERTY OUTPUT_NAME "mglgm")
    set_property(TARGET gm-shared PROPERTY ARCHIVE_OUTPUT_NAME "mglgm")
    if(MGL_PLATFORM_WINDOWS OR MGL_PLATFORM_DOS OR MGL_PLATFORM_RTTARGET)
        set_property(TARGET gm-shared PROPERTY PREFIX "")
    endif()
    add_library(gm::gm ALIAS gm-shared)
else()
    add_library(gm::gm ALIAS gm-static)
endif()
