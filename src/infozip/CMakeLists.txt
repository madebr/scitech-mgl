cmake_dependent_option(MGL_INFOZIP_ASM "Build infozip with asm" ON "MGL_CPU_X86" OFF)
add_subdirectory(zip)
add_subdirectory(unzip)
