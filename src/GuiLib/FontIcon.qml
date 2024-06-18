import QtQuick 2.9
import GuiLib 1.0

Item {
    // public properties
    property alias icon: icon.text
    property alias scale: icon.scale
    property alias color: icon.color
    property alias size: icon.font.pixelSize
    property alias lib: icon.font.family
    property alias weight: icon.font.weight
    property alias bold: icon.font.bold
    property alias transformOrigin: icon.transformOrigin
    property alias styleName: icon.font.styleName

    // Item's properties
    width: icon.contentWidth; height: icon.contentHeight

    // inner components
    Text {
        id: icon
        antialiasing: true
        font.styleName: "Solid"
    }
}

