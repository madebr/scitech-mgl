add_library(glswitch STATIC
    glswitch.c
    _glstub.asm
    _glustub.asm
    _wglstub.asm
)
target_include_directories(glswitch PRIVATE "${MGL_SOURCE_DIR}/include")
target_include_directories(glswitch PRIVATE "${MGL_SOURCE_DIR}/include/snapgl")
