set(UNZIP_SOURCES
    unzip.c
    crctab.c
    crypt.c
    envargs.c
    explode.c
    extract.c
    fileio.c
    globals.c
    inflate.c
    list.c
    match.c
    process.c
    ttyio.c
    unreduce.c
    unshrink.c
    zipinfo.c
)
set(SFX_SOURCES
    unzip.c
    crctab.c
    crypt.c
    extract.c
    fileio.c
    globals.c
    inflate.c
    match.c
    process.c
    ttyio.c
)
set(OS_SOURCES )
set(DEFINES )


if(MGL_PLATFORM_WINDOWS)
    list(APPEND OS_SOURCES
        win32/win32.c
        win32/nt.c
    )
    list(APPEND DEFINES WIN32)
elseif(MGL_PLATFORM_OS2)
    list(APPEND OS_SOURCES
        os2/os2.c
        os2/os2acl.c
    )
    list(APPEND DEFINES OS2)
elseif(MGL_PLATFORM_QNX)
    list(APPEND OS_SOURCES
        unix/unix.c
    )
elseif(MGL_PLATFORM_LINUX)
    list(APPEND OS_SOURCES
        unix/unix.c
    )
    list(APPEND DEFINES
        UNIX NO_MKTEMP
    )
elseif(MGL_PLATFORM_DOS OR MGL_PLATFORM_RTTARGET)
    list(APPEND OS_SOURCES
        msdos/msdos.c
    )
    list(APPEND DEFINES MSDOS)
endif()

if(MGL_INFOZIP_ASM)
    list(APPEND OS_SOURCES
        crc_i386.asm
    )
    list(APPEND DEFINES ASM_CRC)
else()
    list(APPEND OS_SOURCES
        crc32.c
    )
    list(APPEND DEFINES NO_ASM)
endif()

add_executable(unzip ${UNZIP_SOURCES} ${OS_SOURCES})
target_include_directories(unzip PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}")
target_include_directories(unzip PRIVATE "${MGL_SOURCE_DIR}/include")
target_compile_definitions(unzip PRIVATE ${DEFINES})

add_executable(unzipsfx ${SFX_SOURCES} ${OS_SOURCES})
target_include_directories(unzipsfx PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}")
target_include_directories(unzipsfx PRIVATE "${MGL_SOURCE_DIR}/include")
target_compile_definitions(unzipsfx PRIVATE ${DEFINES} SFX)
target_compile_definitions(unzipsfx PRIVATE SFX)

add_library(libunzipsfx STATIC ${SFX_SOURCES} ${OS_SOURCES})
target_include_directories(libunzipsfx PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}")
target_include_directories(libunzipsfx PRIVATE "${MGL_SOURCE_DIR}/include")
set_property(TARGET libunzipsfx PROPERTY OUTPUT_NAME "unzipsfx")
target_compile_definitions(libunzipsfx PRIVATE ${DEFINES} SFX SFX_LIBRARY)
target_compile_definitions(libunzipsfx PRIVATE SFX)
