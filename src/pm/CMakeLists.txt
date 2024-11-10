set(SOURCES)
set(DEFINES)
set(LIBNAME pm)
set(LIBS)
set(LINK_OPTIONS)

if(MGL_PLATFORM_VXD)
    list(APPEND SOURCES
        gztimer.c
        gcpuinfo.c
        vxd/fileio.c
        vxd/pm.c
        ntdrv/_pm.asm
        common/mtrr.c
        common/pcilib.c
        common/agp.c
        common/malloc.c
        common/vgastate.c
        common/gavxd.c
        common/_mtrr.asm
        common/_cpuinfo.asm
        common/_int64.asm
        common/_pcihelp.asm
    )
elseif(MGL_PLATFORM_VXD)
    list(APPEND SOURCES
        gztimer.c
        gcpuinfo.c
        ntdrv/pm.c
        ntdrv/_irq.asm
        ntdrv/_pm.asm
        ntdrv/mem.c
        ntdrv/irq.c
        ntdrv/int86.c
        ntdrv/stdio.c
        ntdrv/stdlib.c
        common/mtrr.c
        common/pcilib.c
        common/agp.c
        common/malloc.c
        common/vgastate.c
        common/gantdrv.c
        common/_mtrr.asm
        common/_cpuinfo.asm
        common/_int64.asm
        common/_pcihelp.asm
    )
elseif(MGL_PLATFORM_WINCE)
    list(APPEND SOURCES
        gevent.c
        gztimer.c
        gcpuinfo.c
        cedrv/pm.c
        cedrv/_pm.asm
        common/mtrr.c
        common/pcilib.c
        common/agp.c
        common/malloc.c
        common/vgastate.c
        common/gacedrv.c
        common/_mtrr.asm
        common/_cpuinfo.asm
        common/_int64.asm
        common/_pcihelp.asm
    )
elseif(MGL_PLATFORM_WINDOWS)
    list(APPEND SOURCES
        gevent.c
        gztimer.c
        gcpuinfo.c
        win32/ddraw.c
        win32/pm.c
        win32/ntservc.c
        common/pcilib.c
        common/agp.c
        common/malloc.c
        ../common/gawin32.c
        common/_joy.asm
        common/_cpuinfo.asm
        common/_int64.asm
        common/_pcihelp.asm
    )
    list(APPEND DEFINES USE_OS_JOYSTICK)
    list(APPEND LIBS winmm)
elseif(MGL_PLATFORM_OS2)
    if(MGL_PLATFORM_OS2_GUI)
        set(LIBNAME pm_pm)
    else()
        set(LIBNAME pm)
    endif()
    list(APPEND SOURCES
        gcpuinfo.c
        gevent.c
        gztimer.c
        os2/pm.c
        os2/dossctl.obj
        os2/_pmos2.asm
        common/mtrr.c
        common/pcilib.c
        common/agp.c
        common/malloc.c
        common/vgastate.c
        common/gaos2.c
        common/_joy.asm
        common/_cpuinfo.asm
        common/_int64.asm
        common/_pcihelp.asm
    )
elseif(MGL_PLATFORM_QNX)
    if(MGL_PLATFORM_BACKEND STREQUAL "PHOTON")
        set(LIBNAME "pm_ph")
        list(APPEND DEFINES "__PHOTON__")
    elseif(MGL_PLATFORM_BACKEND STREQUAL "X11")
        set(LIBNAME "pm_x11")
        list(APPEND DEFINES "__X11__")
        list(APPEND LIBS X11 Xext)
    elseif(MGL_PLATFORM_BACKEND STREQUAL "")
        set(LIBNAME "pm")
    endif()
    list(APPEND SOURCES
        gcpuinfo.c
        gevent.c
        gztimer.c
        qnx/pm.c
        qnx/mtrrqnx.c
        qnx/_mtrrqnx.asm
        common/mtrr.c
        common/pcilib.c
        common/agp.c
        common/malloc.c
        common/unixio.c
        common/vgastate.c
        common/gaqnx.c
        common/_joy.asm
        common/_cpuinfo.asm
        common/_int64.asm
        common/_pcihelp.asm
    )
    set(USE_BIOS 1)
    if(USE_BIOS)
        set(EXTRA_LIBS vbios)
    else()
        set(EXTRA_LIBS vbstubs)
    endif()
    list(APPEND LINK_OPTIONS "-T1")
