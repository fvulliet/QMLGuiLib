# include(${QT_USE_FILE})

# Binary dir required for config.h (which is generated)
include_directories(${CMAKE_BINARY_DIR})

######################
### GUILIB LIBRARY
######################

# C++ public Headers
set(GUILIB_HEADERS
    GuiLib.hpp
    GuiLib_export.hpp
    TranslationManagement.hpp
    GuiLibFontLoader.hpp
   )

# C++ Sources
set(GUILIB_SRC
    GuiLib.cpp
    TranslationManagement.cpp
    GuiLibFontLoader.cpp
    Singleton.cpp
   )

# QML File defined as Singleton (to build the qmldir)
set(GUILIB_QML_SINGLETON
    Colors.qml
    Fonts.qml
    Style.qml
    )

# QML File defined as Internal (to build the qmldir)
set(GUILIB_QML_PRIV
    )

set(GUILIB_QML_JS
    FontAwesome.js
    FontAwesomeBrand.js
    FontAwesomeRegular.js
    FontAwesomeSolid.js
    GoogleMaterial.js
    SfyIco.js
    Utils.js
    )

# QML File defined as Public (to build the qmldir)
set(GUILIB_QML_PUB
    ActionsMenuHeader.qml
    ActionsMenuTabs.qml
    AppWindow.qml
    Button.qml
    ButtonInput.qml
    Carousel.qml
    CarouselNav.qml
    CheckBox.qml
    Clickable.qml
    Compass.qml
    Compass2.qml
    DataElement.qml
    DataTextValue.qml
    DiscoveryItem.qml
    DraggableScrollBar.qml
    Dropdown.qml
    ExtendedMenuHeader.qml
    Extensible.qml
    FloatingButton.qml
    FocusArea.qml
    FontIcon.qml
    FunctionDisplay.qml
    GridMenu.qml
    GridMenuCell.qml
    Hole.qml
    IconButton.qml
    IconTitle.qml
    ItemShadow.qml
    Layout_3Blocks.qml
    LayoutGrid.qml
    Layout_Standard.qml
    KeyboardInput.qml
    Knob.qml
    MainMenu.qml
    MainPage.qml
    Modal.qml
    ModalLoader.qml
    NavIcon.qml
    NavHistory.qml
    NumberSpinBox.qml
    Page.qml
    PageLoader.qml
    ProgressBar.qml
    ProgressItem.qml
    RadioButton.qml
    RangeWidget.qml
    RemoteBtn.qml
    ScopeList.qml
    ScrollBar.qml
    SfyTextArea.qml
    SfyTextInput.qml
    SubMenu.qml
    Switch.qml
    TableContentItem.qml
    TableHeaderItem.qml
    Tabs.qml
    TaskBarAction.qml
    ThresholdWidget.qml
    TextSpinBox.qml
    TrText.qml
    Popup.qml
    CustomDropdown.qml
    ComboBox.qml
    ListContent.qml
    ListScroller.qml
    PressedIcon.qml
    Clock.qml
    SignalLevel.qml
    FunctionStatus.qml
    DebugRectangle.qml
    ValueDisplay.qml
    ActionButton.qml
    Calendar.qml
    ElevationWidget.qml
    TiltingHeader.qml
    BasicInput.qml
    DateTimePicker.qml
    LinearDatePicker.qml
    LinearTimePicker.qml
    LinearDateTimePicker.qml
    StandardText.qml
    PickerElement.qml
    IconDataPresentation.qml
    MultiColorFontIcon.qml
    ListTaskBar.qml
    BasicPositionWidget.qml
    AdvancedPositionWidget.qml
    AdvancedAngleWidget.qml
    Wink.qml
    Magnifier.qml
    TitledRectangle.qml
    IconWatermark.qml
    ListCount.qml
    Scheduler.qml
    DateScheduler.qml
    TimeScheduler.qml
    TimeRangeScheduler.qml
    CurrentDateTime.qml
    DeviceStatusItem.qml
    Searchable.qml
    Gauge.qml
    WrappedTableContentItem.qml
    HoverMessage.qml
    ${GUILIB_QML_JS}
)

