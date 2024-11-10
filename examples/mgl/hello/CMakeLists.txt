add_executable(hello hello.c)
target_link_libraries(hello PRIVATE mgl::mgl)

add_executable(direct direct.c)
target_link_libraries(direct PRIVATE mgl::mgl)
