set(SOURCES
    zip.c
    crypt.c
    ttyio.c
    trees.c
    zipup.c
    util.c
    zipfile.c
    fileio.c
    deflate.c
    globals.c
    crctab.c
)
set(DEFINES )

if(MGL_PLATFORM_WINDOWS)
    list(APPEND SOURCES
        win32/win32.c
        win32/nt.c
        win32/win32zip.c
    )
    list(APPEND DEFINES WIN32)
elseif(MGL_PLATFORM_OS2)
    list(APPEND SOURCES
        os2/os2.c
        os2/os2acl.c
        os2/os2zip.c
    )
    list(APPEND DEFINES OS2)
elseif(MGL_PLATFORM_QNX)
    list(APPEND SOURCES
        unix/unix.c
    )
    list(APPEND DEFINES
        UNIX HAVE_DIRENT_H HAVE_TERMIOS_H NO_MKTEMP
    )
elseif(MGL_PLATFORM_LINUX)
    list(APPEND SOURCES
        unix/unix.c
    )
    list(APPEND DEFINES
        UNIX NO_MKTEMP
    )
elseif(MGL_PLATFORM_DOS OR MGL_PLATFORM_RTTARGET)
    list(APPEND SOURCES
        msdos/msdos.c
    )
    list(APPEND DEFINES DOS)
endif()

if(MGL_INFOZIP_ASM)
    list(APPEND SOURCES
        match32.asm
        crc_i386.asm
    )
    list(APPEND DEFINES ASM_CRC)
else()
    list(APPEND SOURCES
        crc32.c
    )
    list(APPEND DEFINES NO_ASM)
endif()

add_executable(zip ${SOURCES})
target_include_directories(zip PRIVATE "${MGL_SOURCE_DIR}/include")
target_include_directories(zip PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}")
target_compile_definitions(zip PRIVATE ${DEFINES})
