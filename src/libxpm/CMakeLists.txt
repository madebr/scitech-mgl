set(SOURCES
    Attrib.c
    CrBufFrI.c
    CrDatFrI.c
    create.c
    CrIFrBuf.c
    CrIFrDat.c
    data.c
    Image.c
    Info.c
    hashtab.c
    misc.c
    parse.c
    RdFToDat.c
    RdFToI.c
    rgb.c
    scan.c
    simx.c
    WrFFrDat.c
    WrFFrI.c
)

if(MGL_PLATFORM_WINDOWS)
    list(APPEND DEFINES WIN32 FOR_MSW)
endif()

add_library(xpm-static STATIC
    ${SOURCES}
)
target_include_directories(xpm-static PRIVATE "${MGL_SOURCE_DIR}/include")
target_compile_definitions(xpm-static PRIVATE ${DEFINES})
set_property(TARGET xpm-static PROPERTY OUTPUT_NAME "xpm")

if(MGL_PLATFORM_LINUX OR MGL_PLATFORM_WINDOWS)
    add_library(xpm-shared SHARED
        ${SOURCES} ${SHARED_SOURCES}
    )
    target_include_directories(xpm-shared PRIVATE "${MGL_SOURCE_DIR}/include")
    target_compile_definitions(xpm-shared PRIVATE ${DEFINES})
    set_property(TARGET xpm-shared PROPERTY OUTPUT_NAME "xpm")
    set_property(TARGET xpm-shared PROPERTY ARCHIVE_OUTPUT_NAME "ixpm")
    set_property(TARGET xpm-shared PROPERTY SUFFIX ".bpd")
    set_property(TARGET xpm-shared PROPERTY PREFIX "")
endif()
