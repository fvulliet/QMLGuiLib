import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property bool enabled: true
    property int currentValue: -9999 // @fixme: we should manage differently,
    //but it seems the beahavior that is executed in "onCurrentValueChanged" doesn't fit in Component.onCompleted
    property int minValue
    property int maxValue
    property color bkgd: Colors.skinFrameFGD
    property bool draggable: true
    property real sizeRatio: 1.0
    property string ctrlFont: Fonts.sfyFont
    property bool fillSelection: true
    property bool isMaximal: true
    property alias unit: unitText.text
    property alias lib: centerIcon.lib
    property alias icon: centerIcon.icon
    property alias title: myTitle.text

    // private properties
    property alias _widgetValue: mark.markAngleDeg
    property int _range : maxValue - minValue
    property real _unitDeg: (maxValue - minValue) / (360 - 2*_alpha)
    readonly property real _toDeg: 180/Math.PI
    readonly property real _toRad: Math.PI/180
    // reference is 6:00pm
    readonly property int _rot: -270
    // alpha is angle from 6:00pm to min / max values
    property real _alpha: (Math.PI/2 - Math.asin((clipper.height - ringCtnr.radius)/ringCtnr.radius)) * _toDeg

    // signals
    signal moved()
    signal newValue(int val)

    onCurrentValueChanged: {
        if (_unitDeg <= 0)
            return

        mark.markAngleDeg = _alpha + (currentValue - minValue)/_unitDeg
        myCanvas.requestPaint()
    }

    // inner components
    Column {
        id: mainSquareContainer

        width: Math.min(parent.width, parent.height); height: width
        anchors.centerIn: parent

        Item {
            id: clipper

            width: parent.width; height: parent.height*3/5
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true

            Rectangle {
                id: ringCtnr

                property real stroke: Utils.bound(width/12, 4, 24)

                width: Math.min(root.width, root.height)
                height: width
                radius: width/2
                anchors.horizontalCenter: parent.horizontalCenter
                border {
                    color: root.enabled ? Colors.themeMainColor : Colors.disabled(Colors.themeMainColor)
                    width: stroke
                }
                color: "transparent"

                Canvas {
                    id: myCanvas

                    anchors.fill: parent
                    smooth: true
                    onPaint: {
                        if (!fillSelection)
                            return

                        var ctx = getContext("2d")
                        ctx.reset()

                        var centerX = width / 2
                        var centerY = height / 2
                        var radius = ringCtnr.radius - 1.5*ringCtnr.stroke

                        var startAngle
                        var endAngle
                        if (isMaximal) {
                            startAngle = (90 + _alpha + 0.1) * _toRad
                            endAngle = (_widgetValue + _rot) * _toRad
                        } else {
                            startAngle = (_widgetValue + _rot) * _toRad
                            endAngle = (90 - _alpha + 0.1) * _toRad
                        }

                        ctx.beginPath()
                        ctx.moveTo(centerX, centerY)
                        ctx.arc(centerX, centerY, radius, startAngle, endAngle, false)
                        ctx.lineTo(centerX, centerY);
                        ctx.fillStyle = root.enabled ? Colors.themeMainColor : Colors.disabled(Colors.themeMainColor)
                        ctx.fill();
                    }
                }

                Rectangle {
                    id: cursor

                    width: ringCtnr.radius - 1.5*ringCtnr.stroke
                    height: ringCtnr.stroke/3
                    radius: height/2
                    color: Colors.skinFrameTXT
                    y: ringCtnr.height/2 - height/2
                    x: ringCtnr.x + ringCtnr.radius
                    transformOrigin: Item.Left
                    rotation: _widgetValue + _rot
                }

                MouseArea {
                   anchors.fill: parent
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

            Item {
                id: mark

                property real markAngleDeg

                width: ringCtnr.radius/2; height: width
                x: ringCtnr.radius + (ringCtnr.radius - 2*ringCtnr.stroke) * Math.sin((markAngleDeg - 180) * _toRad) - width/2
                y: ringCtnr.radius - (ringCtnr.radius - 2*ringCtnr.stroke) * Math.cos((markAngleDeg - 180) * _toRad) - width/2

                MouseArea {
                    enabled: root.enabled
                    anchors.centerIn: parent
                    cursorShape: Qt.PointingHandCursor
                    width: parent.width; height: parent.height

                    onPositionChanged: {
                        if (enabled && pressed) {
                            root.moved()

                            if (!draggable)
                                return

                            var currentX = mark.x + mouse.x - ringCtnr.width/2
                            var currentY = mark.y + mouse.y - ringCtnr.height/2

                            var a = Qt.vector2d(Math.tan(-180*_toRad), 1).normalized()
                            var b = Qt.vector2d(currentX, currentY).normalized()

                            var cv = (360 +(Math.atan2(b.y, b.x) - Math.atan2(a.y, a.x)) * _toDeg) % 360
                            mark.markAngleDeg = Utils.bound(cv, _alpha, 360 - _alpha)

                            currentValue = Math.round(minValue + _unitDeg*(mark.markAngleDeg - _alpha))
                        }
                    }
                    onReleased: newValue(currentValue)
                }
            }

            Rectangle {
                id: center

                height: ringCtnr.radius/4; width: height
                radius: width/2
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: clipper.bottom
                }
                color: bkgd

                FontIcon {
                    id: centerIcon

                    anchors.centerIn: parent
                    color: Colors.skinFrameTXT
                    size: parent.height*0.9
                }
            }
        }
        Item {
            id: valueContainer

            width: parent.width; height: parent.height/5
            anchors.horizontalCenter: parent.horizontalCenter

            Row {
                anchors.fill: parent
                spacing: 5

                Item {
                    height: parent.height
                    width: (parent.width-3*parent.spacing)*1/8

                    Text {
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignTop
                        font {
                            family: root.ctrlFont
                            pixelSize: Math.min(14, parent.height)
                        }
                        color: Colors.skinFrameTXT
                        text: minValue
                    }
                }
                Item {
                    height: parent.height
                    width: (parent.width-3*parent.spacing)*3/8

                    StandardText {
                        horizontalAlignment: Text.AlignRight
                        font {
                            bold: true; pixelSize: parent.height*0.75
                        }
                        text: currentValue
                    }
                }
                Item {
                    height: parent.height
                    width: (parent.width-3*parent.spacing)*3/8

                    StandardText {
                        id: unitText

                        horizontalAlignment: Text.AlignLeft
                        font {
                            family: root.ctrlFont
                            pixelSize: Math.min(40, parent.height/2)
                        }
                    }
                }
                Item {
                    height: parent.height
                    width: (parent.width-3*parent.spacing)*1/8

                    StandardText {
                        verticalAlignment: Text.AlignTop
                        font {
                            family: root.ctrlFont
                            pixelSize: Math.min(14, parent.height)
                        }
                        text: maxValue
                    }
                }
            }

             MouseArea {
                enabled: root.enabled
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    keyboard.source = "KeyboardInput.qml"
                    keyboard.item.controlName = title
                    keyboard.item.controlValue = currentValue
                    keyboard.item.minimum = minValue
                    keyboard.item.maximum = maxValue
                }
            }
        }
        Item {
            width: root.height; height: parent.height/5
            anchors.horizontalCenter: parent.horizontalCenter

            StandardText {
                id: myTitle

                font {
                    family: root.ctrlFont
                    pixelSize: Math.min(20, parent.height/2)
                }
            }
        }
    }

    ModalLoader {
        id: keyboard

        source: ""
        anchors.centerIn: parent
        height: root.height * sizeRatio; width: height/1.4
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

