# include(${QT_USE_FILE})

# Include GuiLib sources
include_directories(
    ${CMAKE_SOURCE_DIR}/src
    ${CMAKE_SOURCE_DIR}/src/GuiLib)

# define Headers for GuiLibDemo
set(GUILIBDEMO_HEADERS
    FirmwareTools.hpp)
# define sources for GuiLibDemo
set(GUILIBDEMO_SRC
    FirmwareTools.cpp
    main.cpp
)

# QML files
set(GUILIBDEMO_QML
    GuiLibDemo.qml
    IconsView.qml
    SubMenuView1.qml
    SubMenuView2.qml
    NoSubMenuView.qml
    DisplayListView.qml
    LayoutItemSample.qml
    ControlsPage.qml
    IconsView.qml
    ControlsView2.qml
    ControlsView3.qml
    ControlsView4.qml
    ControlsView5.qml
    GaugeView.qml
    DateTimePickerView.qml
    NavigationView.qml
    InnerView1.qml
    InnerView2.qml
    InnerView21.qml
    InnerView22.qml
    Settings.qml
    ProgressView.qml
    MainMenuConfigView.qml
    DialView.qml
    TBIcons.qml
    TBIconsNew.qml
    TBIconsModel.qml
    DemoHeader.qml
    TypoView.qml
    ExtendedMenuView.qml
    ExtendedMenu.qml
    CommonIconsView.qml
    CommonIconsModel.qml
    DisplayListViewMenu.qml
    InlineListView.qml
    CarouselView.qml
    HB1.qml
    HB2.qml
    HB3.qml
    Layout_3BlocksView.qml
    LayoutGrid1View.qml
    LayoutGrid2View.qml
    LayoutGrid4View.qml
    LayoutGrid6View.qml
    GridMenuView.qml
    GridMenuView2.qml
    LanguageView.qml
    ThemeView.qml
    TranslationView.qml
    DisplayLayoutMenu.qml
    ScopeListView.qml
    WidgetsView.qml
    SmartListView.qml
    TabsView.qml
    PopupView.qml
    DragDropView.qml
    ChartsView.qml
    ClockView.qml
    IconLabView.qml
    ColorsView.qml
    ControlWidgetsView.qml
    MagnifiedGridView.qml
    LabPage.qml
    WebRemoteView.qml
    WebRemote_1.qml
    WebRemote_2.qml
    WebRemote_3.qml
    WebRemote_4.qml
    SchedulersView.qml
    DraggedRectangle.qml
    ConnectorsView.qml
   )

# Translations files
set(LANGUAGES
    GuiLibDemo_enEN.ts
    GuiLibDemo_deDE.ts
    GuiLibDemo_frFR.ts
)

# translations builds
if (UPDATE_TRANSLATIONS)
  message("WARNING: 'make clean' will wipe out the *.ts translation file if executed")
  if (NOOBS)
    # compute both TS files from sources and QM files from TS files without loss
    QT_CREATE_TRANSLATION(LANGUAGES_QM "${CMAKE_SOURCE_DIR}" ${LANGUAGES} OPTIONS "-no-obsolete")
  else (NOOBS)
    # replace both TS files from sources and QM files from TS files
    QT_CREATE_TRANSLATION(LANGUAGES_QM "${CMAKE_SOURCE_DIR}" ${LANGUAGES})
  endif (NOOBS)
else ()
    # compute QM files from existing TS files
    QT_ADD_TRANSLATION(LANGUAGES_QM ${LANGUAGES})
endif (UPDATE_TRANSLATIONS)

# # add QM files to current source directory
add_files(QMFiles
    FILES ${qm_files}
    DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}")

  # BUILD QMLGuiLibDemo

# build the qrc file for GuiLibDemo
qt6_add_resources(GUILIBDEMO_QRC main.qrc)
# define the executable with sources and ressources
add_executable(QMLGuiLibDemo ${GUILIBDEMO_SRC} ${GUILIBDEMO_HEADERS} ${GUILIBDEMO_QRC})
add_dependencies(QMLGuiLibDemo QMFiles)

# link with required Qt Libraries
target_link_libraries(QMLGuiLibDemo Qt6::Gui Qt6::Quick Qt6::Widgets Qt6::QuickControls2)
# link GuiLib to Demo
target_link_libraries(QMLGuiLibDemo GuiLib)

# target_link_libraries(QMLGuiLibDemo PUBLIC Qt6::Core5Compat)


# build Demo apk
# install QMLGuiLibDemo to bindir
install(TARGETS QMLGuiLibDemo
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR} COMPONENT Runtime
  BUNDLE DESTINATION . COMPONENT Runtime)

# define QMLGuiLibDemo as APPS
set(APPS ${APPS} "${CMAKE_CURRENT_BINARY_DIR}/QMLGuiLibDemo${CMAKE_EXECUTABLE_SUFFIX}" PARENT_SCOPE)

# define the qmlscene for the GuiLibDemo
qmlscene(qmlscene ${CMAKE_CURRENT_BINARY_DIR}/main.qml
    IMPORT_PATH "${CMAKE_BINARY_DIR}/src/GuiLib"
    LIB_PATH "${CMAKE_CURRENT_BINARY_DIR}" "${CMAKE_BINARY_DIR}/src/GuiLib")
