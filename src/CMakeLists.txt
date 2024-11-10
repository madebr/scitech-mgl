# Libraries required by SciTech SNAP SDK
add_subdirectory(pm)
add_subdirectory(gconsole)
add_subdirectory(snap)

if(MGL_PLATFORM_LINUX OR MGL_PLATFORM_WINDOWS)
    # FIXME: possibly required on other platforms
    add_subdirectory(freetype)
    add_subdirectory(libjpeg)
    add_subdirectory(libpng)
    add_subdirectory(libtiff)
    add_subdirectory(libxpm)
endif()

if(MGL_PLATFORM_WINDOWS)
    add_subdirectory(glswitch)
endif()
if(MGL_PLATFORM_WINDOWS)
    add_subdirectory(glutw32)
endif()
add_subdirectory(hdabus)

# FIXME: missing readlink symbol because of "#    define rdsymlnk(p,b,n) readlink(p,b,n)"
if(NOT MGL_PLATFORM_DOS)
    add_subdirectory(infozip)
endif()

# Libraries required by SciTech MGL Graphics Library
add_subdirectory(tech)
add_subdirectory(mvis)
add_subdirectory(fixed)
add_subdirectory(gm)
add_subdirectory(glut)
add_subdirectory(mgl)
