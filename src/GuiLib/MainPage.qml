import QtQuick 2.9
import GuiLib 1.0

PageLoader {
    id: root

    // public properties
    property bool isVertical: true
    property var subMenu
    property real shiftRatio
    property int shiftAngle
    property alias animating: animation.running

    // signals
    signal restore()

    // functions
    function updateLayout() {
        ghost.xScale = shiftRatio
        ghost.yScale = shiftRatio
        ghost.angle = isVertical ? -shiftAngle : shiftAngle
        if (isVertical) {
            subMenu.width = root.mapFromItem(ghost, 0, 0).x
        }
        else {
            subMenu.height = root.mapFromItem(ghost, 0, 0).y
        }
    }

    // PageLoader's properties
    transform: [
        Scale {
            id: rootScale
            origin {
                x: isVertical ? root.width : root.width / 2
                y: isVertical ? root.height / 2 : root.height
            }
            xScale: 1; yScale: 1
        },
        Rotation {
            id: rootRotation
            axis {
                y: isVertical ? 1 : 0
                x: isVertical ? 0 : 1
                z: 0
            }
            origin {
                x: isVertical ? root.width : root.width / 2
                y: isVertical ? root.height / 2 : root.height
            }
            angle: 0
        }
    ]
    states: [
        State {
            name: "SUBMENU"
            when: subMenu.displayed

            PropertyChanges {
                target: rootScale
                xScale: shiftRatio
                yScale: shiftRatio
            }
            PropertyChanges {
                target: rootRotation
                angle: isVertical ? -shiftAngle : shiftAngle
            }
            PropertyChanges {
                target: fadeRect
                opacity: 0.18
                enabled: true
            }
        }
    ]
    transitions: Transition {
        id: animation

        ParallelAnimation {
            NumberAnimation {
                properties: "xScale, yScale"
                duration: subMenu.animDuration * 0.66
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                property: "angle"
                duration: subMenu.animDuration * 1.25
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                property: "opacity"
                duration: subMenu.animDuration * 2.5
                easing.type: Easing.InOutQuad
            }
        }
    }

    onWidthChanged: updateLayout()
    onHeightChanged: updateLayout()
    Component.onCompleted: updateLayout()

    // inner components
    Rectangle {
        id: fadeRect

        anchors.centerIn: parent
        width: isVertical ? parent.height : parent.width
        height: isVertical ? parent.width : parent.height
        enabled: false
        z: 2
        opacity: 0
        gradient: Gradient {
            GradientStop { position: 0; color: "transparent" }
            GradientStop { position: 1; color: "black" }
        }
        rotation: isVertical ? 90 : 180
        transformOrigin: Item.Center

        MouseArea {
            anchors.fill: parent
            onClicked: {
                restore()
                subMenu.display = false
            }
        }
    }

    Item {
        id: ghost

        property alias angle: transRot.angle
        property alias xScale: transScale.xScale
        property alias yScale: transScale.yScale

        anchors.fill: parent
        transform: [
            Scale {
                id: transScale
                origin {
                    x: isVertical ? root.width : root.width / 2
                    y: isVertical ? root.height / 2 : root.height
                }
            },
            Rotation {
                id: transRot
                axis {
                    x: isVertical ? 0 : 1
                    y: isVertical ? 1 : 0
                    z: 0
                }
                origin {
                    x: isVertical ? root.width : root.width / 2
                    y: isVertical ? root.height / 2 : root.height
                }
            }
        ]
    }
}


