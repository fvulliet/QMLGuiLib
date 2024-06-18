
import QtQuick 2.9
import GuiLib 1.0

Rectangle {
    id: root

    color: Colors.skinFrameFGD

    Item {
        id: iconCtnr

        width: parent.width
        height: parent.height / 2
        anchors.top: parent.top

        FontIcon {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height / 8
            anchors.horizontalCenter: parent.horizontalCenter
            lib: Fonts.sfyIco; icon: SfyIco.Icon.Buildings
            color: Colors.skinFrameTXT
            size: parent.height / 2
        }
    }
    Item {
        id: txtCtnr

        width: parent.width
        height: parent.height / 2
        anchors.bottom: parent.bottom

        Text {
            anchors.top: parent.top
            anchors.topMargin: parent.height / 8
            anchors.horizontalCenter: parent.horizontalCenter
            font {
                family: Fonts.sfyFont
                pixelSize: parent.height / 8
            }
            color: Colors.skinFrameTXT
            text: "BUILDING CONTROL"
        }
    }
}