# Shortcut for ALL QML files
set(GUILIB_QML
  ${GUILIB_QML_SINGLETON}
  ${GUILIB_QML_PRIV}
  ${GUILIB_QML_PUB}
)

# Data shipped in qrc and to be installed with qml
set(GUILIB_DATA
    icons/SomfyWhiteLogo.png
    icons/up_arrow.png
    icons/down_arrow.png
    )

set(GUILIB_FONTS
    fonts/fontawesome-webfont.ttf
    fonts/fa-brands-400.ttf
    fonts/fa-solid-900.ttf
    fonts/fa-regular-400.ttf
    fonts/Material-Design-Iconic-Font.ttf
    fonts/NotoSansDisplay-Regular.ttf
    "fonts/Parachute - PFDinTextPro-Regular.otf"
    "fonts/Parachute - PFDinTextPro-Bold.otf"
    fonts/SfyIco.ttf
    fonts/SomfySans-Bold.ttf
    fonts/SomfySans-Italic.ttf
    fonts/SomfySans-Regular.ttf
    fonts/fa-brands-400.otf
    fonts/fa-solid-900.otf
    fonts/fa-regular-400.otf
    )

set(GUILIB_KOREANFONT
    fonts/NanumGothic.ttf
    )

set(GUILIB_QRC_FILES
    ${GUILIB_QML}
    ${GUILIB_DATA}
    ${GUILIB_FONTS}
    ${GUILIB_KOREANFONT}
    )

# Extra file just needed for display in Project TreeView (IDE)
set(GUILIB_QML_EXTRA
    qmldir.in
    GuiLib.qrc.in
    )

# Use a custom tools to be sure those files will be shown within the ProjectView (IDE)
add_info_files(${GUILIB_QML} ${GUILIB_DATA} ${GUILIB_FONTS} ${GUILIB_KOREANFONT} ${GUILIB_QML_EXTRA})

#####################
### GUILIB qrc
#####################
# define the qrc files as ressource
set(GUILIB_QRC_RESOURCES "")
foreach(QRC_RESOURCES ${GUILIB_QML})
    set(GUILIB_QRC_RESOURCES "${GUILIB_QRC_RESOURCES}\n    <file>${QRC_RESOURCES}</file>")
endforeach(QRC_RESOURCES)
# build up the qrc files
configure_file("GuiLib.qrc.in" "${CMAKE_CURRENT_SOURCE_DIR}/GuiLibGui.qrc" @ONLY)

foreach(QRC_RESOURCES ${GUILIB_DATA})
    set(GUILIB_QRC_RESOURCES "${GUILIB_QRC_RESOURCES}\n    <file>${QRC_RESOURCES}</file>")
endforeach(QRC_RESOURCES)
# build up the qrc files
configure_file("GuiLib.qrc.in" "${CMAKE_CURRENT_SOURCE_DIR}/GuiLibData.qrc" @ONLY)

set(GUILIB_QRC_RESOURCES "")
foreach(QRC_RESOURCES ${GUILIB_FONTS})
    set(GUILIB_QRC_RESOURCES "${GUILIB_QRC_RESOURCES}\n    <file>${QRC_RESOURCES}</file>")
endforeach(QRC_RESOURCES)
# build up the qrc files
configure_file("GuiLib.qrc.in" "${CMAKE_CURRENT_SOURCE_DIR}/GuiLibFonts.qrc" @ONLY)

set(GUILIB_QRC_RESOURCES "")
foreach(QRC_RESOURCES ${GUILIB_KOREANFONT})
    set(GUILIB_QRC_RESOURCES "${GUILIB_QRC_RESOURCES}\n    <file>${QRC_RESOURCES}</file>")
endforeach(QRC_RESOURCES)
# build up the qrc files
configure_file("GuiLib.qrc.in" "${CMAKE_CURRENT_SOURCE_DIR}/GuiLibKoreanFont.qrc" @ONLY)

qt6_add_resources(GUILIB_QRC GuiLibData.qrc GuiLibGui.qrc GuiLibFonts.qrc GuiLibKoreanFont.qrc)

