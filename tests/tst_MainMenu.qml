
import QtQuick 2.2
import QtTest 1.0
import QtQuick.Controls 1.1 as Controls
import GuiLib 1.0
import "."

Rectangle {
    id: root
    width: 1280
    height: 720
    color: "#d0d1cd"

    property bool animationEnded: true

    Modal {
        id: versionModal
        width: 325
        z: 1
        color: "#404040"
        textColor: "#d0d1cd"
        visible: false
        withActions: false
        title: "SDN Configuration Tool"
        coreText: "version 1.0.0\nCopyright (C) 2015 <toto@somfy.com>"

        anchors.centerIn: parent

        onAccepted: {
            visible = false
        }
    }

    AvailablePorts {
        id: comPortsList
        targetWidth: 325; targetHeight: 250
        z: Math.max(mainMenu.z, mainView.z) + 1
        currentIndex: 0

        model: ListModel {
            Component.onCompleted: {
                append({ "name": "USB0" });
                append({ "name": "USB1" });
                append({ "name": "USB2" });
            }
        }

        x: mainMenu.width + 10
        y: mainMenu.customMiddleY - comPortsList.height

        onPortSelected: {
        }
    }

    MainMenu {
        id: mainMenu
        z: subMenu.z + 1
        width: parent.width / 5
        canBeMinimized: true
        currentIndex: 0
        animationSpeed: 400
        customItem: Connection {
            id: connection
            anchors.fill: parent;
            color: parent.color;

            connected: comPortsList.index === 0
            iconPos: mainMenu.menuListView.iconPos
            iconScale: mainMenu.menuListView.iconScale
            textOpacity: mainMenu.menuListView.textOpacity
            textPos: width / 3

            onConnectionClicked: {
                comPortsList.displayed = comPortsList.displayed ? false : true
            }
        }

        onVersionClicked: {
            versionModal.visible = true
        }

        model: ListModel {
            id: mainmenumodel
            Component.onCompleted: {
                append({ "name": "DEVICES", lib: Fonts.fontAwesome, "img": FontAwesome.Icon.List, "src": "DevicesView.qml" });
                append({ "name": "SEARCH", lib: Fonts.fontAwesome, "img": FontAwesome.Icon.Search, "src": "DevicesView.qml" });
                append({ "name": "CONTROL", lib: Fonts.fontAwesome, "img": FontAwesome.Icon.Sliders, "src": "DevicesView.qml" });
                append({ "name": "ACTIONS", lib: Fonts.fontAwesome, "img": FontAwesome.Icon.Magic, "src": "DevicesView.qml" });
                append({ "name": "SETTINGS", lib: Fonts.fontAwesome, "img": FontAwesome.Icon.Cog, "src": "DevicesView.qml", subMenu: [
                               {"name": "Language", lib: Fonts.fontAwesome, "img": FontAwesome.Icon.Language, "src": "DevicesView.qml"},
                               {"name": "Units", lib: Fonts.fontAwesome, "img": FontAwesome.Icon.Dashboard, "src": "DevicesView.qml"},
                               {"name": "Connections", lib: Fonts.fontAwesome, "img": FontAwesome.Icon.Link, "src": "DevicesView.qml"}
                           ] });
            }
        }

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
    }

    SubMenu {
        id: subMenu
        mainMenu: mainMenu

        height: count * 85
    }

    MainPage {
        id: mainView
        anchors {
            left: mainMenu.right
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
        Connections {
            target: mainMenu
            onCurrentIndexChanged: {
                if ((mainMenu.currentIndex >= 0) && mainMenu.model.get(mainMenu.currentIndex).src)
                    mainView.pageSource = mainMenu.model.get(mainMenu.currentIndex).src
            }
        }
        Connections {
            target: subMenu
            onCurrentIndexChanged: {
                if ((subMenu.currentIndex >= 0) && subMenu.model.get(subMenu.currentIndex).src)
                {
                    mainView.pageSource = subMenu.model.get(subMenu.currentIndex).src
                }
            }
        }
    }

    TestCase {
        name: "-----CheckMinimized-----"
        when: (mainMenu.state === "MINIMIZED") && root.animationEnded

        function test_minimized() {
            tryCompare(mainMenu, "width", Math.floor(root.width/30), 1000, "menu should be minimized")
        }
    }

    TestCase {
        name: "-----CheckMaximized-----"
        when: (mainMenu.state !== "MINIMIZED") && root.animationEnded

        function test_maximized() {
            tryCompare(mainMenu, "width", root.width/5, 1000, "menu should be maximized")
        }
    }

    Timer {
        id: timer
        interval: 500
        repeat: false
        running: false
        onTriggered: { root.animationEnded = true }
    }
}
