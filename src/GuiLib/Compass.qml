import QtQuick 2.0
import Qt5Compat.GraphicalEffects 1.0
import GuiLib 1.0

Item {
    id: root

    // public properties
    property int widgetValue: 0
    property bool enabled: true
    property real maxTextSize: 50

    // signals
    signal moved()

    // Item's properties
    states: [
        State {
            name: "NORTH"
            when: (widgetValue >= 355) || (widgetValue <= 5)

            PropertyChanges {
                target: northText
                font.pixelSize: this.height*0.99
                font.bold: true
            }
        },
        State {
            name: "SOUTH"
            when: (widgetValue <= 185) && (widgetValue >= 175)

            PropertyChanges {
                target: southText
                font.pixelSize: this.height*0.99
                font.bold: true
            }
        },
        State {
            name: "WEST"
            when: (widgetValue <= 275) && (widgetValue >= 265)

            PropertyChanges {
                target: westText
                font.pixelSize: this.height*0.99
                font.bold: true
            }
        },
        State {
            name: "EAST"
            when: (widgetValue <= 95) && (widgetValue >= 85)

            PropertyChanges {
                target: eastText
                font.pixelSize: this.height*0.99
                font.bold: true
            }
        }
    ]
    transitions: Transition {
        NumberAnimation {
            property: "font.pixelSize"
        }
    }

    // inner components
    Rectangle {
        id: ringCtnr

        property real stroke: Utils.bound(width/12, 4, 24)
        property real centerX: x + radius
        property real centerY: y + radius
        readonly property real toDeg: 180/Math.PI
        readonly property real toRad: Math.PI/180

        width: Math.min(parent.width, parent.height)
        height: width
        radius: width > 0 ? width/2 : 0
        anchors.centerIn: parent
        border {
            color: Colors.themeMainColor; width: stroke
        }
        color: "transparent"

        Rectangle {
            color: Colors.skinFrameTXT
            radius: width/2
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
            height: parent.stroke; width: height

            Text {
                id: northText

                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font {
                    family: Fonts.sfyFont; bold: true
                    pixelSize: height*0.9
                }
                color: Colors.themeMainColor
                text: "N"
            }
        }

        Item {
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            height: parent.stroke; width: height

            Text {
                id: southText

                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font {
                    family: Fonts.sfyFont; bold: true
                    pixelSize: height*0.9
                }
                color: Colors.skinFrameTXT
                text: "S"
            }
        }

        Item {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            height: parent.stroke; width: height

            Text {
                id: westText

                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font {
                    family: Fonts.sfyFont; bold: true
                    pixelSize: height*0.9
                }
                color: Colors.skinFrameTXT
                text: "W"
            }
        }

        Item {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            height: parent.stroke; width: height

            Text {
                id: eastText

                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font {
                    family: Fonts.sfyFont; bold: true
                    pixelSize: height*0.9
                }
                color: Colors.skinFrameTXT
                text: "E"
            }
        }

        Rectangle {
            id: cursor

            height: ringCtnr.stroke/3
            width: ringCtnr.radius - ringCtnr.stroke
            radius: width/2
            anchors.verticalCenter: parent.verticalCenter
            x: ringCtnr.radius
            color: Colors.skinFrameTXT
            transformOrigin: Item.Left
            rotation: widgetValue - 90 // our "0" reference is midnight
        }

        Rectangle {
            id: center

            height: ringCtnr.height/3; width: height
            radius: width/2
            anchors.centerIn: parent
            color: Colors.skinFrameTXT

            Text {
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font {
                    family: Fonts.sfyFont
                    pixelSize: Math.min(maxTextSize, parent.height/2)
                }
                color: Colors.skinFrameSelectedTXT
                text: widgetValue
            }

            MouseArea {
                anchors.fill: parent
                onWheel: {
                    widgetValue += wheel.angleDelta.y / 120
                    if (widgetValue > 359)
                        widgetValue = 0
                    if (widgetValue < 0)
                        widgetValue = 359
                }
            }
        }

        Rectangle {
            id: mark

            width: ringCtnr.radius/2; height: width; radius: width/2
            x: ringCtnr.radius + (ringCtnr.radius - ringCtnr.stroke) * Math.sin(widgetValue * ringCtnr.toRad) - radius
            y: ringCtnr.radius - (ringCtnr.radius - ringCtnr.stroke) * Math.cos(widgetValue * ringCtnr.toRad) - radius
            color: "transparent"

            MouseArea {
                anchors.centerIn: parent
                cursorShape: Qt.PointingHandCursor
                width: parent.width; height: parent.height
                enabled: root.enabled

                onPositionChanged: {
                    root.moved()

                    if (pressed) {
                        var currentX = mark.x + mouse.x - ringCtnr.width/2
                        var currentY = mark.y + mouse.y - ringCtnr.height/2

                        var a = Qt.vector2d(0, -1).normalized()
                        var b = Qt.vector2d(currentX, currentY).normalized()

                        widgetValue = (360+(Math.atan2(b.y, b.x) - Math.atan2(a.y, a.x))*ringCtnr.toDeg)%360
                    }
                }
            }
        }
    }
}
