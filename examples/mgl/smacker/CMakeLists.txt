option(MGL_SMACKER "Build MGL smacker example" OFF)

if(MGL_SMACKER)
    add_executable(smacker
        play.def
        play.rc
        play.c
    )
    target_link_libraries(smacker PRIVATE ztimer)
    if(MGL_PLATFORM_WINDOWS)
        if(CMAKE_SIZEOF_VOID_P EQUAL 2)
            target_link_libraries(smacker PRIVATE smackw16)
        elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
            target_link_libraries(smacker PRIVATE smackw32)
        else()
            target_link_libraries(smacker PRIVATE smackw64)
        endif()
    else()
        target_link_libraries(smacker PRIVATE smack msslite)
    endif()
    target_link_libraries(smacker PRIVATE mgl::mgl)
endif()
