import QtQuick 2.0
import Qt5Compat.GraphicalEffects 1.0
import GuiLib 1.0

Item {
    id: root

    // public properties
    property int size
    property real minValue
    property real maxValue
    property int currentValue: -1
    property bool draggable: false
    property bool enabled: true
    property int alpha: 15
    property real sizeRatio: 1.0
    property string ctrlFont: Fonts.sfyFont
    property bool useBasicInput: false
    property alias withGlow: glow.visible
    property alias txtValue: value.text
    property alias txtUnit: unit.text
    property alias txtTitle: title.text
    property alias txtValueSize: value.font.pixelSize
    property bool preventStealingMouse: false

    // private properties
    readonly property real _toDeg: 180/Math.PI
    readonly property real _toRad: Math.PI/180
    property real _range: (maxValue - minValue) > 0 ? (maxValue - minValue) : 1
    property real _unitRad: _range / ((2*Math.PI) - (2*alpha*_toRad))
    property real _unitDeg: _range / (360-2*alpha)
    property bool _isLandscape: width >= height
    readonly property real _widgetRatio: 5/6

    // signals
    signal clicked()
    signal moved()
    signal newValue(int val)

    onCurrentValueChanged: {
        if (_unitDeg <= 0)
            return

        mark.markAngleDeg = alpha + (currentValue - minValue)/_unitDeg
    }

    // inner components
    Column {
        id: fullCtnr

        height: _isLandscape ? parent.height : Math.min(parent.width / _widgetRatio, parent.height)
        width: _isLandscape ? parent.height * _widgetRatio : parent.width
        anchors.centerIn: parent
        spacing: 0

        Item {
            width: parent.width; height: (parent.height-parent.spacing) *_widgetRatio

            Rectangle {
                id: ringCtnr

                property real stroke: Utils.bound(width/12, 4, 24)

                width: Math.min(parent.width, parent.height); height: width
                radius: width > 0 ? width/2 : 0
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                }
                border {
                    color: {
                        if (root.enabled) {
                            if (currentValue < minValue || currentValue > maxValue)
                                return Colors.themeMainColor
                            else
                                return Qt.lighter(Colors.themeMainColor, 1.33 - 0.33*((currentValue - minValue) / _range))
                        }
                        else
                            return Colors.disabled(Colors.themeMainColor)
                    }
                    width: stroke
                }
                color: "transparent"

                RectangularGlow {
                    id: glow

                    anchors.fill: parent
                    color: Colors.skinFrameTXT
                    spread: 0.0
                    opacity: ((currentValue - minValue) / _range)
                    cornerRadius: parent.radius + glowRadius
                    glowRadius: 2
                    z: -1
                    visible: false
                }

                Item {
                    width: 2 * Math.sqrt(Math.pow(parent.radius,2)/2)
                    height: width
                    anchors.centerIn: parent

                    Column {
                        anchors.fill: parent

                        Item {
                            width: parent.width; height: parent.height * 2/3

                            StandardText {
                                id: value

                                font {
                                    family: root.ctrlFont
                                    pixelSize: height
                                }
                            }
                        }
                        Item {
                            width: parent.width; height: parent.height / 3

                            StandardText {
                                id: unit

                                font {
                                    family: root.ctrlFont
                                    pixelSize: height
                                }
                            }
                        }
                    }

                    MouseArea {
                        preventStealing: preventStealingMouse
                        enabled: root.enabled
                        anchors.fill: parent
                        onClicked: {
                            if (enabled) {
                                if (useBasicInput)
                                    keyboard.source = "BasicInput.qml"
                                else
                                    keyboard.source = "KeyboardInput.qml"
                                keyboard.item.controlName = txtTitle
                                keyboard.item.controlValue = currentValue
                                keyboard.item.minimum = minValue
                                keyboard.item.maximum = maxValue
                            }
                        }
                        onWheel: {
                            currentValue += wheel.angleDelta.y / 120
                            if (currentValue > maxValue)
                                currentValue = maxValue
                            if (currentValue < minValue)
                                currentValue = minValue
                            newValue(currentValue)
                        }
                    }
                }

                Rectangle {
                    id: mark

                    property real markAngleDeg

                    width: parent.stroke; height: width; radius: width/2
                    x: ringCtnr.radius + (ringCtnr.radius - radius) * Math.sin((markAngleDeg - 180) * _toRad) - radius
                    y: ringCtnr.radius - (ringCtnr.radius - radius) * Math.cos((markAngleDeg - 180) * _toRad) - radius
                    color: Colors.skinFrameTXT

                    Rectangle {
                        id: limit

                        color: parent.color
                        width: parent.width/5; height: parent.height*5/3
                        radius: width/2
                        anchors.centerIn: parent
                        rotation: mark.markAngleDeg === alpha ?
                                      alpha : mark.markAngleDeg === 360-alpha ?
                                          -alpha : 0
                        transformOrigin: Item.Center
                        visible: rotation !== 0
                    }

                    MouseArea {
                        preventStealing: preventStealingMouse
                        enabled: root.enabled
                        anchors.centerIn: parent
                        cursorShape: Qt.PointingHandCursor
                        width: parent.width*2; height: parent.height*2

                        onPositionChanged: {
                            if (enabled && pressed) {
                                root.moved()

                                if (!draggable)
                                    return

                                var currentX = mark.x + mouse.x - ringCtnr.width/2
                                var currentY = mark.y + mouse.y - ringCtnr.height/2

                                var a = Qt.vector2d(Math.round(Math.tan(-180*_toRad)), 1).normalized()
                                var b = Qt.vector2d(currentX, currentY).normalized()

                                var cv = (360 +(Math.atan2(b.y, b.x) - Math.atan2(a.y, a.x))*_toDeg)%(360)
                                mark.markAngleDeg = Utils.bound(cv, alpha, 360-alpha)

                                currentValue = Math.round(minValue + _unitDeg*(mark.markAngleDeg - alpha))
                            }
                        }
                        onReleased: newValue(currentValue)
                    }
                }
            }
        }
        Item {
            width: parent.width
            height: (parent.height-parent.spacing) * (1-_widgetRatio)

            StandardText {
                id: title

                font {
                    family: root.ctrlFont
                    pixelSize: Utils.bound(parent.height/2, 12, 48)
                }
                minimumPixelSize: 0
            }
        }
    }

    ModalLoader {
        id: keyboard

        source: ""
        anchors.fill: fullCtnr
    }

    Connections {
        target: keyboard.item
        onOkPressed: {
            currentValue = value
            newValue(value)
            keyboard.close()
        }
        onCancelPressed: keyboard.close()
    }
}
