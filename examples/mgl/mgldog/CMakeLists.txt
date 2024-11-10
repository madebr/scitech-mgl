add_executable(mgldog
    mgldog.def
    mgldog.rc
    mgldog.c
    ../../../src/common/cmdline.c
)
target_link_libraries(mgldog PRIVATE mgl::mgl)
