import QtQuick
import Qt5Compat.GraphicalEffects 1.0
import GuiLib 1.0

Item {
    id: root

    // public properties
    property int widgetValue: 0
    property bool enabled: true
    property real maxTextSize: 50
    property string ctrlFont: Fonts.sfyFont
    property alias preventStealing: mouseArea.preventStealing
    property alias propagateEvents: mouseArea.propagateComposedEvents

    // signals
    signal moved()
    signal newValue(int val)

    // functions
    function hideInputPopup() {
        inputPopup.displayed = false
    }

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
    transitions: [
        Transition {
            NumberAnimation {
                properties: "font.pixelSize"
            }
        }
    ]

    // inner components
    MouseArea {
        id: mouseArea

        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        enabled: root.enabled

        onPositionChanged: {
            root.moved()

            if (pressed) {
                var currentX = mouse.x - parent.width/2
                var currentY = mouse.y - parent.height/2

                var b = Qt.vector2d(0, -1).normalized()
                var a = Qt.vector2d(currentX, currentY).normalized()

                widgetValue = (360+(Math.atan2(b.y, b.x) - Math.atan2(a.y, a.x))*ringCtnr.toDeg) % 360
            }
        }
        onReleased: {
            hideInputPopup()
            newValue(widgetValue)
        }
        onWheel: {
            widgetValue += wheel.angleDelta.y / 120
            if (widgetValue > 359)
                widgetValue = 0
            if (widgetValue < 0)
                widgetValue = 359
            newValue(widgetValue)
        }
    }

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
        transformOrigin: Item.Center
        rotation: (360-widgetValue)%360

        Rectangle {
            color: Colors.skinFrameTXT
            radius: width/2
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
            height: parent.stroke; width: height
            rotation: -ringCtnr.rotation
            transformOrigin: Item.Center

            Text {
                id: northText

                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font {
                    family: root.ctrlFont; bold: true
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
            rotation: -ringCtnr.rotation
            transformOrigin: Item.Center

            Text {
                id: southText

                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font {
                    family: root.ctrlFont; bold: true
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
            rotation: -ringCtnr.rotation
            transformOrigin: Item.Center

            Text {
                id: westText

                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font {
                    family: root.ctrlFont; bold: true
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
            rotation: -ringCtnr.rotation
            transformOrigin: Item.Center

            Text {
                id: eastText

                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font {
                    family: root.ctrlFont; bold: true
                    pixelSize: height*0.9
                }
                color: Colors.skinFrameTXT
                text: "E"
            }
        }
    }

    Rectangle {
        id: cursor

        width: ringCtnr.stroke/3
        height: ringCtnr.radius - ringCtnr.stroke
        radius: width/2
        anchors.horizontalCenter: parent.horizontalCenter
        y: ringCtnr.stroke
        color: Colors.skinFrameTXT
    }

    Rectangle {
        id: center

        height: ringCtnr.height/3; width: height
        radius: width/2
        anchors.centerIn: parent
        color: Colors.skinFrameTXT

        Text {
            id: centerText

            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font {
                family: root.ctrlFont
                pixelSize: Math.min(maxTextSize, parent.height/2)
            }
            color: Colors.skinFrameSelectedTXT
            text: widgetValue
        }

        MouseArea {
            enabled: !inputPopup.displayed
            anchors.fill: parent
            onReleased: inputPopup.displayed = true
        }
    }

    Rectangle {
        id: inputPopup

        property bool displayed: false

        radius: 3
        border {
            width: radius
            color: Colors.skinMenuBGD
        }
        color: Colors.skinFrameFGD
        width: 0; height: 0
        anchors.centerIn: center
        visible: opacity > 0
        opacity: 0
        focus: true

        Keys.onPressed: {
            if ((event.key === Qt.Key_Return) || (event.key === Qt.Key_Enter)) {
                displayed = false
                root.widgetValue = parseInt(txtInput.text, 10)
                newValue(root.widgetValue)
                event.accepted = true
            }
        }

        states: State {
            when: inputPopup.displayed

            PropertyChanges {
                target: inputPopup
                width: center.width
                height: center.width/2
                opacity: 1
            }
        }
        transitions: Transition {
            NumberAnimation {
                properties: "width, height, opacity"
                easing.type: Easing.InOutQuad
            }
        }

        TextInput {
            id: txtInput

            anchors.fill: parent
            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignVCenter
            color: center.color
            selectionColor: color
            selectedTextColor: Colors.skinFrameFGD
            selectByMouse: true
            font {
                pixelSize: centerText.font.pixelSize/1.5
                family: root.ctrlFont
            }
            validator: RegularExpressionValidator {
                regularExpression: /^(?:35[0]|3[0-5][0-9]|[12][0-9][0-9]|[1-9]?[0-9])?$/
            }
            text: root.widgetValue
        }
    }
}
