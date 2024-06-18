
import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property color widgetColor: Colors.themeMainColor
    property int margin: Style.stdMargin
    property int anglePCent: 100
    property bool enabled: true
    property int frameWidth: 4
    property bool fullyRotatedVB: false // fixme: -90/90 doesn't work
    property color bkgdColor: "white"
    property int markSize: 40
    property bool displayPCent: true

    // private properties
    readonly property real _toDeg: 180/Math.PI
    readonly property real _toRad: Math.PI/180
    property int _angleDeg: 90

    // signals
    signal newPos(int val)

    function degToPCent() {
        if (fullyRotatedVB)
            anglePCent = (_angleDeg + 90)*(100/180)
        else
            anglePCent = _angleDeg * 100/90

    }

    function pCentToDeg() {
        if (fullyRotatedVB)
            _angleDeg = anglePCent*(180/100) - 90
        else
            _angleDeg = anglePCent*(90/100)
    }

    onWidgetColorChanged: {
        bkgdCanvas.requestPaint()
        angleCanvas.requestPaint()
    }

    onAnglePCentChanged: {
        pCentToDeg()
        bkgdCanvas.requestPaint()
        angleCanvas.requestPaint()
    }

    // inner component
    Rectangle {
        id: angleSlatsCtnr

        anchors.fill: parent
        color: "transparent"
        border {
            color: widgetColor; width: frameWidth
        }

        ListView {
            id: angleRectangle

            property int nbSlats: 10

            anchors {
                fill: parent; margins: frameWidth
            }
            model: nbSlats
            interactive: false
            delegate: Item {
                width: ListView.view.width; height: ListView.view.height/angleRectangle.nbSlats

                Rectangle {
                    width: parent.width
                    height: fullyRotatedVB ? 1 + 0.01 * 2 * Math.abs(_angleDeg - 50) * (parent.height-2) :
                                             1 + 0.01 * _angleDeg * (parent.height-2)
                    color: Qt.lighter(Colors.themeMainColor, 1.5)
                }
            }
        }

        MouseArea {
            anchors {
                fill: parent; margins: markSize
            }
            onWheel: {
                _angleDeg -= wheel.angleDelta.y / 240
                _angleDeg = Utils.bound(_angleDeg, 0, 90)
                degToPCent()
            }
        }

        Item {
            id: angleArcCtnr

            width: Math.min(parent.height/2, parent.width)*0.66
            height: fullyRotatedVB ? 2*width : width
            anchors {
                left: parent.left; leftMargin: angleSlatsCtnr.border.width
                top: parent.top; topMargin: angleSlatsCtnr.border.width
            }

            Canvas {
                id: bkgdCanvas

                anchors.fill: parent

                onPaint: {
                    var ctx = getContext("2d")
                    ctx.reset()

                    var centreX = 0
                    var centreY = fullyRotatedVB ? height/2 : 0

                    ctx.beginPath()

                    if (fullyRotatedVB) {
                        ctx.moveTo(centreX, 0)
                        ctx.arc(centreX, centreY,
                                ((height/2 - frameWidth) < 0 ? 0 : (height/2 - frameWidth)),
                                -Math.PI/2, Math.PI/2, false)
                        ctx.lineTo(centreX, 0)
                    } else {
                        ctx.moveTo(centreX, centreY)
                        ctx.arc(centreX, centreY,
                                ((height - frameWidth) < 0 ? 0 : (height - frameWidth)),
                                0, Math.PI/2, false)
                        ctx.lineTo(centreX, centreY)
                    }
                    ctx.strokeStyle = Colors.themeMainColor
                    ctx.lineWidth = frameWidth
                    ctx.stroke()
                    ctx.fillStyle = root.bkgdColor
                    ctx.fill()
                }
            }

            Canvas {
                id: angleCanvas

                width: bkgdCanvas.width
                height: bkgdCanvas.height
                anchors.verticalCenter: bkgdCanvas.verticalCenter

                onPaint: {
                    var ctx2 = getContext("2d")
                    ctx2.reset()

                    var centreX = 0
                    var centreY = fullyRotatedVB ? height/2 : 0

                    ctx2.beginPath()

                    if (fullyRotatedVB) {
                        ctx2.moveTo(centreX, centreY)
                        ctx2.arc(centreX, centreY,
                                 ((height/2 - 2*frameWidth) < 0 ? 0 : (height/2 - 2*frameWidth)),
                                 -Math.PI/2, -Math.PI/2 + (_angleDeg * Math.PI) / 180, false)
                    } else {
                        ctx2.moveTo(centreX, centreY)
                        ctx2.arc(centreX, centreY,
                                 ((height - 2*frameWidth) < 0 ? 0 : (height - 2*frameWidth)),
                                 0, (_angleDeg * Math.PI/2) / 90, false)
                    }
                    ctx2.fillStyle = Qt.lighter(Colors.themeMainColor, 1.5)
                    ctx2.fill()
                }
            }

            Rectangle {
                id: mark

                width: markSize; height: width; radius: width/2
                border {
                    color: widgetColor; width: frameWidth
                }
                x: angleArcCtnr.width * Math.cos(_angleDeg * _toRad) - radius
                y: angleArcCtnr.height * Math.sin(_angleDeg * _toRad) - radius
                color: "white"

                ValueDisplay {
                    id: value

                    size: parent.height - 2*frameWidth
                    ctrlFont: Fonts.sfyFont
                    anchors.centerIn: parent
                    bkgdColor: Colors.skinFrameFGD
                    fgdColor: Colors.themeMainColor
                    border.width: 0
                    value: displayPCent ? anglePCent : _angleDeg
                    unit: displayPCent ? "%" : "°"
                    visible: !arrowsIcon.visible
                }

                Item {
                    id: arrowsIcon

                    anchors.fill: parent
                    visible: mouseArea.containsMouse && !mouseArea.pressed

                    FontIcon {
                        lib: Fonts.faSolid
                        icon: FontAwesomeSolid.Icon.SyncAlt
                        color: widgetColor
                        anchors.centerIn: parent
                        size: parent.height/2.5
                    }
                }

                MouseArea {
                    id: mouseArea

                    enabled: root.enabled
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true

                    onPositionChanged: {
                        if (enabled && pressed) {
                            var currentX = mark.x + mouse.x
                            var currentY = mark.y + mouse.y

                            var a = Qt.vector2d(1, 0).normalized()
                            var b = Qt.vector2d(currentX, currentY).normalized()

                            // atan2(x,y) : gives the angle between the positive part of the X-axis of a given plan
                            // and the point(x,y) in this plan
                            var ang = ((Math.atan2(b.y, b.x) + Math.atan2(a.y, a.x))*_toDeg)
                            _angleDeg = Utils.bound(ang, 0, 90)
                            degToPCent()
                        }
                    }
                }
            }
        }
    }
}
