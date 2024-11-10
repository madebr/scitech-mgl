add_library(gconsole gconsole.c)
target_include_directories(gconsole PUBLIC "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>")
