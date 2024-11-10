cmake_dependent_option(FOXBEAR_SOUND "Build foxbear with sound support" ON "MGL_PLATFORM_DOS OR MGL_PLATFORM_WINDOWS" OFF)
option(FOXBEAR_DIAMONDWARE "Use Diamond FoxWare for sound" OFF)

add_executable(foxbear
    foxbear.def
    foxbear.rc
    foxbear.cpp
    fox.cpp
    bear.cpp
    apple.cpp
    fxsprite.cpp
    fxplane.cpp
)
if(FOXBEAR_SOUND)
    target_sources(foxbear PRIVATE sound.c)
endif()
if(FOXBEAR_DIAMONDWARE)
    target_sources(foxbear PRIVATE err.c)
    if(MGL_PLATFORM_WINDOWS)
        target_link_libraries(foxbear PRIVATE dwsw32)
    else()
        target_link_libraries(foxbear PRIVATE dwsp)
    endif()
endif()
target_link_libraries(foxbear PRIVATE gm-shared mglcpp)
target_link_libraries(foxbear PRIVATE mgl::mgl)
