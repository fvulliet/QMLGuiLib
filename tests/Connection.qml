import QtQuick 2.2
import GuiLib 1.0
import "."

Rectangle {
    id: root
    property bool connected: false
    property bool active: false

    property int iconPos
    property int textPos
    property real iconScale: 1
    property real textOpacity: 1
    height: 50

    signal connectionClicked()

    Item {
        width: parent.width; height: parent.height / 2
        anchors.centerIn: parent

        FontIcon {
            id: logIcon
            lib: Fonts.fontAwesome
            icon: FontAwesome.Icon.Link
            color: connected ? "green" : "red"
            size: root.height / 2
            scale: root.iconScale
            x: root.iconPos - width / 2
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: logText
            opacity: root.textOpacity
            visible: opacity > 0.0
            text: connected ? "connected" : "not connected"
            color: Colors.skinMenuTXT
            font {
                family: Fonts.sfyFont; pointSize: 10
            }
            scale: root.iconScale
            x: root.textPos
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            connectionClicked()
        }
    }
}
