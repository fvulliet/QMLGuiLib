
import QtQuick 2.2
import QtTest 1.0
import GuiLib 1.0
import "."

Rectangle {
    id: root
    width: 1280
    height: 720
    color: "#d0d1cd"

    property bool animationEnded: true

    MainMenu {
        id: mainMenu
        z: mySubMenu.z + 1
        width: parent.width / 5
        currentIndex: 0
        animationSpeed: 400

        model: ListModel {
            id: mainmenumodel
            Component.onCompleted: {
                append({ name: "MENU1", lib: Fonts.fontAwesome, img: FontAwesome.Icon.Cog, src: Qt.resolvedUrl("menu1.qml") });
                append({ name: "MENU2", lib: Fonts.fontAwesome, img: FontAwesome.Icon.Cog, src: Qt.resolvedUrl("menu1.qml"), subMenu: [
                               { name: "Sub1", lib: Fonts.fontAwesome, img: FontAwesome.Icon.Dashboard, src: Qt.resolvedUrl("menu2.qml") },
                               { name: "Sub2", lib: Fonts.fontAwesome, img: FontAwesome.Icon.Dashboard, src: Qt.resolvedUrl("menu2.qml") },
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
        id: mySubMenu
        mainMenu: mainMenu
        width: contentWidth
        height: count * 85
        z: 1
    }

    MainPage {
        id: mainView
        anchors {
            left: mainMenu.right
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }

        property string shrinkedSource

        Component.onCompleted: {
            mainView.pageSource = Qt.resolvedUrl("menu1.qml")
        }

        Connections {
            target: mainMenu
            onCurrentIndexChanged: {
                if ((mainMenu.currentIndex >= 0) && mainMenu.model.get(mainMenu.currentIndex).src)
                    mainView.pageSource = mainMenu.model.get(mainMenu.currentIndex).src
            }
        }

        Connections {
            target: mySubMenu
            onCurrentIndexChanged: {
                if ((mySubMenu.currentIndex >= 0) && mySubMenu.model.get(mySubMenu.currentIndex).src)
                    mainView.pageSource = mySubMenu.model.get(mySubMenu.currentIndex).src
            }
        }

        /*Connections {
            target: mySubmenu
            onSubmenuClicked: {
                if ((idx >= 0) && mySubmenu.model.get(idx).src) {
                    mainView.pageSource = mySubmenu.model.get(idx).src
                }
            }
        }*/
    }

//    TestCase {
//        name: "-----SubMenuTests-----"
//        when: windowShown && true

//        function getFileName(str) {
//            return str.substr(str.length-9, 9)
//        }

//        function test_simple() {
//            verify(getFileName(mainView.pageSource) === "menu1.qml")
//            console.log(getFileName(mainView.pageSource))
//            mouseClick(mainMenu, 20, 200)
//            tryCompare(mainView, "shrinkedSource", "menu1.qml", 2000, "main view should not change")
//        }
//    }
}
