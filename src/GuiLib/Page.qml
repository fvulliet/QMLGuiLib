import QtQuick 2.9
import GuiLib 1.0

Rectangle {
    default property alias data: content.data

    // Rectangle's properties
    color: Colors.skinFrameBGD
    clip: true

    // inner components
    Item {
        id: content
        anchors.fill: parent
    }
}

