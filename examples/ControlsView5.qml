import QtQuick 2.9
import GuiLib 1.0 as Gui

FocusScope {
    id: root

    property int _gapFromTitle: 30
    property string _trContext: "ControlsView5"

    Rectangle {
        id: frame

        anchors.fill: parent
        color: Gui.Colors.skinFrameFGD

        MouseArea {
            anchors.fill: parent
            onClicked: parent.focus = true
        }

        Column {
            anchors.fill: parent

            DemoHeader {
                id: header

                width: parent.width; height: parent.height / 15
                title: QT_TR_NOOP("CONTROLS 5"); trContext: _trContext
            }
            Column {
                width: parent.width; height: parent.height - header.height
                spacing: 10

                Rectangle {
                    width: parent.width; height: 100
                    border.width: 1

                    Gui.ActionButton {
                        anchors.fill: parent

                        running: false
                        buttonWidth: parent.width/4
                        buttonHeight: parent.height/2

                        progressWidth: buttonHeight
                        progressHeight: buttonHeight

                        bkgdColor: "transparent"

                        isFlat: false
                        capitalized: false
                        text: qsTr("Ok")
                        ctrlFont: Gui.Fonts.sfyFont
                        activeFocusOnPress: true
                        emphasized: enabled
                        enabled: true

                        onClicked: running = !running
                    }
                }
                Rectangle {
                    width: parent.width/4; height: 100
                    anchors.horizontalCenter: parent.horizontalCenter
                    border.width: 1

                    Gui.ActionButton {
                        anchors.fill: parent

                        running: false
                        buttonWidth: parent.width/4
                        buttonHeight: parent.height/2

                        progressWidth: buttonHeight
                        progressHeight: buttonHeight

                        bkgdColor: "transparent"

                        isFlat: false
                        capitalized: false
                        text: qsTr("Ok")
                        ctrlFont: Gui.Fonts.sfyFont
                        activeFocusOnPress: true
                        emphasized: enabled
                        enabled: true

                        onClicked: running = !running
                    }
                }
                Rectangle {
                    width: parent.width/4; height: 50
                    anchors.horizontalCenter: parent.horizontalCenter
                    border.width: 1

                    Gui.ActionButton {
                        anchors.fill: parent

                        running: false
                        buttonWidth: parent.width/4
                        buttonHeight: parent.height/2

                        progressWidth: parent.height*0.9
                        progressHeight: parent.height*0.9

                        bkgdColor: "transparent"

                        isFlat: false
                        capitalized: false
                        text: qsTr("Ok")
                        ctrlFont: Gui.Fonts.sfyFont
                        activeFocusOnPress: true
                        emphasized: enabled
                        enabled: true

                        onClicked: running = !running
                    }
                }
                Rectangle {
                    width: parent.width; height: 100
                    border.width: 1

                    Gui.ActionButton {
                        anchors.fill: parent
                        gap: 200

                        running: false
                        buttonWidth: parent.width/4
                        buttonHeight: parent.height/2

                        progressWidth: parent.height*0.9
                        progressHeight: parent.height*0.9

                        bkgdColor: "transparent"

                        isFlat: false
                        capitalized: false
                        text: qsTr("Ok")
                        ctrlFont: Gui.Fonts.sfyFont
                        activeFocusOnPress: true
                        emphasized: enabled
                        enabled: true

                        onClicked: running = !running
                    }
                }
            }
        }
    }
}
