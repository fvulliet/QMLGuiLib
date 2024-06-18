
find_program(GIT_EXE NAMES git git.cmd PATHS
    ${GIT_PATH}
    ENV PATH
    $ENV{GIT_PATH}
    CMAKE_FIND_ROOT_PATH_BOTH)

if(NOT GIT_EXE)
    find_package(Git)
    if(GIT_FOUND)
        set(GIT_EXE ${GIT_EXECUTABLE})
    endif(GIT_FOUND)
endif(NOT GIT_EXE)

if(NOT CMAKE_SCRIPT_MODE_FILE)
    add_custom_target(git_check ALL DEPENDS ${CMAKE_BINARY_DIR}/.git_version)
    set(GIT_WORKDIR "${CMAKE_SOURCE_DIR}")
    add_custom_command(
        OUTPUT ${CMAKE_BINARY_DIR}/.git_version
        COMMAND ${CMAKE_COMMAND} -DGIT_WORKDIR="${GIT_WORKDIR}" -P "${CMAKE_CURRENT_LIST_FILE}"
        DEPENDS ${CMAKE_SOURCE_DIR}/.git)
endif(NOT CMAKE_SCRIPT_MODE_FILE)

execute_process(
    COMMAND ${GIT_EXE} "log" "--pretty=format:"
    WORKING_DIRECTORY "${GIT_WORKDIR}"
    ERROR_FILE "${CMAKE_BINARY_DIR}/.git_error.log"
    OUTPUT_FILE ${CMAKE_BINARY_DIR}/.git_version
    )
file(READ ${CMAKE_BINARY_DIR}/.git_version GIT_COUNT)
string(LENGTH "${GIT_COUNT}" GIT_COUNT)
file(WRITE ${CMAKE_BINARY_DIR}/.git_version ${GIT_COUNT})
message(STATUS "Count commits: ${GIT_COUNT}")
