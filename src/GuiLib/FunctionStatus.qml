import QtQuick 2.0
import GuiLib 1.0

Item {
    id: root

    // public properties
    property bool running: false
    property color color: Colors.skinFrameTXT

    // Item's properties
    states: State {
        name: "RUNNING"
        when: running

        PropertyChanges {
            target: runningIcon
            opacity: 1
            blinking: true
        }
        PropertyChanges {
            target: stoppedIcon
            opacity: 0
        }
    }
    transitions: Transition {
        NumberAnimation {
            properties: "opacity, blinking"
            easing.type: Easing.InOutQuad
        }
    }

    // inner component
    Rectangle {
        id: ringCtnr

        property real stroke: Utils.bound(height/10, 4, 24)

        width: Math.min(parent.width, parent.height); height: width
        radius: width > 0 ? width/2 : 0
        anchors.centerIn: parent
        border {
            color: root.color
            width: stroke
        }
        color: "transparent"

        FontIcon {
            id: runningIcon

            property bool blinking: false

            anchors.centerIn: parent
            lib: Fonts.fontAwesome; icon: FontAwesome.Icon.Play
            color: root.color
            size: parent.height / 3
            opacity: 0
            visible: opacity > 0

            SequentialAnimation on visible {
                running: runningIcon.blinking
                loops: Animation.Infinite
                PropertyAnimation { to: true; duration: 500 }
                PropertyAnimation { to: false; duration: 500 }
            }
        }

        FontIcon {
            id: stoppedIcon

            anchors.centerIn: parent
            lib: Fonts.fontAwesome; icon: FontAwesome.Icon.Pause
            color: root.color
            size: parent.height / 3
            opacity: 1
        }
    }
}
