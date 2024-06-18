import QtQuick 2.9
import GuiLib 1.0


Rectangle {
    id: root

    property alias title: headTitle.content
    property alias trContext: headTitle.context
    property string _trContext: "DemoHeader"

    color: Colors.themeMainColor

    Item {
        id: theme
        width: parent.width / 4; height: parent.height
        anchors.left: parent.left
        TrText {
            anchors.top: parent.top; anchors.topMargin: Style.stdMargin
            anchors.horizontalCenter: parent.horizontalCenter
            color: Colors.skinButtonTXT
            font { family: Fonts.sfyFont; pixelSize: parent.height / 5 }
            content: "Current theme:"; context: _trContext
        }
        TrText {
            anchors.bottom: parent.bottom; anchors.bottomMargin: Style.stdMargin
            anchors.horizontalCenter: parent.horizontalCenter
            color: Colors.skinButtonTXT
            font { family: Fonts.sfyFont; pixelSize: parent.height / 3;
                capitalization: Font.AllUppercase }
            content: currentTheme; context: _trContext
        }
    }
    Item {
        height: parent.height
        anchors.left: theme.right; anchors.right: skin.left
        TrText {
            id: headTitle
            anchors.centerIn: parent
            color: Colors.skinButtonTXT
            font { family: Fonts.sfyFont; pixelSize: parent.height / 2 }
        }
    }
    Item {
        id: skin
        width: parent.width / 4; height: parent.height
        anchors.right: parent.right
        TrText {
            anchors.top: parent.top; anchors.topMargin: Style.stdMargin
            anchors.horizontalCenter: parent.horizontalCenter
            color: Colors.skinButtonTXT
            font { family: Fonts.sfyFont; pixelSize: parent.height / 5 }
            content: "Current skin:"; context: _trContext
        }
        TrText {
            anchors.bottom: parent.bottom; anchors.bottomMargin: Style.stdMargin
            anchors.horizontalCenter: parent.horizontalCenter
            color: Colors.skinButtonTXT
            font { family: Fonts.sfyFont; pixelSize: parent.height / 3;
                capitalization: Font.AllUppercase }
            content: currentSkin; context: _trContext
        }
    }
}
