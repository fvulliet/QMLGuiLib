import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    property bool isValid: false
    property bool isRunning: false
    property var result
    property alias lib: nominalIcon.lib
    property alias icon: nominalIcon.icon
    property alias size: nominalIcon.size
    property alias color: nominalIcon.color

    width: height

    states: [
        State {
            name: "RUNNING"
            when: isValid === true && isRunning === true
            StateChangeScript {
                script: active.start()
            }
        },
        State {
            name: "SUCCESS"
            when: isValid === true && isRunning === false && result === true
            PropertyChanges {
                target: root
                lib: Fonts.fontAwesome; icon: FontAwesome.Icon.ThumbsUp
                color: Colors.skinFrameTXT
                visible: true
            }
            StateChangeScript {
                script: active.stop()
            }
        },
        State {
            name: "FAILURE"
            when: isValid === true && isRunning === false && result === false
            PropertyChanges {
                target: root
                lib: Fonts.fontAwesome; icon: FontAwesome.Icon.ThumbsDown
                color: Colors.fade(Colors.themeSignalKO, Colors.skinFrameFGD, 1.4)
                visible: true
            }
            StateChangeScript {
                script: active.stop()
            }
        },
        State {
            name: "ERROR"
            when: isValid === true && isRunning === false && result === undefined
            PropertyChanges {
                target: root
                lib: Fonts.fontAwesome; icon: FontAwesome.Icon.WarningSign
                color: Colors.themeSignalKO
                size: height * 3 / 5
            }
            StateChangeScript {
                script: active.stop()
            }
        }
    ]

    transitions: [
        Transition {
            to: "RUNNING"
            NumberAnimation {
                properties: "opacity"; duration: 250
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            NumberAnimation {
                properties: "opacity"; duration: 1000
                easing.type: Easing.InOutQuad
            }
        }
    ]

    FontIcon {
        id: nominalIcon

        anchors.centerIn: parent
        opacity: 1; visible: opacity > 0
    }

    ProgressItem {
        id: active

        height: parent.height * 0.9; width: height
        anchors.centerIn: parent
        bkgdColor: "transparent"
    }
}

