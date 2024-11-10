add_executable(wmgldog
    wmgldog.def
    wmgldog.rc
    wmgldog.c
)
target_link_libraries(wmgldog PRIVATE mgl::mgl)
