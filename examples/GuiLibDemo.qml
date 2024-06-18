import QtQuick
import GuiLib 1.0 as Gui

Gui.AppWindow {
    id: root

    property string _trContext: "GuiLibDemo"
    property real _mainPageRatio: 0.9
    property int _mainPageAngle: 15
    property real _xMargin: width/25
    property real _yMargin: height/20

    width: 1280; height: 800

    currentTheme: "standard"
    currentSkin: "bright"

    Settings {
        id: globalSettings
    }

    Component.onCompleted: {
        Gui.Colors.setThemeName(currentTheme)
        Gui.Colors.setSkinName(currentSkin)
        // Gui.TranslationManagement.loadQMfile(Gui.TranslationManagement.LNG_ENGLISH, ":/GuiLibDemo_enEN.qm")
    }

    Connections {
        target: mainPage.currentItem
        ignoreUnknownSignals: true
        function onShowPopupMessage(btns, type, msg) {
            popup.buttons = btns
            popup.msg = msg
            popup.displayed = true
            popup.typeLib = Gui.Fonts.faSolid

            switch (type) {
            case 0:
                popup.typeIcon = Gui.FontAwesomeSolid.Icon.InfoSign
                popup.typeColor = Gui.Colors.themeMainColor
                break
            case 1:
                popup.typeIcon = Gui.FontAwesomeSolid.Icon.WarningSign
                popup.typeColor = Gui.Colors.themeMainColor
                break
            case 2:
                popup.typeIcon = Gui.FontAwesomeSolid.Icon.ExclamationSign
                popup.typeColor = Gui.Colors.themeStatusKo
                break
            }
        }
    }

    Item {
        anchors.fill: parent

        Gui.MainMenu {
            id: mainMenu

            appTitle: "GUIlib Demo"
            z: mySubMenu.z + 1
            isVertical: true
            height: parent.height; width: parent.width / 8
            minimizedSize: parent.width / 30

    //        isVertical: false
    //        width: parent.width; height: parent.height/5

            canBeMinimized: true; animationSpeed: 400

            customItem: Item {
                id: themes
                width: mainMenu.isVertical ? mainMenu.width : mainMenu.width/4
                height: mainMenu.isVertical ? mainMenu.height/4 : mainMenu.height

                ListView {
                    id: themesList

                    property int _itemHeight

                    width: parent.width; height: parent.height * 0.8
                    interactive: false
                    _itemHeight: (count !== 0) ? (height / count) : 0

                    onCurrentIndexChanged: {
                        currentTheme = model.get(currentIndex).name
                        Gui.Colors.setThemeName(currentTheme)
                    }

                    delegate: Item {
                        width: ListView.view.width; height: ListView.view._itemHeight

                        Rectangle {
                            id: colorCircle
                            height: parent.height / 2; width: height
                            radius: height / 2
                            color: col
                            anchors {
                                left: parent.left; leftMargin: parent.width / 4
                                verticalCenter: parent.verticalCenter
                            }
                        }
                        Gui.TrText {
                            anchors {
                                left: parent.horizontalCenter
                                verticalCenter: parent.verticalCenter
                            }
                            content: name; context: trContext
                            opacity: mainMenu.menuListView.textOpacity
                            font { family: Gui.Fonts.sfyFont
                                pixelSize: Gui.Utils.limitMax(parent.height,12)
                                capitalization: Font.AllUppercase
                            }
                            color: Gui.Colors.skinMenuTXT
                        }
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: parent.ListView.view.currentIndex = index
                        }
                    }
                    currentIndex: 0
                    boundsBehavior : Flickable.StopAtBounds
                    highlightFollowsCurrentItem: false
                    model: ListModel {
                        Component.onCompleted: {
                            append({ name: QT_TR_NOOP("standard"), trContext: _trContext, col: "#fab800" })
                            append({ name: QT_TR_NOOP("std2020"), trContext: _trContext, col: "#fab800" })
                            append({ name: QT_TR_NOOP("somfy"), trContext: _trContext, col: "#e35200" })
                            append({ name: QT_TR_NOOP("office"), trContext: _trContext, col: "#047caa" })
                            append({ name: QT_TR_NOOP("education"), trContext: _trContext, col: "#ea7c1d" })
                            append({ name: QT_TR_NOOP("hospitality"), trContext: _trContext, col: "#44a9b9" })
                            append({ name: QT_TR_NOOP("healthcare"), trContext: _trContext, col: "#9bcc58" })
                        }
                    }
                }

                Item {
                    id: skin
                    width: parent.width; height: parent.height * 0.2
                    anchors.bottom: parent.bottom

                    Gui.TrText {
                        anchors.left: parent.left; anchors.leftMargin: Gui.Style.stdMargin
                        anchors.verticalCenter: parent.verticalCenter
                        font { family: Gui.Fonts.sfyFont
                            pixelSize: Gui.Utils.limitMax(parent.height,12)
                            capitalization: Font.AllUppercase
                        }
                        color: Gui.Colors.skinMenuTXT
                        opacity: mainMenu.menuListView.textOpacity
                        content: QT_TR_NOOP("bright"); context: _trContext
                    }
                    Gui.Switch {
                        height: parent.height/2
                        checked: 0
                        anchors.centerIn: parent
                        onClicked: {
                            if (checked <= 0)
                                checked = 1
                            else
                                checked = 0

                            currentSkin = (currentSkin === "dark") ? "bright" : "dark"
                            Gui.Colors.setSkinName(currentSkin)
                        }
                    }
                    Gui.TrText {
                        anchors.right: parent.right; anchors.rightMargin: Gui.Style.stdMargin
                        anchors.verticalCenter: parent.verticalCenter
                        font { family: Gui.Fonts.sfyFont;
                            pixelSize: Gui.Utils.limitMax(parent.height,14)
                            capitalization: Font.AllUppercase }
                        color: Gui.Colors.skinMenuTXT
                        opacity: mainMenu.menuListView.textOpacity
                        content: QT_TR_NOOP("dark"); context: _trContext
                    }
                }
            }

            function displayContent() {
                if ((currentIndex >=0 ) && model.get(currentIndex).src)
                    myHistory.displayPage(model.get(currentIndex).src,
                                          { iconLib: model.get(currentIndex).lib, iconIcon: model.get(currentIndex).img },
                                          model.get(currentIndex).name)
            }

            Component.onCompleted: {
                currentIndex = 0
                displayContent()
            }

            onItemClicked: displayContent()

            Connections {
                target: mySubMenu
                function onDisplayedChanged() {
                    if (mySubMenu.displayed)
                        mainMenu.elevated = 1
                    else
                        mainMenu.elevated = 0
                }
            }

            model: ListModel {
                Component.onCompleted: {
                    append({ name: QT_TR_NOOP("CONTROLS"), trContext: "GuiLibDemo",
                               lib: Gui.Fonts.sfyIco,
                               img: Gui.SfyIco.Icon.BdgControl,
                               src: Qt.resolvedUrl("ControlsPage.qml") });
                    append({ name: QT_TR_NOOP("ICONS"), trContext: "GuiLibDemo",
                               lib: Gui.Fonts.faSolid,
                               img: Gui.FontAwesomeSolid.Icon.SurroundedPen, subMenuModel: [
                                   {name: QT_TR_NOOP("ALL"), trContext: "GuiLibDemo",
                                       lib: Gui.Fonts.faSolid,
                                       img: Gui.FontAwesomeSolid.Icon.Storage,
                                       src: Qt.resolvedUrl("IconsView.qml")},
                                   {name: QT_TR_NOOP("TOUCHBUCO"), trContext: "GuiLibDemo",
                                       lib: Gui.Fonts.faSolid,
                                       img: Gui.FontAwesomeSolid.Icon.Tablet,
                                       src: Qt.resolvedUrl("TBIconsNew.qml")},
                                   {name: QT_TR_NOOP("COMMON"), trContext: "GuiLibDemo",
                                       lib: Gui.Fonts.faSolid,
                                       img: Gui.FontAwesomeSolid.Icon.Joomla,
                                       src: Qt.resolvedUrl("CommonIconsView.qml")}
                               ] });
                    append({ name: QT_TR_NOOP("CONCEPTS"), trContext: "GuiLibDemo",
                               lib: Gui.Fonts.faSolid,
                               img: Gui.FontAwesomeSolid.Icon.LightBulb, subMenuModel: [
                                   {name: QT_TR_NOOP("Extended menus"), trContext: "GuiLibDemo",
                                       lib: Gui.Fonts.faSolid,
                                       img: Gui.FontAwesomeSolid.Icon.Umbrella,
                                       src: Qt.resolvedUrl("ExtendedMenuView.qml")},
                                   {name: QT_TR_NOOP("Carousel"), trContext: "GuiLibDemo",
                                       lib: Gui.Fonts.faSolid,
                                       img: "\uf121",
                                       src: Qt.resolvedUrl("CarouselView.qml")},
                                   {name: QT_TR_NOOP("ScopeList"), trContext: "GuiLibDemo",
                                       lib: Gui.Fonts.faSolid,
                                       img: Gui.FontAwesomeSolid.Icon.ThList,
                                       src: Qt.resolvedUrl("ScopeListView.qml")},
                                   {name: QT_TR_NOOP("Tabs"), trContext: "GuiLibDemo",
                                       lib: Gui.Fonts.faSolid,
                                       img: Gui.FontAwesomeSolid.Icon.Underline,
                                       src: Qt.resolvedUrl("TabsView.qml")},
                                   {name: QT_TR_NOOP("Big Grid Menu"), trContext: "GuiLibDemo",
                                       lib: Gui.Fonts.faSolid,
                                       img: "\uf00a",
                                       src: Qt.resolvedUrl("GridMenuView2.qml")},
                                   {name: QT_TR_NOOP("Lists"), trContext: "GuiLibDemo",
                                       lib: Gui.Fonts.faSolid,
                                       img: Gui.FontAwesomeSolid.Icon.ListAlt,
                                       src: Qt.resolvedUrl("DisplayListViewMenu.qml")},
                                   {name: QT_TR_NOOP("Navigation"), trContext: "GuiLibDemo",
                                       lib: Gui.Fonts.faSolid,
                                       img: Gui.FontAwesomeSolid.Icon.Compass,
                                       src: Qt.resolvedUrl("NavigationView.qml")},
                                   {name: QT_TR_NOOP("Layout"), trContext: "GuiLibDemo",
                                       lib: Gui.Fonts.faSolid,
                                       img: Gui.FontAwesomeSolid.Icon.ThLarge,
                                       src: Qt.resolvedUrl("DisplayLayoutMenu.qml")}
                               ] });
                    append({ name: QT_TR_NOOP("CHARTS"), trContext: "GuiLibDemo",
                               lib: Gui.Fonts.faSolid,
                               img: Gui.FontAwesomeSolid.Icon.BarChart,
                               src: Qt.resolvedUrl("ChartsView.qml") });
                    append({ name: QT_TR_NOOP("TRANSLATION"), trContext: "GuiLibDemo",
                               lib: Gui.Fonts.faSolid,
                               img: Gui.FontAwesomeSolid.Icon.Language,
                               src: Qt.resolvedUrl("TranslationView.qml") });
                    append({ name: QT_TR_NOOP("SETTINGS"), trContext: "GuiLibDemo",
                               lib: Gui.Fonts.faSolid,
                               img: Gui.FontAwesomeSolid.Icon.Cogs, subMenuModel: [
                                   {name: QT_TR_NOOP("Language"), trContext: "GuiLibDemo",
                                       lib: Gui.Fonts.sfyIco,
                                       img: Gui.SfyIco.Icon.Earth,
                                       src: Qt.resolvedUrl("LanguageView.qml")},
                                   {name: QT_TR_NOOP("Theme"), trContext: "GuiLibDemo",
                                       lib: Gui.Fonts.faSolid,
                                       img: Gui.FontAwesomeSolid.Icon.Tint,
                                       src: Qt.resolvedUrl("ThemeView.qml")}
                               ] });
                    append({ name: QT_TR_NOOP("LAB"), trContext: "GuiLibDemo",
                               lib: Gui.Fonts.faSolid,
                               img: Gui.FontAwesomeSolid.Icon.Beaker,
                               src: Qt.resolvedUrl("LabPage.qml") });
                }
            }
        }

        Gui.SubMenu {
            id: mySubMenu

            width: {
                if (!mainMenu.isVertical)
                    return count * root.width/10
            }
            height: {
                if (mainMenu.isVertical)
                    return count * root.height/10
            }
            mainMenu: mainMenu

            onSubmenuClicked: {
                if ((idx >= 0) && mySubMenu.model.get(idx).src) {
                    myHistory.displayPage(mySubMenu.model.get(idx).src,
                                          { iconLib: mySubMenu.model.get(idx).lib, iconIcon: mySubMenu.model.get(idx).img},
                                          mySubMenu.model.get(idx).name)
                }
            }
        }

        Gui.NavHistory {
            id: myHistory

            height: _yMargin; width: parent.width / 3
            anchors {
                left: mainMenu.isVertical ? mainMenu.right : parent.left
                leftMargin: _xMargin
            }
            visible: !mainPage.animating && !mySubMenu.displayed

            onPageChanged: mainPage.source = page
        }

        Gui.MainPage {
            id: mainPage

            anchors {
                top: mainMenu.isVertical ? parent.top : mainMenu.bottom
                bottom: parent.bottom
                left: mainMenu.isVertical ? mainMenu.right : parent.left
                right: parent.right
                topMargin: _yMargin; bottomMargin: _yMargin
                leftMargin: _xMargin; rightMargin: _xMargin
            }
            subMenu: mySubMenu
            shiftRatio: _mainPageRatio
            shiftAngle: _mainPageAngle
        }
    }

    Gui.Popup {
        id: popup

        anchors.fill: parent
        ratio: 0.618
        borderRadius: 3
        buttonHeight: 40
        onBtn1Clicked: displayed = false
        onBtn2Clicked: displayed = false
    }
}
