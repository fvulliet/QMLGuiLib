cmake_minimum_required(VERSION 2.8)

if (UNIX AND TOOLS)
    install(FILES pack/QmlGuiLib.desktop DESTINATION share/applications)
endif (UNIX AND TOOLS)

macro(GET_PATHS VAR)
    foreach(_FILE ${ARGN})
        get_filename_component(_FILEPATH "${_FILE}" PATH)
        set(_PATHS ${_PATHS} "${_FILEPATH}")
    endforeach()
    set(${VAR} ${_PATHS})
endmacro()

if(MINGW)
    message(STATUS "Installing system-libraries: MinGW DLLs.")
    get_filename_component(Mingw_Path ${CMAKE_CXX_COMPILER} PATH)
    set(DIRS ${Mingw_Path})

    install(FILES
        ${QT_BINARY_DIR}/../plugins/platforms/qminimal.dll
        ${QT_BINARY_DIR}/../plugins/platforms/qwindows.dll
        DESTINATION bin/platforms
        CONFIGURATIONS Release
        COMPONENT Runtime)
    install(FILES
        ${QT_BINARY_DIR}/../plugins/platforms/qminimald.dll
        ${QT_BINARY_DIR}/../plugins/platforms/qwindowsd.dll
        DESTINATION bin/platforms
        CONFIGURATIONS Debug
        COMPONENT Runtime)
    message(STATUS "Installing QML plugins.")
    install(FILES
        ${QT_BINARY_DIR}/../qml/QtQuick.2/qtquick2plugin.dll
        ${QT_BINARY_DIR}/../qml/QtQuick.2/qmldir
        DESTINATION bin/qml/QtQuick.2
        CONFIGURATIONS Release
        COMPONENT Runtime)
    install(FILES
        ${QT_BINARY_DIR}/../qml/QtQuick.2/qtquick2plugind.dll
        ${QT_BINARY_DIR}/../qml/QtQuick.2/qmldir
        DESTINATION bin/qml/QtQuick.2
        CONFIGURATIONS Debug
        COMPONENT Runtime)

    install(DIRECTORY
        ${QT_BINARY_DIR}/../qml/QtGraphicalEffects/
        DESTINATION bin/qml/QtGraphicalEffects/
        COMPONENT Runtime)

    # Qt5Widgets required by qtquickcontrolsplugin.dll
    install(FILES
        ${QT_BINARY_DIR}/Qt5Widgets.dll
        DESTINATION bin
        CONFIGURATIONS Release
        COMPONENT Runtime)

    install(FILES
        ${QT_BINARY_DIR}/../qml/QtQuick/Window.2/windowplugin.dll
        ${QT_BINARY_DIR}/../qml/QtQuick/Window.2/qmldir
        ${QT_BINARY_DIR}/../qml/QtQuick/Window.2/plugins.qmltypes
        DESTINATION bin/qml/QtQuick/Window.2
        CONFIGURATIONS Release
        COMPONENT Runtime)
    install(FILES
        ${QT_BINARY_DIR}/../qml/QtQuick/Window.2/windowplugind.dll
        ${QT_BINARY_DIR}/../qml/QtQuick/Window.2/qmldir
        ${QT_BINARY_DIR}/../qml/QtQuick/Window.2/plugins.qmltypes
        DESTINATION bin/qml/QtQuick/Window.2
        CONFIGURATIONS Debug
        COMPONENT Runtime)

    file(GLOB_RECURSE QTQUICKCONTROLSPRIV_FILES ${QT_BINARY_DIR}/../qml/QtQuick/Controls/Private/*)
    install(FILES
        ${QTQUICKCONTROLSPRIV_FILES}
        DESTINATION bin/qml/QtQuick/Controls/Private
        COMPONENT Runtime)

    file(GLOB_RECURSE QTQUICKCONTROLSSTYLESBASE_FILES ${QT_BINARY_DIR}/../qml/QtQuick/Controls/Styles/Base/*)
    install(FILES
        ${QTQUICKCONTROLSSTYLESBASE_FILES}
        DESTINATION bin/qml/QtQuick/Controls/Styles/Base
        COMPONENT Runtime)

    install(FILES
        ${QT_BINARY_DIR}/../qml/QtQuick/Controls/Styles/qmldir
        DESTINATION bin/qml/QtQuick/Controls/Styles
        COMPONENT Runtime)

    install(FILES
        "${CMAKE_CURRENT_LIST_DIR}/qt-mingw.conf"
        RENAME "qt.conf"
        DESTINATION bin
        COMPONENT Runtime)

endif(MINGW)

include(InstallRequiredSystemLibraries)

if(CMAKE_HOST_UNIX)

find_program(CPACK_COMMAND NAMES cpack cpack.exe PATHS
    ${CPACK_PATH}
    ENV PATHS
    $ENV{CPACK_PATH})
add_custom_target(deb-package
        COMMAND ${CPACK_COMMAND} --config ${CMAKE_CURRENT_LIST_DIR}/DebDevel.cmake
        COMMAND ${CPACK_COMMAND} --config ${CMAKE_CURRENT_LIST_DIR}/DebRuntime.cmake
        )
endif(CMAKE_HOST_UNIX)
