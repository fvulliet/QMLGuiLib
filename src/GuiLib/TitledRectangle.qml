import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    property alias titleHeight: title.height
    property alias titleBkgdColor: title.color
    property alias titleText: titleText.text
    property alias srcComponent: loader.sourceComponent
    property int contentMargin: Style.stdMargin
    property int borderWidth: 1

    Rectangle {
        id: frame

        border {
            width: borderWidth; color: Colors.skinFrameTXT
        }
        color: "transparent"
        anchors {
            fill: parent; topMargin: Style.stdMargin/2
        }

        Rectangle {
            id: title

            width: childrenRect.width; height: Style.stdMargin
            anchors {
                top: parent.top; topMargin: -height/2
                horizontalCenter: parent.horizontalCenter
            }
            color: Colors.skinFrameFGD

            Text {
                id: titleText

                height: parent.height
                verticalAlignment: Text.AlignVCenter
                color: frame.border.color
                font {
                    family: Fonts.sfyFont
                    pixelSize: parent.height
                }
            }
        }

        Loader {
            id: loader

            anchors {
                fill: parent; margins: contentMargin
            }
        }
    }
}


