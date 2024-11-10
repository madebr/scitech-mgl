add_executable(mgl_bounce bounce.c demo.rc)
target_link_libraries(mgl_bounce PRIVATE mgl::mgl gm::gm)

add_executable(mgl_sprite sprite.c demo.rc)
target_link_libraries(mgl_sprite PRIVATE mgl::mgl gm::gm)

add_executable(mgl_gears gears.c demo.rc)
target_link_libraries(mgl_gears PRIVATE mgl::mgl gm::gm)

