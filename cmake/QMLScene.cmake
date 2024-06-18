
find_program(QMLSCENE_EXE qmlscene)
set(QMLSCENE_TEMPLATE ${CMAKE_CURRENT_LIST_DIR}/QMLScene.cpp)

function(_QMLSCENE_ENV VAR)
    if(WIN32)
        set(_SEP ";")
    else()
        set(_SEP ":")
    endif()

    unset(${VAR})
    foreach(_TMP ${ARGN})
        set(${VAR} "${${VAR}}${_SEP}${_TMP}")
    endforeach()
    set(${VAR} "${${VAR}}" PARENT_SCOPE)
endfunction()


function(QMLSCENE TARGET QMLFILE)
    cmake_parse_arguments(SCENE "" "WORKING_DIRECTORY" "IMPORT_PATH;LIB_PATH" ${ARGN})
    if(NOT SCENE_WORKING_DIRECTORY)
        set(SCENE_WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
    endif()
    _QMLSCENE_ENV(SCENE_IMPORT_PATH ${SCENE_IMPORT_PATH})
    _QMLSCENE_ENV(SCENE_LIB_PATH ${SCENE_LIB_PATH})

    add_executable(${TARGET} ${QMLSCENE_TEMPLATE} ${SCENE_UNPARSED_ARGUMENTS})
    target_link_libraries(${TARGET} ${QT_LIBRARIES})
    target_link_libraries(${TARGET} Qt6::Core)
    set_target_properties(${TARGET} PROPERTIES
            COMPILE_FLAGS "-DQML2_IMPORT_PATH=\"\\\"${SCENE_IMPORT_PATH}\\\"\" -DLD_LIBRARY_PATH=\"\\\"${SCENE_LIB_PATH}\\\"\""
            COMPILE_DEFINITIONS "QMLFILE=\"${QMLFILE}\";WORKDIR=\"${SCENE_WORKING_DIRECTORY}\";QMLSCENE=\"${QMLSCENE_EXE}\"")
endfunction(QMLSCENE)
