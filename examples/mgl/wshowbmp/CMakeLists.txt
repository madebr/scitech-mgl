add_executable(wshowbmp
    wshowbmp.def
    wshowbmp.rc
    wshowbmp.c
)
target_link_libraries(wshowbmp PRIVATE mgl::mgl)
