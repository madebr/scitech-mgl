add_executable(mgldoom
    doomdef.c
    doomstat.c
    dstrings.c
    tables.c
    f_finale.c
    f_wipe.c
    d_net.c
    d_items.c
    g_game.c
    m_menu.c
    m_misc.c
    m_argv.c
    m_bbox.c
    m_fixed.c
    m_swap.c
    m_cheat.c
    m_random.c
    am_map.c
    p_ceilng.c
    p_doors.c
    p_enemy.c
    p_floor.c
    p_inter.c
    p_lights.c
    p_map.c
    p_maputl.c
    p_plats.c
    p_pspr.c
    p_setup.c
    p_sight.c
    p_spec.c
    p_switch.c
    p_mobj.c
    p_telept.c
    p_tick.c
    p_saveg.c
    p_user.c
    r_bsp.c
    r_data.c
    r_draw.c
    r_main.c
    r_plane.c
    r_segs.c
    r_sky.c
    r_things.c
    w_wad.c
    wi_stuff.c
    v_video.c
    st_lib.c
    st_stuff.c
    hu_stuff.c
    hu_lib.c
    s_sound.c
    z_zone.c
    info.c
    sounds.c
    i_system.c
    i_video.c
    i_main.c
)
if(MGL_CPU_X86)
    target_sources(mgldoom PRIVATE fpfunc.asm)
endif()

if(MGL_PLATFORM_DOS)
    target_sources(mgldoom PRIVATE
        i_netd.c d_maind.c
    )
elseif(MGL_PLATFORM_OS2)
    target_sources(mgldoom PRIVATE
        i_sound.c i_net.c d_main.c
    )
elseif(MGL_PLATFORM_LINUX)
    target_sources(mgldoom PRIVATE
        i_soundd.c i_netu.c d_main.c
    )
    target_compile_definitions(mgldoom PRIVATE NORMALUNIX __UNIX__ LINUX)
elseif(MGL_PLATFORM_QNX)
    target_sources(mgldoom PRIVATE
        i_soundd.c i_netd.c d_main.c
    )
    target_compile_definitions(mgldoom PRIVATE NORMALUNIX __UNIX__ QNX)
elseif(MGL_PLATFORM_WINDOWS)
    target_sources(mgldoom PRIVATE
        i_soundd.c i_netd.c d_maind.c
    )
    target_compile_definitions(mgldoom PRIVATE NORMALUNIX DOS)
elseif(MGL_PLATFORM_RTTARGET)
    target_sources(mgldoom PRIVATE
        i_soundd.c i_netd.c d_maind.c
    )
    target_compile_definitions(mgldoom PRIVATE NORMALUNIX DOS)
endif()

target_link_libraries(mgldoom PRIVATE mgl::mgl)
