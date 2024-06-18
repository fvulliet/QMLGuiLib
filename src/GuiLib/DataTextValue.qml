import QtQuick 2.9
import GuiLib 1.0

Item {
    // public properties
    property bool isValid: true
    property bool animate: true
    property color textColor: Colors.skinFrameTXT
    property color selectedTextColor: "white"
    property color highlightCextColor: Colors.skinFrameTXT
    property alias textValue: value.text
    property alias pixelSize: value.font.pixelSize
    property bool centered: true

    // Item's properties
    height: 20

    // inner components
    TextEdit {
        id: value

        font {
            family: Fonts.sfyFont;  pixelSize: 15
        }
        color: isValid ? textColor :
                         Colors.fade(textColor, Colors.skinFrameFGD)
        anchors.centerIn: centered ? parent : undefined
        selectByMouse: true
        readOnly: true
        selectedTextColor : selectedTextColor
        selectionColor : highlightCextColor

        onTextChanged: {
            if (animate)
                textAnim.restart()
        }

        PropertyAnimation on opacity {
            id: textAnim
            from: 0; to: 1; easing.type: Easing.InOutQuad
        }
    }
}
