import QtQuick 2.9
import GuiLib 1.0

// a rectangle to visualize an element with its border

Rectangle {
    id: root

    property color borderColor: "red"
    property int borderWidth: 1

    border {
        color: borderColor
        width: borderWidth
    }
    anchors.fill: parent
    color: "transparent"
}
