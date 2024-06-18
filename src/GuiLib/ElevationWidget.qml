import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property bool enabled: true
    property int widgetValueTo: -1
    property int widgetValueFrom: -1
    property color bkgdColor: Colors.skinFrameFGD
    property alias title: title.text
    property int axisStroke: 4
    property alias groundIconLib: groundIcon.lib
    property alias groundIconIcon: groundIcon.icon
    property string skyIconLib
    property string skyIconIcon
    property alias titleSize: title.font.pixelSize
    property int minGap: 0
    property int range: Math.min(widgetValueFrom, widgetValueTo)
                        + 0.5 * (Math.max(widgetValueFrom, widgetValueTo) - Math.min(widgetValueFrom, widgetValueTo))

    // private properties
    readonly property real _toDeg: 180/Math.PI
    readonly property real _toRad: Math.PI/180

    onWidgetValueToChanged: myCanvas.requestPaint()
    onWidgetValueFromChanged: myCanvas.requestPaint()

    // inner components
    Column {
        anchors.fill: parent
        spacing: title !== "" ? 5 : 0

        Item {
            width: parent.width
            height: root.title !== "" ?
                        parent.height - titleCtnr.height - parent.spacing : parent.height

            Row {
                id: theWidgetCtnr

                property int _stroke: Utils.bound(width/12, 4, 24)
                property int _axisMargin: _stroke/2

                width: {
                    if (parent.width > 1.2*parent.height)
                        return 1.2*parent.height
                    return parent.height
                }
                height: {
                    if (parent.width > 1.2*parent.height)
                        return parent.height
                    return width/1.2
                }
                anchors.centerIn: parent

                Item {
                    height: parent.height; width: parent.width/6

                    Item {
                        id: skyIconCtnr

                        width: parent.width; height: width
                        anchors {
                            top: parent.top; topMargin: theWidgetCtnr._axisMargin
                        }
                        visible: skyIconLib.length > 0

                        FontIcon {
                            id: skyIcon

                            color: Colors.skinFrameTXT
                            size: parent.width*0.9
                            lib: skyIconLib
                            icon: skyIconIcon
                        }
                    }

                    Item {
                        id: groundIconCtnr

                        width: parent.width; height: width
                        anchors {
                            bottom: parent.bottom; bottomMargin: theWidgetCtnr._axisMargin
                        }

                        FontIcon {
                            id: groundIcon

                            anchors {
                                bottom: parent.bottom; right: parent.right
                            }
                            color: Colors.skinFrameTXT
                            size: parent.width*0.9
                            lib: Fonts.sfyIco
                            icon: SfyIco.Icon.City2
                        }
                    }
                }
                Item {
                    height: parent.height; width: parent.width*5/6

                    Item {
                        anchors {
                            fill: parent; margins: theWidgetCtnr._axisMargin
                        }

                        Rectangle {
                            id: yAxis

                            height: parent.height
                            width: axisStroke
                            color: Colors.themeMainColor
                            anchors {
                                bottom: parent.bottom
                            }
                        }

                        Rectangle {
                            id: xAxis

                            width: parent.width
                            height: axisStroke
                            color: Colors.themeMainColor
                            anchors {
                                right: parent.right
                                bottom: parent.bottom
                            }
                        }

                        Item {
                            id: quarterCircle

                            anchors.fill: parent

                            Canvas {
                                id: arcCanvas

                                readonly property int _lineWidth: 1

                                anchors.fill: parent
                                smooth: true

                                onPaint: {
                                    var ctx = getContext("2d")
                                    ctx.reset()

                                    var centerX = x
                                    var centerY = y + height

                                    ctx.beginPath()
                                    ctx.moveTo(centerX, centerY)
                                    ctx.arc(centerX, centerY, width - _lineWidth, 0, Math.PI/2, true)
                                    ctx.strokeStyle = Colors.themeMainColor
                                    ctx.lineWidth = _lineWidth
                                    ctx.stroke()
                                }
                            }

                            Canvas {
                                id: myCanvas

                                anchors.fill: parent
                                smooth: true
                                onPaint: {
                                    var ctx = getContext("2d")
                                    ctx.reset()

                                    var centerX = x
                                    var centerY = y + height

                                    var radius = width - theWidgetCtnr._stroke/2
                                    var startAngle = -widgetValueTo * _toRad
                                    var endAngle = -widgetValueFrom * _toRad

                                    ctx.beginPath()
                                    ctx.moveTo(centerX, centerY)
                                    ctx.arc(centerX, centerY, radius, startAngle, endAngle, false)
                                    ctx.lineTo(centerX, centerY)
                                    ctx.fillStyle = root.enabled ? Colors.themeMainColor : Colors.disabled(Colors.themeMainColor)
                                    ctx.fill()
                                }
                            }

                            Rectangle {
                                id: cursorTo

                                height: theWidgetCtnr._stroke/2
                                width: quarterCircle.width - theWidgetCtnr._stroke
                                radius: width/2
                                y: quarterCircle.height - height/2
                                color: Colors.skinFrameTXT
                                transformOrigin: Item.Left
                                rotation: -widgetValueTo
                            }

                            Rectangle {
                                id: cursorFrom

                                height: theWidgetCtnr._stroke/2
                                width: quarterCircle.width - theWidgetCtnr._stroke
                                radius: width/2
                                y: quarterCircle.height - height/2
                                color: Colors.skinFrameTXT
                                transformOrigin: Item.Left
                                rotation: -widgetValueFrom
                            }

                            Rectangle {
                                id: markTo

                                width: 1.5 * theWidgetCtnr._stroke; height: width; radius: width/2
                                x: (quarterCircle.width - radius) * Math.cos(widgetValueTo * _toRad) - radius
                                y: quarterCircle.height - (quarterCircle.width - radius) * Math.sin(widgetValueTo * _toRad) - radius
                                color: Colors.skinFrameTXT

                                StandardText {
                                    anchors.margins: 2
                                    font.pixelSize: parent.height*2/3
                                    color: Colors.skinFrameSelectedTXT
                                    text: widgetValueTo + "°"
                                }

                                MouseArea {
                                    function handleGap() {
                                        if (widgetValueTo < minGap)
                                            widgetValueTo = minGap
                                        else {
                                            if (widgetValueTo < (widgetValueFrom + minGap))
                                                widgetValueFrom = widgetValueTo - minGap
                                        }
                                    }

                                    enabled: root.enabled
                                    anchors.centerIn: parent
                                    cursorShape: Qt.PointingHandCursor
                                    width: parent.width; height: parent.height

                                    onPositionChanged: {
                                        if (enabled && pressed) {
                                            var currentX = markTo.x + mouse.x
                                            var currentY = markTo.y + mouse.y - quarterCircle.height

                                            var a = Qt.vector2d(1, 0).normalized()
                                            var b = Qt.vector2d(currentX, currentY).normalized()

                                            // atan2(x,y) : gives the angle between the positive part of the X-axis of a given plan
                                            // and the point(x,y) in this plan
                                            var ang = -((Math.atan2(b.y, b.x) - Math.atan2(a.y, a.x))*_toDeg)
                                            widgetValueTo = Utils.bound(ang, 0, 90)
                                            handleGap()
                                        }
                                    }
                                    onWheel: {
                                        widgetValueTo += wheel.angleDelta.y / 120
                                        widgetValueTo = Utils.bound(widgetValueTo, 0, 90)
                                        handleGap()
                                    }
                                }
                            }

                            Rectangle {
                                id: markFrom

                                width: 1.5 * theWidgetCtnr._stroke; height: width; radius: width/2
                                x: (quarterCircle.width - radius) * Math.cos(widgetValueFrom * _toRad) - radius
                                y: quarterCircle.height - (quarterCircle.width - radius) * Math.sin(widgetValueFrom * _toRad) - radius
                                color: Colors.skinFrameTXT

                                StandardText {
                                    anchors.margins: 2
                                    font.pixelSize: parent.height*2/3
                                    color: Colors.skinFrameSelectedTXT
                                    text: widgetValueFrom + "°"
                                }

                                MouseArea {
                                    function handleGap() {
                                        if (widgetValueFrom > (90 - minGap))
                                            widgetValueFrom = 90 - minGap
                                        else {
                                            if (widgetValueFrom > (widgetValueTo - minGap))
                                                widgetValueTo = widgetValueFrom + minGap
                                        }
                                    }

                                    enabled: root.enabled
                                    anchors.centerIn: parent
                                    cursorShape: Qt.PointingHandCursor
                                    width: parent.width; height: parent.height

                                    onPositionChanged: {
                                        if (enabled && pressed) {
                                            var currentX = markFrom.x + mouse.x
                                            var currentY = markFrom.y + mouse.y - quarterCircle.height

                                            var a = Qt.vector2d(1, 0).normalized()
                                            var b = Qt.vector2d(currentX, currentY).normalized()

                                            var ang = -((Math.atan2(b.y, b.x) - Math.atan2(a.y, a.x)) * _toDeg)
                                            widgetValueFrom = Utils.bound(ang, 0, 90)
                                            handleGap()
                                        }
                                    }
                                    onWheel: {
                                        widgetValueFrom += wheel.angleDelta.y / 120
                                        widgetValueTo = Utils.bound(widgetValueTo, 0, 90)
                                        handleGap()
                                    }
                                }
                            }
                        }

                        Rectangle {
                            id: sunIconCtnr

                            width: skyIconCtnr.width; height: width; radius: width/2
                            x: (quarterCircle.width - radius - 1.5*theWidgetCtnr._stroke) * Math.cos(range * _toRad) - radius
                            y: quarterCircle.height - (quarterCircle.width - radius - 1.5*theWidgetCtnr._stroke) * Math.sin(range * _toRad) - radius
                            color: bkgdColor
                            border {
                                width: 1; color: Colors.themeMainColor
                            }

                            FontIcon {
                                id: sunIcon

                                anchors.centerIn: parent
                                color: Colors.themeMainColor
                                size: parent.width*0.9
                                lib: Fonts.sfyIco
                                icon: SfyIco.Icon.Sun
                            }
                        }
                    }
                }
            }
        }
        Item {
            id: titleCtnr

            width: parent.width
            height: root.title !== "" ? childrenRect.height : 0
            visible: height > 0

            Text {
                id: title

                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                font {
                    family: Fonts.sfyFont
                    pixelSize: 12
                }
                color: Colors.skinFrameTXT
            }
        }
    }
}

