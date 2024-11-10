add_executable(alphapng alphapng.c)
target_link_libraries(alphapng PRIVATE mgl::mgl)

add_executable(convert convert.c)
target_link_libraries(convert PRIVATE mgl::mgl)
