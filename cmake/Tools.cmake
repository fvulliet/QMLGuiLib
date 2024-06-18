include(CMakeParseArguments)

if(WIN32)
    set(CMAKE_INSTALL_BINDIR "bin" CACHE PATH "")
    set(CMAKE_INSTALL_LIBDIR "bin" CACHE PATH "")
    set(CMAKE_INSTALL_INCLUDEDIR "include" CACHE PATH "")
    set(CMAKE_INSTALL_DATADIR "data" CACHE PATH "")
else(WIN32)
    include(GNUInstallDirs)
endif(WIN32)

if(SYSROOT)
    if(EXISTS "${CMAKE_BINARY_DIR}/${SYSROOT}")
        get_filename_component(SYSROOT "${CMAKE_BINARY_DIR}/${SYSROOT}" ABSOLUTE)
    else()
        get_filename_component(SYSROOT "${SYSROOT}" ABSOLUTE)
    endif()
    list(INSERT CMAKE_FIND_ROOT_PATH 0 "${SYSROOT}")
    message(STATUS "CMake will look for dependencies in ${SYSROOT}")
endif(SYSROOT)

set(PROGFILES "Program Files")
set(PROGFILES_32 "Program Files (x86)")

function(find_xlibrary)
    cmake_parse_arguments(XLIB "" "PROJ" "PATHS" ${ARGN})
    if(XLIB_PROJ)
        list(APPEND XLIB_PATHS
                "/${PROGFILES}/${XLIB_PROJ}/bin/"
                "/${PROGFILES_32}/${XLIB_PROJ}/bin/")
    endif()
    list(APPEND XLIB_PATHS "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}"
            "${CMAKE_INSTALL_PREFIX}/lib/${CMAKE_LIBRARY_ARCHITECTURE}"
            "/usr/local/lib" "/usr/local/bin" "/usr/lib" "/usr/bin" "/lib" "/bin")
    find_library(${XLIB_UNPARSED_ARGUMENTS} PATHS ${XLIB_PATHS})
endfunction()

function(find_xprogram)
    cmake_parse_arguments(XPROGRAM "" "PROJ" "PATHS" ${ARGN})
    if(XPROGRAM_PROJ)
        list(APPEND XPROGRAM_PATHS
                "/${PROGFILES}/${XPROGRAM_PROJ}/bin/"
                "/${PROGFILES_32}/${XPROGRAM_PROJ}/bin/")
    endif()
    list(APPEND XPROGRAM_PATHS "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_BINDIR}"
            "${CMAKE_INSTALL_PREFIX}/bin/${CMAKE_LIBRARY_ARCHITECTURE}"
            "/usr/local/bin" "/usr/local/lib" "/usr/bin" "/usr/lib" "/bin" "/lib")
    find_program(${XPROGRAM_UNPARSED_ARGUMENTS} PATHS ${XPROGRAM_PATHS})
endfunction()

function(find_xpath)
    cmake_parse_arguments(XPATH "" "PROJ" "PATHS" ${ARGN})
    if(XPATH_PROJ)
        list(APPEND XPATH_PATHS
                "/usr/include/${XPATH_PROJ}"
                "/usr/local/include/${XPATH_PROJ}"
                "/${PROGFILES}/${XPATH_PROJ}/include/"
                "/${PROGFILES}/${XPATH_PROJ}/include/${XPATH_PROJ}"
                "/${PROGFILES_32}/${XPATH_PROJ}/include/"
                "/${PROGFILES_32}/${XPATH_PROJ}/include/${XPATH_PROJ}")
    endif()
    list(APPEND XPATH_PATHS "/usr/local/include" "/usr/include" "/include")
    find_path(${XPATH_UNPARSED_ARGUMENTS} PATHS ${XPATH_PATHS})
endfunction()

function(find_xqml)
    cmake_parse_arguments(XQML "" "PROJ;MODULE" "PATHS" ${ARGN})
    if(XQML_PROJ)
        list(APPEND XQML_PATHS
                "/${PROGFILES}/${XQML_PROJ}/bin/qml/${XQML_MODULE}"
                "/${PROGFILES_32}/${XQML_PROJ}/bin/qml/${XQML_MODULE}")
    endif()
    list(APPEND XQML_PATHS "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/qml/${XQML_MODULE}"
            "${CMAKE_INSTALL_PREFIX}/lib/${CMAKE_LIBRARY_ARCHITECTURE}/qml/${XQML_MODULE}"
            "/usr/local/lib/qml/${XQML_MODULE}" "/usr/local/bin/qml/${XQML_MODULE}"
            "/usr/lib/qml/${XQML_MODULE}" "/usr/bin/qml/${XQML_MODULE}"
            "/lib/qml/${XQML_MODULE}" "/bin/qml/${XQML_MODULE}")
    find_path(${XQML_UNPARSED_ARGUMENTS} PATHS ${XQML_PATHS})
endfunction()
function(assert test msg)
    if(NOT ${test})
        message(SEND_ERROR ${msg})
    endif()
endfunction()
