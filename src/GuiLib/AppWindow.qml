import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property string currentTheme: "standard"
    property string currentSkin: "bright"
    property alias color: window.color

    // Item's properties
    width: 800; height: 600

    // inner component
    Rectangle {
        id: window

        anchors.fill: parent
        color: Colors.skinFrameBGD
    }
}
