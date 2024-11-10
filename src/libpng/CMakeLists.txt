set(SOURCES
    png.c
    pngset.c
    pngget.c
    pngrutil.c
    pngtrans.c
    pngwutil.c
    pngmem.c
    pngpread.c
    pngread.c
    pngerror.c
    pngwrite.c
    pngrtran.c
    pngwtran.c
    pngrio.c
    pngwio.c

    ../zlib/adler32.c
    ../zlib/compress.c
    ../zlib/crc32.c
    ../zlib/uncompr.c
    ../zlib/deflate.c
    ../zlib/trees.c
    ../zlib/zutil.c
    ../zlib/inflate.c
    ../zlib/inffast.c
    ../zlib/inftrees.c
)
set(SHARED_SOURCES )

if(MGL_CPU_X86)
    list(APPEND SHARED_SOURCES
        #        dllstart.c
        pnginit.c
    )
else()
    list(APPEND SHARED_SOURCES
        ../common/initseg.c
        pnginit.c
    )
endif()

add_library(png-static STATIC
    ${SOURCES}
)
target_include_directories(png-static PRIVATE "${MGL_SOURCE_DIR}/include")
set_property(TARGET png-static PROPERTY OUTPUT_NAME "png")

if(MGL_PLATFORM_LINUX OR MGL_PLATFORM_WINDOWS)
    add_library(png-shared SHARED
        ${SOURCES} ${SHARED_SOURCES}
    )
    target_include_directories(png-shared PRIVATE "${MGL_SOURCE_DIR}/include")
    set_property(TARGET png-shared PROPERTY OUTPUT_NAME "png")
    set_property(TARGET png-shared PROPERTY ARCHIVE_OUTPUT_NAME "ipng")
    set_property(TARGET png-shared PROPERTY SUFFIX ".bpd")
    set_property(TARGET png-shared PROPERTY PREFIX "")

    add_executable(pngtest_bpd pngtest.c pnglib.c _png_exp.asm)
    add_executable(pngtest pngtest.c)
    target_link_libraries(pngtest PRIVATE png-static)
endif()
