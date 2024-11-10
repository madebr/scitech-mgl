add_executable(atlantis
    atlantis.def
    atlantis.rc
    atlantis.c
    dolphin.c
    whale.c
    shark.c
    swim.c
)
target_link_libraries(atlantis PRIVATE mgl::mgl glutw32-shared)
if(MGL_PLATFORM_LINUX)
    target_link_libraries(atlantis PRIVATE m)
endif()
