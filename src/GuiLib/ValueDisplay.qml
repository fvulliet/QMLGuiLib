import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property real size
    property string ctrlFont: Fonts.sfyFont
    property color bkgdColor: Colors.skinFrameFGD
    property color fgdColor: Colors.themeMainColor
    property alias border: rect.border
    property real value
    property alias unit: unitText.text
    property bool displayValueAsBool: false
    property bool valid: true
    property real minValue
    property real maxValue

    property bool _outOfRange: {
        if (minValue === maxValue)
            // both minValue and maxValue must be set in order to evaluate range
            return false

        return value > maxValue || value < minValue;
    }

    // Item's properties
    height: size; width: height

    // inner components
    Rectangle {
        id: rect

        anchors.fill: parent
        color: bkgdColor
        radius: width/2
        border {
            width: 3; color: fgdColor
        }

        Column {
            width: 2 * Math.sqrt(Math.pow((parent.radius-rect.border.width),2)/2)
            height: width
            anchors.centerIn: parent

            Item {
                width: parent.width
                height: displayValueAsBool || !valid || _outOfRange ? parent.height : parent.height * 2/3
                anchors.horizontalCenter: parent.horizontalCenter

                StandardText {
                    id: valueText

                    font {
                        family: ctrlFont
                        pixelSize: height
                        bold: true
                    }
                    color: Colors.themeMainColor
                    text: valid ? _outOfRange ? qsTr("out of\nrange") : (displayValueAsBool ? (value > 0 ? "True" : "False") : value) : "?"
                }
            }
            Item {
                width: parent.width
                height: displayValueAsBool || !valid || _outOfRange ? 0 : parent.height / 3
                anchors.horizontalCenter: parent.horizontalCenter
                visible: height > 0

                StandardText {
                    id: unitText

                    font {
                        family: ctrlFont
                        pixelSize: height
                    }
                    color: Colors.themeMainColor
                }
            }
        }
    }
}



