set(COMMON_SOURCES
    vec3d.c
    xform2d.c
    xform3d.c
)
set(FIXED_SOURCES
    fxatrig.asm
    fxlog.asm
    fxmat2d.asm
    fxmat3d.asm
    fxmisc.asm
    fxpow.asm
    fxsqrt.asm
    fxtrig.asm
    fxmap2d.asm
    fxmap3d.asm
    tables.c
    fxzdiv.asm
)
set(FLOAT_SOURCES
    float.c
    fllog.asm
    flsqrt.asm
    fltrig.asm
)

option(MGL_NOINLINEASM "No inline ASM" OFF)

#FIXME: add 387 alternative, adding 7 to OUTPUT_NAME

add_library(vec_fl
    ${COMMON_SOURCES}
    ${FLOAT_SOURCES}
)
target_include_directories(vec_fl PUBLIC "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include>")
target_include_directories(vec_fl PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}")
target_compile_definitions(vec_fl PUBLIC FX_FLOAT)
set_property(TARGET vec_fl APPEND PROPERTY COMPATIBLE_INTERFACE_STRING FIXED_FORMAT)
set_property(TARGET vec_fl APPEND PROPERTY FIXED_FORMAT "float")


add_library(vec_db
    ${COMMON_SOURCES}
    ${FLOAT_SOURCES}
)
target_include_directories(vec_db PUBLIC "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include>")
target_include_directories(vec_db PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}")
target_compile_definitions(vec_db PUBLIC FX_DOUBLE)
set_property(TARGET vec_db APPEND PROPERTY COMPATIBLE_INTERFACE_STRING FIXED_FORMAT)
set_property(TARGET vec_db APPEND PROPERTY FIXED_FORMAT "double")

add_library(vec_fix
    ${COMMON_SOURCES}
    ${FIXED_SOURCES}
)
target_include_directories(vec_fix PUBLIC "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include>")
target_include_directories(vec_fix PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}")
target_compile_definitions(vec_fix PUBLIC FX_FIXED FIXED386)
set_property(TARGET vec_fix APPEND PROPERTY COMPATIBLE_INTERFACE_STRING FIXED_FORMAT)
set_property(TARGET vec_fix APPEND PROPERTY FIXED_FORMAT "fixed")

if(MGL_NOINLINEASM)
    target_compile_definitions(vec_fl PUBLIC NOINLINEASM)
    target_compile_definitions(vec_db PUBLIC NOINLINEASM)
    target_compile_definitions(vec_fix PUBLIC NOINLINEASM)
endif()

add_executable(fixedtst
    fixedtst.cpp
    fixed.c
    ${FIXED_SOURCES}
)
target_include_directories(fixedtst PUBLIC "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include>")
target_include_directories(fixedtst PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}")
target_compile_definitions(fixedtst PRIVATE FX_FIXED FIXED386)
target_link_libraries(fixedtst PRIVATE pm)

add_executable(fltst_fl
    fltst.cpp
    ${FLOAT_SOURCES}
)
target_include_directories(fltst_fl PUBLIC "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include>")
target_compile_definitions(fltst_fl PRIVATE FX_FLOAT FPU387)
target_link_libraries(fltst_fl PRIVATE pm)

add_executable(fltst_db
    fltst.cpp
    ${FLOAT_SOURCES}
)
target_include_directories(fltst_db PUBLIC "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include>")
target_compile_definitions(fltst_db PRIVATE FX_DOUBLE FPU387)
target_link_libraries(fltst_db PRIVATE pm)

foreach(suffix fl db fix)
    add_executable(vectst_${suffix} vectst.cpp)
    target_link_libraries(vectst_${suffix} PRIVATE vec_db pm)
endforeach()
