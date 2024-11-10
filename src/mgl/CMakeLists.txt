set(BUILD_DLL OFF)
set(DEFINES)
set(STATIC_LIBNAME "mglfx")
set(SHARED_LIBNAME "mglfx")
set(SHARED_IMPORTED_LIBNAME "mgli")
set(LIBS pm::pm n_ga)
set(SOURCES
    mgraph.c
    createdc.c
    devctx.c
    buffer.c
    state.c
    palette.c
    glyph.c
    line.c
    bitblt.c
    putbmp.c
    clipline.c
    cliplfx.c
    scanline.c
    pixel.c
    rect.c
    mglfile.c
    viewport.c
    access.c
    list.c
    cursor.c
    memset.c
    random.c
    color.c
    mgldll.c
    halftone.c
    rtrav.c
    blocklst.c
    ellipse.c
    ellipsea.c
    fatline.c
    polygon.c
    polyline.c
    rectangl.c
    rspan.c
    rseg.c
    region.c
    rdraw.c
    runion.c
    rsect.c
    rdiff.c
    rmisc.c
    rrect.c
    rline.c
    rcvxpoly.c
    rellip.c
    rellipa.c
    text.c
    wtext.c
    texthelp.c
    vecfont.c
    bitfont.c
    font.c
    icon.c
    bitmap.c
    pcx.c
    jpeg.c
    tiff.c
    png.c
    cplxpoly.c
    cnvxpoly.c
    polyhlp.c
    mouse.c
    textenc.c
    fontenum.c
    winmng.c
    mgl_gl.c
    mglrect.cpp
    mglrgn.cpp

    drivers/packed/packed8.c
    drivers/packed/packed16.c
    drivers/packed/packed24.c
    drivers/packed/packed32.c
)
if(MGL_CPU_X86)
    list(APPEND SOURCES
        asm386/_fix32.asm
        asm386/_memset.asm
        asm386/_polyhlp.asm
        asm386/_random.asm
    )
endif()

if(MGL_CPU_X86)
    list(APPEND SOURCES
        asm386/_opengl.asm
        asm386/_glu.asm
    )
elseif(MGL_CPU_X64)
    list(APPEND SOURCES
        asmamd64/_opengl.s_amd64
        asmamd64/_glu.s_amd64
    )
elseif(MGL_CPU_PPC_BE)
    list(APPEND SOURCES
        asmppc/_opengl.s_ppc
        asmppc/_glu.s_ppc
    )
endif()

if(MGL_PLATFORM_SMX32)
    list(APPEND SOURCES
        mglsmx/mglsmx.c

        drivers/common/common.c
        drivers/common/vgapal.c
        drivers/common/gsnap.c
        drivers/snap/snap.c
        drivers/snap/snapvbe.c
        ../common/gasmx.c
    )
    list(APPEND DEFINES $<$<COMPILE_LANGUAGE:ASM_NASM>:__REALDOS__>)
elseif(MGL_PLATFORM_WINDOWS)
    set(BUILD_DLL ON)
    list(APPEND SOURCES
        mglwin/mglwin.c
        mglwin/public.c

        drivers/common/common.c
        drivers/common/vgapal.c
        drivers/common/gsnap.c
        drivers/snap/snap.c
        drivers/snap/snapvbe.c
        drivers/windows/windd.c
    )
elseif(MGL_PLATFORM_RTTARGET)
    list(APPEND SOURCES
        mglrtt/mglrtt.c

        drivers/common/common.c
        drivers/common/vgapal.c
        drivers/common/gsnap.c
        drivers/snap/snap.c
        drivers/snap/snapvbe.c
        ../common/gartt.c
    )
    list(APPEND DEFINES $<$<COMPILE_LANGUAGE:ASM_NASM>:__RTTARGET__>)
elseif(MGL_PLATFORM_OS2)
    if(MGL_PLATFORM_OS2_GUI)
        message(FATAL_ERROR "mglpm directory missing")
    else()
        list(APPEND SOURCES
            mglos2/mglos2.c

            drivers/common/common.c
            drivers/common/vgapal.c
            drivers/common/gsnap.c
            drivers/snap/snap.c
            drivers/snap/snapvbe.c
        )
    endif()
elseif(MGL_PLATFORM_QNX)
    list(APPEND SOURCES
        mglqnx/mglqnx.c

        drivers/common/common.c
        drivers/common/vgapal.c
        drivers/common/gsnap.c
        drivers/snap/snap.c
        drivers/snap/snapvbe.c
    )
