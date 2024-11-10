add_library(n_ga
    gasdk.c
    vgapal.c
)
target_include_directories(n_ga PUBLIC "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>")