elseif(MGL_PLATFORM_LINUX)
    if(MGL_PLATFORM_BACKEND STREQUAL "X11")
        set(LIBNAME "pm_x11")
        list(APPEND DEFINES "__X11__")
        list(APPEND LIBS X11 Xext)
    endif()
    list(APPEND SOURCES
        gcpuinfo.c
        gevent.c
        gztimer.c
        linux/pm.c
        linux/mouse.c
        ../common/galinux.c
        common/agp.c
        common/malloc.c
        common/pcilib.c
        common/unixio.c
        common/vgastate.c
    )
    if(MGL_CPU_X86)
        list(APPEND SOURCES
            common/_cpuinfo.asm
            common/_int64.asm
            common/_pcihelp.asm
        )
    elseif(MGL_CPU_X64)
        list(APPEND SOURCES
            common/int64.c
            linux/io.c
        )
    elseif(MGL_CPU_PPC_BE)
        list(APPEND SOURCES
            common/_int64.asm
            linux/io.c
        )
    elseif(MGL_CPU_MIPS_LE)
        list(APPEND SOURCES
            common/int64.c
            linux/iomips.c
        )
    else()
        message(FATAL_ERROR "Unsupported architecture")
    endif()
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        set(PM_BASE_ADDRESS "0x1F7F800000")
    else()
        set(PM_BASE_ADDRESS "0x005F800000")
    endif()
    list(APPEND DEFINES "PM_BASE_ADDRESS=${PM_BASE_ADDRESS}")
    list(APPEND LINK_OPTIONS "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:-Wl,--section-start,.hash=${PM_BASE_ADDRESS}>")
elseif(MGL_PLATFORM_UUU)
    list(APPEND SOURCES
        gevent.c
        gztimer.c
        gcpuinfo.c
        uuu/pm.c
        common/pcilib.c
        common/agp.c
        common/malloc.c
        common/vgastate.c
        common/gauuu.c
        common/mtrr.c
        common/_mtrr.asm
        common/_cpuinfo.asm
        common/_joy.asm
        common/_int64.asm
        common/_pcihelp.asm
    )
    list(APPEND DEFINES "NO_THREADS")
elseif(MGL_PLATFORM_BEOS)
    list(APPEND SOURCES
        beos/pm.c
        gevent.c
        gztimer.c
        gcpuinfo.c
        common/pcilib.c
        common/agp.c
        common/malloc.c
        common/vgastate.c
        common/gabeos.c
        common/_joy.asm
        common/_cpuinfo.asm
        common/_int64.asm
        common/_pcihelp.asm
    )
elseif(MGL_PLATFORM_RTTARGET)
    list(APPEND SOURCES
        gevent.c
        gztimer.c
        gcpuinfo.c
        rttarget/pm.c
        rttarget/pmrtos.c
        rttarget/_pmrtos.asm
        common/mtrr.c
        common/pcilib.c
        common/agp.c
        common/malloc.c
        common/vgastate.c
        common/gartt.c
        common/_joy.asm
        common/_cpuinfo.asm
        common/_int64.asm
        common/_pcihelp.asm
    )
elseif(MGL_PLATFORM_DOS)
    list(APPEND SOURCES
        gcpuinfo.c
        gevent.c
        gztimer.c
        dos/pm.c
        dos/pmdos.c
        dos/_event.asm
        dos/_lztimer.asm
        dos/_pm.asm
        dos/_pmdos.asm
        common/mtrr.c
        common/agp.c
        common/malloc.c
        common/pcilib.c
        common/vgastate.c
        ../common/gados.c
        ../common/aados.c
        common/_mtrr.asm
        common/_joy.asm
        common/_pcihelp.asm
        common/_cpuinfo.asm
        common/_int64.asm
        common/_dma.asm
    )
endif()

# Object modules for keyboard code pages
list(APPEND SOURCES codepage/us_eng.c)

list(APPEND SOURCES ../common/galib.c ../common/gaoption.c ../common/aalib.c)

# Common object modules
list(APPEND SOURCES
    common.c
    debug.c
    ../common/ddclib.c
)


if(MGL_AGPTEST_HARNESS)
    list(APPEND DEFINES AGP_TEST_HARNESS)
    if(MGL_PLATFORM_LINUX)
        # FIXME: BUILD_SO
        # FIXME: ok to add always?
        list(APPEND LIBS n_agp)
    endif()
endif()

if(MGL_TEST_HARNESS)
    list(APPEND DEFINES TEST_HANRESS PMLIB)
    if(MGL_PLATFORM_LINUX)
        # FIXME: BUILD_SO
        # FIXME: ok to add always?
        list(APPEND LIBS n_driver n_ref2d)
        if(MGL_DEBUG_MATRIX)
            list(APPEND LIBS mgahal)
        endif()
    else()
        set(LIBNAME "pm_test")
    endif()