elseif(MGL_PLATFORM_LINUX)
    set(BUILD_DLL ON)
    if(MGL_PLATFORM_BACKEND STREQUAL "X11")
        set(STATIC_LIBNAME "mglx11")
        set(SHARED_LIBNAME "mglx11")
        list(APPEND DEFINES __X11__)
        list(APPEND SOURCES
            mglx11/mglx11.c
            #mouse.c
            mglx11/event.c
            #mglcpp.c

            drivers/common/gunix.c
            drivers/x11/xwindc.c
            #pack1.c
            drivers/common/common.c
            #accel8.c
            #accel16.c
            #accel24.c
            #accel32.c
            ../common/galib.c
            ../common/galinux.c
            ../common/peloader.c
            ../common/libcimp.c
            drivers/packed/packed8.c
            drivers/packed/packed16.c
            drivers/packed/packed24.c
            drivers/packed/packed32.c
#            _pack8.asm
#            _pack16.asm
#            _pack24.asm
#            _pack32.asm
        )
    else()
        list(APPEND SOURCES
            mgllinux/mgllinux.c
            ../common/galinux.c

            drivers/common/common.c
            drivers/common/vgapal.c
            drivers/common/gsnap.c
            drivers/snap/snap.c
            drivers/snap/snapvbe.c
        )
    endif()
elseif(MGL_PLATFORM_DOS)
    list(APPEND DEFINES $<$<COMPILE_LANGUAGE:ASM_NASM>:__REALDOS__>)
    list(APPEND SOURCES
        mgldos/mgldos.c

        drivers/common/common.c
        drivers/common/vgapal.c
        drivers/common/gsnap.c
        drivers/snap/snap.c
        drivers/snap/snapvbe.c
        ../common/gados.c
    )
endif()
list(APPEND SOURCES
    ../libjpeg/jpeglib.c
    ../libjpeg/_jpg_exp.asm

    ../libpng/pnglib.c
    ../libpng/_png_exp.asm

    ../freetype/ttlib.c
    ../freetype/_tt_exp.asm

    asm386/_opengl.asm
    asm386/_glu.asm
)
#target_link_libraries(mgl-shared PRIVATE jpeg-static png-static tiff-static xpm-static)

list(APPEND SOURCES
    ../common/galib.c
    ../common/_ga_imp.asm
)

add_library(mgl-static STATIC ${SOURCES})
target_include_directories(mgl-static PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>")
target_include_directories(mgl-static PUBLIC "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include>")
target_include_directories(mgl-static PUBLIC "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include/snapgl>")
target_link_libraries(mgl-static PRIVATE ${LIBS})
target_compile_definitions(mgl-static PRIVATE ${DEFINES})
if(NOT MGL_CPU_X86)
    target_compile_definitions(mgl-static PRIVATE NO_ASSEMBLER)
endif()
set_property(TARGET mgl-static PROPERTY OUTPUT_NAME "${STATIC_LIBNAME}")

if(BUILD_DLL)
    add_library(mgl-shared SHARED ${SOURCES})
    target_link_option_no_undefined(mgl-shared)
    target_include_directories(mgl-shared PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>")
    target_include_directories(mgl-shared PUBLIC "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include>")
    target_include_directories(mgl-shared PUBLIC "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include/snapgl>")
    target_link_libraries(mgl-shared PRIVATE ${LIBS})
    target_compile_definitions(mgl-shared PRIVATE ${DEFINES})
    if(NOT MGL_CPU_X86)
        target_compile_definitions(mgl-shared PRIVATE NO_ASSEMBLER)
    endif()
    set_property(TARGET mgl-shared PROPERTY DEFINE_SYMBOLD "BUILD_DLL")
    set_property(TARGET mgl-shared PROPERTY OUTPUT_NAME "${SHARED_LIBNAME}")
    set_property(TARGET mgl-shared PROPERTY ARCHIVE_OUTPUT_NAME "${SHARED_IMPORTED_LIBNAME}")
    if(MGL_PLATFORM_WINDOWS OR MGL_PLATFORM_DOS OR MGL_PLATFORM_RTTARGET)
        set_property(TARGET mgl-shared PROPERTY PREFIX "")
    endif()
    add_library(mgl::mgl ALIAS mgl-shared)
else()
    add_library(mgl::mgl ALIAS mgl-static)
endif()

add_library(mglcpp STATIC
    mglrect.cpp
    mglrgn.cpp
)
target_include_directories(mglcpp PUBLIC "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include>")
set_property(TARGET mglcpp PROPERTY OUTPUT_NAME "mglcpp")
