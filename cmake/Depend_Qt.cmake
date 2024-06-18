
include(FindPkgConfig)
include(Tools)

# handle external cache
if(EXT_CACHE)
    include(ExtCache)
    message(STATUS "Use of external cache : ${EXT_CACHE}")
    # Get options
    load_extern_cache( CACHE_DIR ${EXT_CACHE} VAR_LIST
            "QT_QMAKE_EXECUTABLE"
            "CMAKE_PREFIX_PATH"
          )
endif(EXT_CACHE)

message(STATUS "CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH}")

# find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Gui)
find_package(Qt6 REQUIRED COMPONENTS Widgets)
find_package(Qt6 REQUIRED COMPONENTS LinguistTools)
find_package(Qt6 REQUIRED COMPONENTS Core5Compat)
find_package(Qt6 REQUIRED COMPONENTS QuickControls2)

# Add translations
# include(Translations)

set(QT_LIBRARIES
    ${Qt6Core_LIBRARIES}
    ${Qt6Quick_LIBRARIES}
    ${Qt6Gui_LIBRARIES}
    ${Qt6SerialPort_LIBRARIES}
   )
set(QT_INCLUDES
    ${Qt6Core_INCLUDE_DIRS}
    ${Qt6Quick_INCLUDE_DIRS}
    ${Qt6Gui_INCLUDE_DIRS}
    ${Qt6SerialPort_INCLUDE_DIRS}
   )

# set(QT_USE_FILE "${CMAKE_CURRENT_LIST_DIR}/ECMQt4To5Porting.cmake")
# include("${CMAKE_CURRENT_LIST_DIR}/ECMQt4To5Porting.cmake")

set(QT_BINARY_DIR "${_qt6Core_install_prefix}/bin")
# macro(qt_use_modules)
#     qt6_use_modules(${ARGN})
# endmacro()
