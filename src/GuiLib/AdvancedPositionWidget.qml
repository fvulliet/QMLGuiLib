
import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property color widgetColor: Colors.themeMainColor
    property int margin: Style.stdMargin
    property int positionPCent: 100
    property bool enabled: true
    property int frameWidth: 4
    property int markSize: 40

    // signals
    signal newPos(int val)

    // Item's properties

    // inner component
    Item {
        anchors.fill: parent

        Rectangle {
            id: frame

            color: "transparent"
            border {
                color: widgetColor; width: frameWidth
            }
            anchors.fill: parent
        }

        Rectangle {
            id: moving

            width: frame.width - 2*frameWidth
            height: (frame.height - 2*frameWidth) * positionPCent/100
            anchors {
                top: frame.top; topMargin: frameWidth
                horizontalCenter: frame.horizontalCenter
            }
            color: Qt.lighter(widgetColor, 1.5)

            MouseArea {
                anchors {
                    fill: parent; margins: markSize
                }
                onWheel: {
                    positionPCent -= wheel.angleDelta.y / 240
                    positionPCent = Utils.bound(positionPCent, 0, 100)
                }
            }
        }

        Rectangle {
            id: mark

            anchors {
                horizontalCenter: moving.horizontalCenter
                bottom: moving.bottom; bottomMargin: -height/2
            }
            color: "white"
            border {
                color: widgetColor; width: frameWidth
            }
            height: markSize; width: height
            radius: height/2

            ValueDisplay {
                size: parent.height-2*frameWidth
                ctrlFont: Fonts.sfyFont
                anchors.centerIn: parent
                bkgdColor: Colors.skinFrameFGD
                fgdColor: Colors.themeMainColor
                border.width: 0
                value: positionPCent
                unit: "%"
                visible: !arrowsIcon.visible
            }

            Column {
                id: arrowsIcon

                width: 2 * Math.sqrt(Math.pow((parent.width/2),2)/2)
                height: width
                anchors.centerIn: parent
                visible: mouseArea.containsMouse && !mouseArea.pressed

                Item {
                    width: parent.width; height: parent.height/2

                    FontIcon {
                        lib: Fonts.faSolid
                        icon: FontAwesomeSolid.Icon.ArrowUp
                        color: widgetColor
                        anchors.centerIn: parent
                        size: parent.height/1.25
                    }
                }
                Item {
                    width: parent.width; height: parent.height/2

                    FontIcon {
                        lib: Fonts.faSolid
                        icon: FontAwesomeSolid.Icon.ArrowDown
                        color: widgetColor
                        anchors.centerIn: parent
                        size: parent.height/1.25
                    }
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
                        var currentY = mark.y + mouse.y
                        positionPCent = Utils.bound(100*currentY / frame.height, 0, 100)
                    }
                }
                onReleased: newPos(positionPCent)
            }
        }
    }
}
