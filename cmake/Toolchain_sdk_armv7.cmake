### Android Toolchain (for armv7 arch)
#
# Usage :
#
# In a build subdirectory folder (from the project root directory) :
# - Use the following command to configure the project for  :
# -> "cmake -DCMAKE_TOOLCHAIN_FILE=<this_toolchain_path> -DCMAKE_PREFIX_PATH=<QT_ROOT_PATH>/android_armv7 .."
# Then build the project with :
# -> "make"

cmake_minimum_required(VERSION 3.7.0)

# Enable cross-compiling for Android
set(CMAKE_SYSTEM_NAME Android)

# API level
set(CMAKE_SYSTEM_VERSION 24) # for Android, is equal to API version

# Target architecture (& ABI)
set(CMAKE_ANDROID_ARCH_ABI armeabi-v7a)

# Absolute path to NDK
set(CMAKE_ANDROID_NDK $ENV{ANDROID_NDK})

# C++ standard library to use
set(CMAKE_ANDROID_STL_TYPE gnustl_static)


set(ANDROID_NATIVE_API_LEVEL ${CMAKE_SYSTEM_VERSION})

set(ANDROID_SDK_BUILDTOOLS_REVISION "26.0.2")

set(ANDROID_TOOLCHAIN_PREFIX "arm-linux-androideabi")
set(ANDROID_TOOL_PREFIX ${ANDROID_TOOLCHAIN_PREFIX})

set(ANDROID_GCC_VERSION "4.9")
set(ANDROID_COMPILER_VERSION ${ANDROID_GCC_VERSION})

set(ANDROID_NDK_HOST_SYSTEM_NAME "linux-x86_64")
