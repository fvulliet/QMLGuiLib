import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property string icon
    property string lib
    property real scale: 1
    property color colorH
    property color colorL
    property real size
    property real ratioHL: 0.5

    // Item's properties
    width: iconH.contentWidth; height: size

    // inner components
    Column {
        width: iconCtnrH.contentWidth; height: parent.height

        Item {
            id: iconCtnrH

            width: iconH.contentWidth; height: parent.height * ratioHL
            clip: true

            Text {
                id: iconH

                anchors.top: parent.top
                antialiasing: true
                text: icon
                scale: root.scale
                color: colorH
                font {
                    pixelSize: size
                    family: lib
                }
            }
        }
        Item {
            id: iconCtnrL

            width: iconL.contentWidth; height: parent.height * (1-ratioHL)
            clip: true

            Text {
                id: iconL

                anchors.bottom: parent.bottom
                antialiasing: true
                text: icon
                scale: root.scale
                color: colorL
                font {
                    pixelSize: size
                    family: lib
                }
            }
        }
    }
}

