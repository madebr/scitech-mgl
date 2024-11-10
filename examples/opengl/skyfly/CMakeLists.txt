find_package(GLUT)
if(NOT GLUT_FOUND)
    return()
endif()

option(MGL_SKYFLY_STEREO "Enable stereo in skyfly" OFF)

if(MGL_SKYFLY_GLUT)
    target_sources(skyfly)
endif()
set(SOURCES
    skyfly.def
    skyfly.rc
    skyfly.c
    fly.c
    database.c
    perfdraw.c
    image.c
    random.c
)
add_executable(skyfly_glut
    ${SOURCES}
    glutmain.c
)
target_compile_definitions(skyfly_glut PRIVATE NO_GL_MACROS NO_GLU_MACROS USE_GLUT)
target_link_libraries(skyfly_glut PRIVATE GLUT::GLUT mgl::mgl)

add_executable(skyfly_gm
    ${SOURCES}
    gm_main.c
)
target_link_libraries(skyfly_gm PRIVATE gm mgl::mgl)

if(MGL_SKYFLY_STEREO)
    target_compile_definitions(skyfly_glut PRIVATE STEREO STEREO_DEFAULT)
    target_compile_definitions(skyfly_gm PRIVATE STEREO STEREO_DEFAULT)
endif()
