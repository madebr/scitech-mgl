find_package(GLUT)
if(NOT GLUT_FOUND)
    return()
endif()
add_executable(ideas
    a.c
    b.c
    d.c
    e.c
    f.c
    h.c
    i.c
    m.c
    n.c
    o.c
    p.c
    r.c
    s.c
    t.c
    w.c
    d_holder.c
    d_lamp.c
    d_logo.c
    d_logol.c
    d_logos.c
    track.c
)
target_link_libraries(ideas PRIVATE mgl::mgl)
if(MGL_PLATFORM_LINUX)
    target_link_libraries(ideas PRIVATE GLUT::GLUT m)
endif()
