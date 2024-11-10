add_executable(showbmp
    showbmp.def
    showbmp.rc
    showbmp.c
    ../../../src/common/cmdline.c
)
target_link_libraries(showbmp PRIVATE mgl::mgl)
