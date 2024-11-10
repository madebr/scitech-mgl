set(SOURCES
    jcapimin.c
    jcapistd.c
    jctrans.c
    jcparam.c
    jdatadst.c
    jcinit.c
    jcmaster.c
    jcmarker.c
    jcmainct.c
    jcprepct.c
    jccoefct.c
    jccolor.c
    jcsample.c
    jchuff.c
    jcphuff.c
    jcdctmgr.c
    jfdctfst.c
    jfdctflt.c
    jfdctint.c

    jdapimin.c
    jdapistd.c
    jdtrans.c
    jdatasrc.c
    jdmaster.c
    jdinput.c
    jdmarker.c
    jdhuff.c
    jdphuff.c
    jdmainct.c
    jdcoefct.c
    jdpostct.c
    jddctmgr.c
    jidctfst.c
    jidctflt.c
    jidctint.c
    jidctred.c
    jdsample.c
    jdcolor.c
    jquant1.c
    jquant2.c
    jdmerge.c
        
    jcomapi.c
    jutils.c
    jerror.c
    jmemmgr.c
    jmemmgl.c
)
set(SHARED_SOURCES )

if(MGL_CPU_X86)
    list(APPEND SHARED_SOURCES
#        dllstart.c
        jpeginit.c
    )
else()
    list(APPEND SHARED_SOURCES
        ../common/initseg.c
        jpeginit.c
    )
endif()

add_library(jpeg-static STATIC
    ${SOURCES}
)
target_include_directories(jpeg-static PRIVATE "${MGL_SOURCE_DIR}/include")
set_property(TARGET jpeg-static PROPERTY OUTPUT_NAME "jpeg")

if(0)
    # FIXME: MGL_fread/MGL_fwrite
    if(MGL_PLATFORM_LINUX OR MGL_PLATFORM_WINDOWS)
        add_library(jpeg-shared SHARED
            ${SOURCES} ${SHARED_SOURCES}
        )
        set_property(TARGET jpeg-shared PROPERTY DEFINE_SYMBOL "BUILD_DLL")
        target_include_directories(jpeg-shared PRIVATE "${MGL_SOURCE_DIR}/include")
        set_property(TARGET jpeg-shared PROPERTY OUTPUT_NAME "jpeg")
        set_property(TARGET jpeg-shared PROPERTY ARCHIVE_OUTPUT_NAME "ijpeg")
        set_property(TARGET jpeg-shared PROPERTY SUFFIX ".bpd")
        set_property(TARGET jpeg-shared PROPERTY PREFIX "")
    endif()
endif()
