add_executable(demo
    demo.def
    demo.rc
    demo.cpp
    main.cpp
    explwind.cpp
    titlwind.cpp
    demoarea.cpp
    demowind.cpp
    ../../../src/common/cmdline.c
)
target_link_libraries(demo PRIVATE mvis tech mglcpp)
target_link_libraries(demo PRIVATE mgl::mgl)
