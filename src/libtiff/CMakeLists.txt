set(SOURCES
    tif_aux.c
    tif_close.c
    tif_codec.c
    tif_compress.c
    tif_dir.c
    tif_dirinfo.c
    tif_dirread.c
    tif_dirwrite.c
    tif_dumpmode.c
    tif_error.c
    tif_fax3.c
    tif_fax3sm.c
    tif_getimage.c
    tif_jpeg.c
    tif_flush.c
    tif_lzw.c
    tif_next.c
    tif_open.c
    tif_packbits.c
    tif_predict.c
    tif_print.c
    tif_read.c
    tif_swab.c
    tif_strip.c
    tif_thunder.c
    tif_tile.c
    tif_version.c
    tif_warning.c
    tif_write.c
    tif_zip.c
)
set(SHARED_SOURCES
    tif_bpd.c
)

if(MGL_CPU_X86)
    list(APPEND SHARED_SOURCES
        #        dllstart.c
        tiffinit.c
    )
elseif(MGL_CPU_PPC_BE)
    list(APPEND SHARED_SOURCES
        tiffinit.c
    )
endif()
if(MGL_PLATFORM_WINDOWS)
    list(APPEND SOURCES tif_win32.c)
endif()

add_library(tiff-static STATIC
    ${SOURCES}
)
target_include_directories(tiff-static PRIVATE "${MGL_SOURCE_DIR}/include")
set_property(TARGET tiff-static PROPERTY OUTPUT_NAME "tiff")

if(MGL_PLATFORM_LINUX OR MGL_PLATFORM_WINDOWS)
    add_library(tiff-shared SHARED
        ${SOURCES} ${SHARED_SOURCES}
    )
    target_include_directories(tiff-shared PRIVATE "${MGL_SOURCE_DIR}/include")
    set_property(TARGET tiff-shared PROPERTY OUTPUT_NAME "tiff")
    set_property(TARGET tiff-shared PROPERTY ARCHIVE_OUTPUT_NAME "itiff")
    set_property(TARGET tiff-shared PROPERTY SUFFIX ".bpd")
    set_property(TARGET tiff-shared PROPERTY PREFIX "")
endif()
