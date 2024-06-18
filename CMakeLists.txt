cmake_minimum_required(VERSION 3.25)
set(CMAKE_CXX_STANDARD 17)


cmake_policy(SET CMP0020 NEW)
if(POLICY CMP0042)
  cmake_policy(SET CMP0042 NEW)
endif(POLICY CMP0042)
if(POLICY CMP0043)
  cmake_policy(SET CMP0043 NEW)
endif(POLICY CMP0043)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

project(QMLGuiLib CXX C)

# # POKY will overide the CMAKE_MODULE_PATH after project call
# # So make sure the right path is in it
# if (NOT(${CMAKE_MODULE_PATH} MATCHES ".*${CMAKE_SOURCE_DIR}/cmake.*"))
#     set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})
# endif()

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release")
endif(NOT CMAKE_BUILD_TYPE)

# include(GitVersion)

# version in the format 1.0.0
set(VER_MAJOR 1)
set(VER_MINOR 0)
# set(VER_PATCH "${GIT_COUNT}")
set(VER_PATCH 42)
set(VERSION "${VER_MAJOR}.${VER_MINOR}.${VER_PATCH}")

message(STATUS "Configuring version: ${VERSION}")
file(WRITE ${CMAKE_BINARY_DIR}/.version ${VERSION})

# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC True)

include(Depend_Qt)
include(QMLScene)
include(AddInfoFiles)
include(QMLTestRunner)
include(CopyFiles)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -pedantic")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Wpedantic -Werror")

configure_file("config.h.in" "config.h")

add_subdirectory(src)
add_subdirectory(tests)
add_subdirectory(examples)

include(Pack)

set(QML_IMPORT_PATH ${CMAKE_SOURCE_DIR}/qml ${CMAKE_BINARY_DIR}/src CACHE STRING "" FORCE)
set(QML2_IMPORT_PATH ${CMAKE_SOURCE_DIR}/qml ${CMAKE_BINARY_DIR}/src CACHE STRING "" FORCE)


