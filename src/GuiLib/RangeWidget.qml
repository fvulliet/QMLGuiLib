import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property bool enabled: true
    property int widgetValueFrom: -1
    property int widgetValueTo: -1
    property color bkgd: Colors.skinFrameFGD
    property string centerIconLib
    property string centerIconIcon
    property int rot: 0 // "0" reference angle (clockwise), taken from midnight
    property string activeRangeIconLib
    property string activeRangeIconIcon
    property int minGap: 30
    property int mainAngle: {
        if (widgetValueTo > widgetValueFrom)
            return widgetValueFrom + (widgetValueTo - widgetValueFrom) / 2
        else
            return (widgetValueFrom + ((360 + (widgetValueTo - widgetValueFrom)) / 2)) % 360
    }
    property int range: {
        if (widgetValueTo > widgetValueFrom)
            return widgetValueTo - widgetValueFrom
        else
            return ((360 + (widgetValueTo - widgetValueFrom))) % 360
    }
    property alias title: title.text
    property alias titleSize: title.font.pixelSize

    // private properties
    readonly property real _toDeg: 180/Math.PI
    readonly property real _toRad: Math.PI/180
    // note: we want midnight to be the reference for rot
    // and midnight is 0 (math) - 90
    property int _midnight: -90

    onWidgetValueFromChanged: myCanvas.requestPaint()
    onWidgetValueToChanged: myCanvas.requestPaint()

    // inner components
    Column {
        anchors.fill: parent
        spacing: title !== "" ? 5 : 0

        Item {
            width: parent.width
            height: root.title !== "" ? parent.height - titleCtnr.height - parent.spacing : parent.height

            Rectangle {
                id: ringCtnr

                property real stroke: Utils.bound(width/12, 4, 24)

                width: Math.min(parent.width, parent.height)
                height: width
                radius: width > 0 ? width/2 : 0
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                border {
                    color: root.enabled ? Colors.themeMainColor : Colors.disabled(Colors.themeMainColor)
                    width: stroke
                }
                color: "transparent"

                Rectangle {
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: parent.stroke; width: height
                    radius: width/2
                    color: Colors.skinFrameTXT

                    StandardText {
                        id: northText

                        font {
                            bold: true; pixelSize: height*0.9
                        }
                        color: Colors.themeMainColor
                        text: "N"
                    }
                }

                Item {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: parent.stroke; width: height

                    StandardText {
                        id: southText

                        font {
                            bold: true; pixelSize: height*0.9
                        }
                        text: "S"
                    }
                }

                Item {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.stroke; width: height

                    StandardText {
                        id: westText

                        font {
                            bold: true; pixelSize: height*0.9
                        }
                        text: "W"
                    }
                }

                Item {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.stroke; width: height

                    StandardText {
                        id: eastText

                        font {
                            bold: true; pixelSize: height*0.9
                        }
                        text: "E"
                    }
                }

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
                        var startAngle = (widgetValueFrom + _midnight + rot) * _toRad
                        var endAngle = (widgetValueTo + _midnight + rot) * _toRad

                        ctx.beginPath()
                        ctx.moveTo(centerX, centerY)
                        ctx.arc(centerX, centerY, radius, startAngle, endAngle, false)
                        ctx.lineTo(centerX, centerY)
                        ctx.fillStyle = root.enabled ? Colors.themeMainColor : Colors.disabled(Colors.themeMainColor)
                        ctx.fill()
                    }
                }

                Rectangle {
                    id: cursorFrom

                    height: ringCtnr.stroke/2
                    width: ringCtnr.radius - ringCtnr.stroke
                    radius: width/2
                    anchors.verticalCenter: parent.verticalCenter
                    x: ringCtnr.radius
                    color: Colors.skinFrameTXT
                    transformOrigin: Item.Left
                    rotation: widgetValueFrom + _midnight + rot
                }

                Rectangle {
                    id: cursorTo

                    height: ringCtnr.stroke/2
                    width: ringCtnr.radius - ringCtnr.stroke
                    radius: width/2
                    anchors.verticalCenter: parent.verticalCenter
                    x: ringCtnr.radius
                    color: Colors.skinFrameTXT
                    transformOrigin: Item.Left
                    rotation: widgetValueTo + _midnight + rot
                }

                Rectangle {
                    id: markFrom

                    width: 1.5*parent.stroke; height: width; radius: width/2
                    x: ringCtnr.radius + (ringCtnr.radius-2.25*radius) * Math.sin((widgetValueFrom + rot) * _toRad) - radius
                    y: ringCtnr.radius + (ringCtnr.radius-2.25*radius) * -Math.cos((widgetValueFrom + rot) * _toRad) - radius
                    color: Colors.skinFrameTXT

                    Text {
                        anchors {
                            fill: parent; margins: 2
                        }
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font {
                            family: Fonts.sfyFont
                            pixelSize: parent.height*2/3
                        }
                        color: Colors.skinFrameSelectedTXT
                        minimumPixelSize: 5
                        fontSizeMode: Text.Fit
                        text: widgetValueFrom + "°"
                    }

                    MouseArea {
                        enabled: root.enabled
                        anchors.centerIn: parent
                        cursorShape: Qt.PointingHandCursor
                        width: parent.width; height: parent.height

                        onPositionChanged: {
                            if (enabled && pressed) {
                                var currentX = markFrom.x + mouse.x - ringCtnr.width/2
                                var currentY = markFrom.y + mouse.y - ringCtnr.height/2

                                var sign = 1
                                if (rot < 0)
                                    sign = -1

                                var a = Qt.vector2d(Math.round(Math.tan(rot*_toRad)), -sign*1).normalized()
                                var b = Qt.vector2d(currentX, currentY).normalized()

                                widgetValueFrom = (360 + (Math.atan2(b.y, b.x) - Math.atan2(a.y, a.x))*_toDeg) % 360

//                                if (widgetValueTo > widgetValueFrom) {
//                                    if (widgetValueFrom > (widgetValueTo - minGap))
//                                        widgetValueTo = (widgetValueFrom + minGap) % 360
//                                }
                            }
                        }
                        onWheel: {
                            widgetValueFrom += wheel.angleDelta.y / 120
                            if (widgetValueFrom > 359)
                                widgetValueFrom = 0
                            if (widgetValueFrom < 0)
                                widgetValueFrom = 359
                        }
                    }
                }

                Rectangle {
                    id: markTo

                    width: 1.5*parent.stroke; height: width; radius: width/2
                    x: ringCtnr.radius + (ringCtnr.radius-2.25*radius) * Math.sin((widgetValueTo + rot) * _toRad) - radius
                    y: ringCtnr.radius + (ringCtnr.radius-2.25*radius) * -Math.cos((widgetValueTo + rot) * _toRad) - radius
                    color: Colors.skinFrameTXT

                    Text {
                        anchors {
                            fill: parent; margins: 2
                        }
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font {
                            family: Fonts.sfyFont
                            pixelSize: parent.height*2/3
                        }
                        color: Colors.skinFrameSelectedTXT
                        minimumPixelSize: 5
                        fontSizeMode: Text.Fit
                        text: widgetValueTo + "°"
                    }

                    MouseArea {
                        enabled: root.enabled
                        anchors.centerIn: parent
                        cursorShape: Qt.PointingHandCursor
                        width: parent.width; height: parent.height

                        onPositionChanged: {
                            if (enabled && pressed) {
                                var currentX = markTo.x + mouse.x - ringCtnr.width/2
                                var currentY = markTo.y + mouse.y - ringCtnr.height/2

                                var sign = 1
                                if (rot < 0)
                                    sign = -1

                                var a = Qt.vector2d(Math.tan(rot*_toRad), -sign*1).normalized()
                                var b = Qt.vector2d(currentX, currentY).normalized()

                                widgetValueTo = (360 + (Math.atan2(b.y, b.x) - Math.atan2(a.y, a.x)) * _toDeg) % 360

//                                if (widgetValueTo > widgetValueFrom) {
//                                    if (widgetValueTo < (widgetValueFrom + minGap))
//                                        widgetValueFrom = (widgetValueTo - minGap) % 360
//                                }
                            }
                        }
                        onWheel: {
                            widgetValueTo += wheel.angleDelta.y / 120
                            if (widgetValueTo > 359)
                                widgetValueTo = 0
                            if (widgetValueTo < 0)
                                widgetValueTo = 359
                        }
                    }
                }

                Rectangle {
                    id: activeRangeIconCtnr

                    width: 1.5*parent.stroke; height: width; radius: width/2
                    x: ringCtnr.radius + (ringCtnr.radius/2) * Math.sin(mainAngle * _toRad) - radius
                    y: ringCtnr.radius + (ringCtnr.radius/2) * -Math.cos(mainAngle * _toRad) - radius
                    color: bkgd
                    border {
                        width: 1; color: Colors.themeMainColor
                    }
                    visible: activeRangeIconLib.length > 0

                    FontIcon {
                        id: activeRangeIcon

                        anchors.centerIn: parent
                        color: Colors.themeMainColor
                        size: parent.width*0.9
                        lib: activeRangeIconLib
                        icon: activeRangeIconIcon
                    }
                }

                Rectangle {
                    id: center

                    height: ringCtnr.radius/4; width: height
                    radius: width/2
                    anchors.centerIn: parent
                    color: bkgd
                    visible: centerIconLib.length > 0

                    FontIcon {
                        id: centerIcon

                        anchors.centerIn: parent
                        color: Colors.skinFrameTXT
                        size: parent.width*0.75
                        lib: centerIconLib
                        icon: centerIconIcon
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

