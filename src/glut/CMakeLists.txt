option(MGL_DEBUG_OPENGL "Debug OpenGL" OFF)

set(SOURCES
    g_9x15.cpp
    g_bitmap.cpp
    g_bwidth.cpp
    g_cindex.cpp
    g_cursor.cpp
    g_dials.cpp
    g_event.cpp
    g_ext.cpp
    g_fullsc.cpp
    g_get.cpp
    g_hel10.cpp
    g_hel12.cpp
    g_hel18.cpp
    g_init.cpp
    g_input.cpp
    g_menu.cpp
    g_modifr.cpp
    g_mroman.cpp
    g_overly.cpp
    g_roman.cpp
    g_shapes.cpp
    g_space.cpp
    g_stroke.cpp
    g_swidth.cpp
    g_tablet.cpp
    g_teapot.cpp
    g_tr10.cpp
    g_tr24.cpp
    g_util.cpp
    g_win.cpp
    ../common/cmdline.c
)
if(MGL_PLATFORM_WINDOWS)
    list(APPEND SOURCES winmain.c)
endif()

add_library(glut-static STATIC ${SOURCES})
target_include_directories(glut-static PRIVATE "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include>")
target_include_directories(glut-static PRIVATE "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include/snapgl>")
if(DEBUG_OPENGL)
    target_compile_definitions(glut-static PRIVATE NO_GL_MACROS)
endif()
set_property(TARGET glut-static PROPERTY OUTPUT_NAME "glut")

add_library(glut-shared STATIC ${SOURCES})
target_include_directories(glut-shared PRIVATE "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include>")
target_include_directories(glut-shared PRIVATE "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include/snapgl>")
target_compile_definitions(glut-shared PRIVATE NO_GL_MACROS)
set_property(TARGET glut-static PROPERTY OUTPUT_NAME "mglglut")
