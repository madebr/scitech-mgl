add_library(hdabus STATIC
    hdabus.c
    _hda_imp.asm
)
target_include_directories(hdabus PRIVATE "${MGL_SOURCE_DIR}/include")
set_property(TARGET hdabus PROPERTY OUTPUT_NAME "n_hdabus")
