
if(TESTS)

set(qmltest_SRCS
    qmldir
    Connection.qml
    AvailablePorts.qml
    menu1.qml
    menu2.qml

    tst_MainMenu.qml
    tst_SubMenu.qml
    tst_Controls.qml

    ex_MainMenu.qml
    )

set(qmltest_EXTRA
    placeholder.png
    )

add_info_files(${qmltest_SRCS} ex_MainMenu.qml)

qt5_add_resources(TEST_QRC Test.qrc)

qmltestrunner(test_qml
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
        IMPORT_PATH "${CMAKE_BINARY_DIR}/src"
        ${qmltest_SRCS}
        ${qmltest_EXTRA})

qmlscene(ex_MainMenu ex_MainMenu.qml
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
        IMPORT_PATH "${CMAKE_BINARY_DIR}/src")

endif(TESTS)