else()
    if(MGL_CPU_X86)
        list(APPEND SOURCES
            ../common/_ga_imp.asm
            ../common/_aa_imp.asm
        )
    elseif(MGL_CPU_X64)
        list(APPEND SOURCES
            ../common/_ga_imp.s_amd64
        )
    elseif(MGL_CPU_PPC_BE)
        list(APPEND SOURCES
            _ga_imp.s_ppc
        )
    elseif(MGL_CPU_MIPS_LE)
        list(APPEND SOURCES
            _ga_imp.s_mips
        )
    else()
        message(FATAL_ERROR "Unsupported architecture")
    endif()
endif()

if(MGL_PLATFORM_LINUX)
    # FIXME: BUILD_SO
    if(MGL_PTHREAD)
        list(APPEND LIBS pthread)
    endif()
endif()

if(MGL_DEBUG_SDDPMI)
    list(APPEND DEFINES DEBUG_SDDPMI)
endif()

if(MGL_DEBUG_AGP_DRIVER)
    list(APPEND DEFINES DEBUG_AGP_DRIVER)
    list(APPEND SOURCES
        ../common/agplib.c
    )
else()
    list(APPEND SOURCES
        ../common/agplib.c
        ../common/libcimp.c
    )
    if(MGL_CPU_X86)
        list(APPEND SOURCES
            ../common/_gatimer.asm
            ../common/peloader.c
        )
        if(MGL_CHECKED)
            list(APPEND SOURCES
                ../common/_peloadr.asm
            )
        endif()
    elseif(MGL_CPU_X64)
        list(APPEND SOURCES
            ../common/gatimer.c
            ../common/elfldr64.c
        )
    elseif(MGL_CPU_PPC_BE)
        list(APPEND SOURCES
            ../common/_gatimer.asm
            ../common/elfloadr.c
        )
    elseif(MGL_MIPS_LE)
        list(APPEND SOURCES
            ../common/gatimer.c
            ../common/elfloadr.c
        )
    else()
        message(FATAL_ERROR "Unsupported architecture")
    endif()
endif()

add_library(pm STATIC
    ${SOURCES}
)
add_library(pm::pm ALIAS pm)
set_property(TARGET pm PROPERTY POSITION_INDEPENDENT_CODE TRUE)
target_compile_definitions(pm PRIVATE ${DEFINES})
target_link_options(pm PRIVATE ${LINK_OPTIONS})
target_link_libraries(pm PRIVATE ${LIBS})
set_property(TARGET pm PROPERTY OUTPUT_NAME "${LIBNAME}")
target_include_directories(pm PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>")
target_include_directories(pm PUBLIC "$<BUILD_INTERFACE:${MGL_SOURCE_DIR}/include>")

function(add_pm_test_executable NAME)
    add_executable(pm_${NAME} ${ARGN})
    target_link_libraries(pm_${NAME} PRIVATE pm)
endfunction()

add_pm_test_executable(memtest tests/memtest.c)
add_pm_test_executable(video tests/video.c)
add_pm_test_executable(isvesa tests/isvesa.c)
add_pm_test_executable(callreal tests/callreal.c)
add_pm_test_executable(getch tests/getch.c)
add_pm_test_executable(timerc tests/timerc.c)
add_pm_test_executable(showpci tests/showpci.c)
add_pm_test_executable(uswc tests/uswc.c)
add_pm_test_executable(block tests/block.c)
add_pm_test_executable(test tests/test.c)
add_pm_test_executable(hello tests/hello.c)
add_pm_test_executable(bpdpath tests/bpdpath.c)
add_pm_test_executable(fatal tests/fatal.c)
add_pm_test_executable(timercpp tests/timercpp.cpp)
if(MGL_PLATFORM_DOS AND CMAKE_SIZEOF_VOID_P EQUAL 2)
    add_pm_test_executable(biosptr tests/biosptr.c)
    add_pm_test_executable(mouse tests/mouse.c)
    add_pm_test_executable(tick tests/tick.c)
    add_pm_test_executable(irq tests/irq.c)
    add_pm_test_executable(key tests/key.c)
    add_pm_test_executable(key15 tests/key15.c)
    add_pm_test_executable(brk tests/brk.c)
    add_pm_test_executable(altbrk tests/altbrk.c)
    add_pm_test_executable(critical tests/critical.c)
    add_pm_test_executable(altcrit tests/altcrit.c)
    add_pm_test_executable(rtc tests/rtc.c)
    add_pm_test_executable(cpu tests/cpu.c)
else()
    add_pm_test_executable(name tests/name.c)
    add_pm_test_executable(shmem tests/shmem.c)
endif()
if(MGL_PLATFORM_LINUX)
    add_pm_test_executable(memiobase tests/memiobase.c)
    add_pm_test_executable(save tests/save.c)
    add_pm_test_executable(restore tests/restore.c)
endif()
