
include(AddInfoFiles)

function(ADD_FILES TARGET)
    cmake_parse_arguments(ADD_FILES "" "DESTINATION" "GLOB;FILES" ${ARGN})
    if(NOT ADD_FILES_DESTINATION)
        message(SEND_ERROR "No destination provided")
    endif(NOT ADD_FILES_DESTINATION)

    set(ADD_FILES_FILES ${ADD_FILES_UNPARSED_ARGUMENTS} ${ADD_FILES_FILES})
    if(ADD_FILES_GLOB)
        foreach(FILENAME ${ADD_FILES_GLOB})
            file(GLOB ADD_FILES_GLOB
                RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
                ${FILENAME})
            list(APPEND ADD_FILES_FILES ${ADD_FILES_GLOB})
        endforeach(FILENAME)
    endif(ADD_FILES_GLOB)

    add_info_files(${ADD_FILES_FILES})
    add_custom_target(${TARGET} ALL
                      SOURCES ${ADD_FILES_FILES})

    foreach(FILEPATH ${ADD_FILES_FILES})
        set(SRC "${FILEPATH}")
        get_filename_component(FILENAME "${FILEPATH}" NAME)
        set(DST "${ADD_FILES_DESTINATION}/${FILENAME}")

        add_custom_command(
            TARGET ${TARGET}
            WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
            COMMAND ${CMAKE_COMMAND} -E copy ${SRC} ${DST}
            DEPENDS ${SRC}
            COMMENT "Copying file: ${FILENAME}"
        )
    endforeach(FILEPATH)
endfunction(ADD_FILES)

