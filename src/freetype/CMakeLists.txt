set(SOURCES
    ttapi.c
    ttcache.c
    ttcalc.c
    ttcmap.c
    ttdebug.c
    ttfile.c
    ttgload.c
    ttinterp.c
    ttload.c
    ttmemory.c
    ttmutex.c
    ttobjs.c
    ttraster.c
    ttextend.c
    extend/ftxgasp.c
    extend/ftxkern.c
    extend/ftxpost.c
    extend/ftxcmap.c
    extend/ftxwidth.c
)
set(STATIC_SOURCES
    extend/ftxsbit.c
    extend/ftxgsub.c
    extend/ftxgdef.c
    extend/ftxopen.c
    extend/ftxgpos.c
)
if(MGL_CPU_X86)
    list(APPEND SHARED_SOURCES
#        dllstart.c
        ttinit.c
    )
else()
    list(APPEND SHARED_SOURCES
        ../common/initseg.c
        ttinit.c
    )
endif()

if(MGL_PLATFORM_LINUX OR MGL_PLATFORM_WINDOWS)
    add_library(mgl_freetype-shared SHARED
        ${SOURCES}
        ${SHARED_SOURCES}
    )
    target_include_directories(mgl_freetype-shared PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}")
    target_include_directories(mgl_freetype-shared PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/extend")
    target_include_directories(mgl_freetype-shared PRIVATE "${MGL_SOURCE_DIR}/include")
    target_compile_definitions(mgl_freetype-shared PUBLIC FREETYPE_DLL)
    set_property(TARGET mgl_freetype-shared PROPERTY SUFFIX ".bpd")
    set_property(TARGET mgl_freetype-shared PROPERTY PREFIX "")
    set_property(TARGET mgl_freetype-shared PROPERTY OUTPUT_NAME "freetype")
    set_property(TARGET mgl_freetype-shared PROPERTY ARCHIVE_OUTPUT_NAME "ifreetype")
endif()

add_library(mgl_freetype-static STATIC
    ${SOURCES}
    ${STATIC_SOURCES}
)
target_include_directories(mgl_freetype-static PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>")
target_include_directories(mgl_freetype-static PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/extend>")
target_include_directories(mgl_freetype-static PUBLIC "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include>")
set_property(TARGET mgl_freetype-static PROPERTY OUTPUT_NAME "freetype")

add_executable(ftdump
    ftdump.c
    fcommon.c
)
target_include_directories(ftdump PRIVATE "${MGL_SOURCE_DIR}/include")
target_link_libraries(ftdump PRIVATE mgl_freetype-static)
