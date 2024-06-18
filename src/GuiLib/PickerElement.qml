import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property int currentValue
    property int minValue
    property int maxValue
    property var values: []
    property bool padding: false
    property int spacing: 0
    property bool enabled: true

    // functions
    function pad2(number) {
        return (padding && (number < 10) ? '0' : '') + number
    }

    // inner components
    Column {
        anchors.fill: parent
        spacing: root.spacing

        Item {
            height: (parent.height-2*parent.spacing)/3; width: parent.width

            FontIcon {
                lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.CaretUp
                color: root.enabled ? Colors.skinFrameTXT : Colors.disabled(Colors.skinFrameTXT)
                size: parent.height
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                }
                opacity: upCaretMouseArea.pressed ? 0.2 : 1

                MouseArea {
                    id: upCaretMouseArea

                    enabled: root.enabled
                    anchors.fill: parent
                    onClicked: {
                        if (currentValue < maxValue)
                            currentValue++
                        else
                            currentValue = minValue
                    }
                }
            }
        }
        Item {
            height: (parent.height-2*parent.spacing)/3; width: parent.width

            StandardText {
                color: root.enabled ? Colors.skinFrameTXT : Colors.disabled(Colors.skinFrameTXT)
                font.pixelSize: parent.height
                text: values.length > 0 ? values[currentValue] : pad2(currentValue)
            }

            MouseArea {
                enabled: root.enabled
                anchors.fill: parent
                onWheel: {
                    currentValue += wheel.angleDelta.y / 120
                    if (currentValue > maxValue)
                        currentValue = minValue
                    if (currentValue < minValue)
                        currentValue = maxValue
                }
            }
        }
        Item {
            height: (parent.height-2*parent.spacing)/3; width: parent.width

            FontIcon {
                lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.CaretDown
                color: root.enabled ? Colors.skinFrameTXT : Colors.disabled(Colors.skinFrameTXT)
                size: parent.height
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                }
                opacity: downCaretMouseArea.pressed ? 0.2 : 1

                MouseArea {
                    id: downCaretMouseArea

                    enabled: root.enabled
                    anchors.fill: parent
                    onClicked: {
                        if (currentValue > minValue)
                            currentValue--
                        else
                            currentValue = maxValue
                    }
                }
            }
        }
    }
}
