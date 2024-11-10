option(MGL_ISV_LICENSE "Build examples with ISV license" OFF)
if(MGL_ISV_LICENSE)
    add_compile_definitions(-DISV_LICENSE)
endif()

# FIXME: Add these
add_subdirectory(mgl)
add_subdirectory(mgldoom)
if(MGL_PLATFORM_LINUX OR MGL_PLATFORM_WINDOWS)
    add_subdirectory(opengl)
endif()
#add_subdirectory(snap)
