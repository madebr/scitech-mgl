add_executable(sterbmp sterbmp.c)
target_link_libraries(sterbmp PRIVATE mgl::mgl)

add_executable(stertest stertest.c)
target_link_libraries(stertest PRIVATE mgl::mgl)

add_executable(sterdemo sterdemo.c mglsamp.c ../../../src/common/cmdline.c  mglsamp.rc)
target_link_libraries(sterdemo PRIVATE mgl::mgl)
