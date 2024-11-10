set(SOURCES
    glut_8x13.c
    glut_9x15.c
    glut_bitmap.c
    glut_bwidth.c
    glut_cindex.c
    glut_cmap.c
    glut_cursor.c
    glut_dials.c
    glut_dstr.c
    glut_event.c
    glut_ext.c
    glut_fbc.c
    glut_fullscrn.c
    glut_gamemode.c
    glut_get.c
    glut_hel10.c
    glut_hel12.c
    glut_hel18.c
    glut_init.c
    glut_input.c
    glut_joy.c
    glut_key.c
    glut_keyctrl.c
    glut_keyup.c
    glut_mesa.c
    glut_modifier.c
    glut_mroman.c
    glut_overlay.c
    glut_roman.c
    glut_shapes.c
    glut_space.c
    glut_stroke.c
    glut_swap.c
    glut_swidth.c
    glut_tablet.c
    glut_teapot.c
    glut_tr10.c
    glut_tr24.c
    glut_util.c
    glut_vidresize.c
    glut_warp.c
    glut_win.c
    glut_winmisc.c
    win32_glx.c
    win32_menu.c
    win32_util.c
    win32_winproc.c
    win32_x11.c
)

add_library(glutw32-static STATIC
    ${SOURCES}
)
target_include_directories(glutw32-static PRIVATE "${MGL_SOURCE_DIR}/include")
target_include_directories(glutw32-static PRIVATE "${MGL_SOURCE_DIR}/include/snapgl")
target_compile_definitions(glutw32-static PUBLIC __USE_GLUTW32__)
target_compile_definitions(glutw32-static PUBLIC _STDCALL_SUPPORTED)
set_property(TARGET glutw32-static PROPERTY OUTPUT_NAME "glut")
target_link_libraries(glutw32-static PRIVATE opengl32 winmm glu32)

add_library(glutw32-shared SHARED
    ${SOURCES} glut32.def glut_init.c
)
target_include_directories(glutw32-shared PRIVATE "${MGL_SOURCE_DIR}/include")
target_include_directories(glutw32-shared PRIVATE "${MGL_SOURCE_DIR}/include/snapgl")
target_compile_definitions(glutw32-shared PRIVATE NO_GL_MACROS NO_GLU_MACROS NO_WGL_MACROS)
target_compile_definitions(glutw32-shared PUBLIC __USE_GLUTW32__)
target_compile_definitions(glutw32-shared PUBLIC _STDCALL_SUPPORTED)
set_property(TARGET glutw32-shared PROPERTY OUTPUT_NAME "glut32")
set_property(TARGET glutw32-shared PROPERTY PREFIX "")
set_property(TARGET glutw32-shared PROPERTY ARCHIVE_OUTPUT_NAME "glut32")
set_property(TARGET glutw32-shared PROPERTY DEFINE_SYMBOL "_DLL")
target_link_libraries(glutw32-shared PRIVATE opengl32 winmm glu32)

add_library(glutw32::glutw32 ALIAS glutw32-shared)
