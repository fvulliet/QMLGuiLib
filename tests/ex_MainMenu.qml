import QtQuick 2.2
import GuiLib 1.0
import "."

Rectangle {
    width: 640
    height: 480
    color: "white"

    MainMenu {
        id: mainMenu
        z: subMenu.z + 1
        width: parent.width / 5
        minimizedWidth: parent.width / 30

        canBeMinimized: true
        currentIndex: 0

        onVersionClicked: {
            versionModal.visible = true
        }

        model: ListModel {
            id: mainmenumodel
            Component.onCompleted: {
                append({ "name": "menu1", lib: Fonts.fontAwesome, "img": FontAwesome.Icon.List, "src": "DevicesView.qml" });
                append({ "name": "menu2", lib: Fonts.fontAwesome, "img": FontAwesome.Icon.Search, "src": "DevicesView.qml" });
                append({ "name": "subMenu1", lib: Fonts.fontAwesome, "img": FontAwesome.Icon.Magic, "src": "DevicesView.qml", subMenu: [
                               {"name": "imgItem", lib: Fonts.fontAwesome, "img": FontAwesome.Icon.Language, "src": "DevicesView.qml"},
                               {"name": "textOnly", "src": "DevicesView.qml"},
                           ] });
                append({ "name": "subMenu2", lib: Fonts.fontAwesome, "img": FontAwesome.Icon.Cog, "src": "DevicesView.qml", subMenu: [
                               {"name": "imgItem", lib: Fonts.fontAwesome, "img": FontAwesome.Icon.Language, "src": "DevicesView.qml"},
                               {"name": "textOnly", "src": "DevicesView.qml"},
                           ] });
            }
        }

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }

        onTransitionStarted: {
            parent.animationEnded = false
        }
        onTransitionStopped: {
            parent.animationEnded = true
        }
    }

    SubMenu {
        id: subMenu
        mainMenu: mainMenu

        height: count * 85
    }
}
