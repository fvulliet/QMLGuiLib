import QtQuick 2.2
import GuiLib 1.0

Item {
    id: root

    // public properties
    property int currentValue: -9999 // @fixme: we should manage differently,
    //but it seems the beahavior that is executed in "onCurrentValueChanged" doesn't fit in Component.onCompleted
    property int minValue
    property int maxValue
    property string ctrlFont: Fonts.sfyFont
    property real _widgetValue: _alpha + (currentValue - minValue)/_unitDeg

    // private properties
    property int _range : maxValue - minValue
    property real _unitDeg: (maxValue - minValue) / (360 - 2*_alpha)
    readonly property real _toDeg: 180/Math.PI
    readonly property real _toRad: Math.PI/180
    // reference is 6:00pm
    readonly property int _rot: -270
    // alpha is angle from 6:00pm to min / max values
    property real _alpha: (Math.PI/2 - Math.asin((clipper.height - cursor.height/2 - ringCtnr.radius)/ringCtnr.radius)) * _toDeg

    Component.onCompleted: {
        if (_unitDeg <= 0)
            return

        myCanvas.requestPaint()
    }

    // inner components
    Column {
        id: mainSquareContainer

        width: parent.width; height: width/2
        anchors.centerIn: parent

        Item {
            id: clipper

            width: parent.width; height: parent.height + cursor.height/2
            clip: true

            Rectangle {
                id: ringCtnr

                property real stroke: Utils.bound(width/12, 4, 24)

                width: Math.min(root.width, root.height)
                height: width
                radius: width/2
                anchors.horizontalCenter: parent.horizontalCenter
                border {
                    color: Colors.themeMainColor
                    width: stroke
                }
                color: "transparent"

                Canvas {
                    id: myCanvas

                    anchors.fill: parent
                    smooth: true
                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.reset()

                        var centerX = width / 2
                        var centerY = height / 2
                        var radius = ringCtnr.radius - 1.5*ringCtnr.stroke

                        var startAngle
                        var endAngle
                        startAngle = (90 + _alpha + 0.1) * _toRad
                        endAngle = (_widgetValue + _rot) * _toRad

                        ctx.beginPath()
                        ctx.moveTo(centerX, centerY)
                        ctx.arc(centerX, centerY, radius, startAngle, endAngle, false)
                        ctx.lineTo(centerX, centerY);
                        ctx.fillStyle = Qt.lighter(Colors.themeMainColor, 1.80 - 0.80*((currentValue - minValue) / _range))
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
                    x: ringCtnr.width/2
                    transformOrigin: Item.Left
                    rotation: _widgetValue + _rot
                }
            }
        }
        Item {
            id: valueContainer

            width: parent.width; height: parent.height/5

            Row {
                anchors.fill: parent

                Item {
                    id: minLimit

                    height: parent.height
                    width: ringCtnr.border.width

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
                    width: parent.width - minLimit.width - maxLimit.width

                    StandardText {
                        font {
                            bold: true; pixelSize: parent.height*0.75
                        }
                        text: currentValue
                    }
                }
                Item {
                    id: maxLimit

                    height: parent.height
                    width: ringCtnr.border.width

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
        }
    }
}

