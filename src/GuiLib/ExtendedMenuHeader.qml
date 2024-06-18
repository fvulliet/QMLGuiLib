import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property alias lib: icon.lib
    property alias icon: icon.icon
    property alias text: content.content
    property alias trContext: content.context

    // inner components
    FontIcon {
        id: icon

        anchors {
            left: parent.left; leftMargin: 2
            verticalCenter: parent.verticalCenter
        }
        size: parent.height * 0.9
        color: Colors.themeMainColor
    }

    Item {
        id: title

        height: parent.height
        anchors {
            left: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        TrText {
            id: content

            anchors.centerIn: parent
            font { family: Fonts.sfyFont
                pointSize: Utils.limitMax(parent.height/4, 12)
            }
            color: Colors.skinFrameTXT
        }
    }

    Rectangle {
        id: separator

        width: parent.width; height: 1
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
        }
        color: Colors.skinFrameTXT
    }
}