# define the library GuiLib with all sources, QML and ressources
add_library(GuiLib SHARED ${GUILIB_SRC} ${GUILIB_HEADERS} ${GUILIB_QML} ${GUILIB_QRC})
# Link our Lib with required Qt libraries
# qt6_use_modules(GuiLib Gui Quick)
target_link_libraries(GuiLib Qt${QT_VERSION_MAJOR}::Gui Qt${QT_VERSION_MAJOR}::Quick)

# define Public Headers for the GuiLib Library
set_target_properties(GuiLib PROPERTIES
        PUBLIC_HEADER "${GUILIB_HEADERS}"
        COMPILE_DEFINITIONS GUILIB_INTERNAL)


#####################
### GUILIB qmldir
#####################

# prepare required variables for the qmldir.in configuration
## Singleton
foreach(QMLFILE ${GUILIB_QML_SINGLETON})
    get_filename_component(QMLCLASS "${QMLFILE}" NAME_WE)
    set(GUILIB_SINGLETON_QML "${GUILIB_SINGLETON_QML}\nsingleton ${QMLCLASS} 1.0 ${QMLFILE}")
endforeach(QMLFILE)
## Public
foreach(QMLFILE ${GUILIB_QML_PUB})
    get_filename_component(QMLCLASS "${QMLFILE}" NAME_WE)
    set(GUILIB_PUBLIC_QML "${GUILIB_PUBLIC_QML}\n${QMLCLASS} 1.0 ${QMLFILE}")
endforeach(QMLFILE)
## Internal
foreach(QMLFILE ${GUILIB_QML_PRIV})
    get_filename_component(QMLCLASS "${QMLFILE}" NAME_WE)
    if(TESTS)
        set(GUILIB_INTERNAL_QML "${GUILIB_INTERNAL_QML}\n${QMLCLASS} 1.0 ${QMLFILE}")
    else(TESTS)
        set(GUILIB_INTERNAL_QML "${GUILIB_INTERNAL_QML}\ninternal ${QMLCLASS} ${QMLFILE}")
    endif(TESTS)
endforeach(QMLFILE)

# build up the qmldir file (description of all Qml files provided by a plugin)
configure_file("qmldir.in" "${CMAKE_CURRENT_SOURCE_DIR}/qmldir" @ONLY)

#####################
### GUILIB Plugin
#####################

add_definitions(-DGUILIB_INTERNAL)

# define GuiLibPlugin sources
set(PLUGIN_SRC GuiLibQmlPlugin.hpp GuiLibQmlPlugin.cpp
    TranslationManagement.hpp TranslationManagement.cpp
    GuiLibFontLoader.hpp GuiLibFontLoader.cpp
    Singleton.hxx Singleton.hpp Singleton.cpp)
# define the plugin as a module
add_library(guilibplugin MODULE ${PLUGIN_SRC})
# link the plugin to the GuiLib Library
target_link_libraries(guilibplugin GuiLib)
# define Qt libraries dependencies
target_link_libraries(guilibplugin Qt6::Quick Qt6::QuickControls2)
# Hack for Win32 relative to plugin prefix (no prefix for plugin on windows)
if(WIN32)
    set_target_properties(guilibplugin PROPERTIES PREFIX "")
endif(WIN32)

######################
### GuiLib Install
######################

# Install GuiLib Library
install(TARGETS GuiLib
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT Devel
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT Runtime
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR} COMPONENT Runtime
        PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME} COMPONENT Devel)
# Install GuiLib Plugin
install(TARGETS guilibplugin
        LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}/qml/GuiLib" COMPONENT Runtime
        RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}/qml/GuiLib" COMPONENT Runtime)
# Install GuiLib QML Files
install(FILES ${GUILIB_QML} qmldir
        DESTINATION "${CMAKE_INSTALL_LIBDIR}/qml/GuiLib" COMPONENT Devel)
# Install GuiLib fonts and icons
install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/fonts"
                  "${CMAKE_CURRENT_SOURCE_DIR}/icons"
        DESTINATION "${CMAKE_INSTALL_LIBDIR}/qml/GuiLib" COMPONENT Devel)

add_files(QmlPluginFiles
    FILES ${GUILIB_QML} ${GUILIB_DATA} qmldir
    DESTINATION "${CMAKE_CURRENT_BINARY_DIR}")
