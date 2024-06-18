import QtQuick 2.0
import GuiLib 1.0 as Gui

Item {
    // public properties
    property alias txtFunction: txtFunction.text
    property bool functionEnabled: false
    property bool functionActive: false
    property bool onDelayVisible: false
    property bool offDelayVisible: false
    property int animeoFunction
    property color bgdColor: Colors.skinFrameBGD

    // Item's properties
    state: "IDLE"
    states: [
        State {
            name: "ENABLED"
            when: functionEnabled && !functionActive && !onDelayVisible && !offDelayVisible

            StateChangeScript {
                script: {
                    delayAnim.stop()
                }
            }
            PropertyChanges {
                target: enabled
                opacity: 1
            }
            PropertyChanges {
                target: onOffdelay
                opacity: 0
            }
        },
        State {
            name: "APPEARING"
            when: functionEnabled && !functionActive && onDelayVisible

            StateChangeScript {
                script: delayAnim.start()
            }
            PropertyChanges {
                target: enabled
                opacity: 1
            }
            PropertyChanges {
                target: onOffdelay
                opacity: 1
            }
        },
        State {
            name: "DISAPPEARING"
            when: functionEnabled && functionActive && offDelayVisible

            StateChangeScript {
                script: delayAnim.start()
            }
            PropertyChanges {
                target: onOffdelay
                opacity: 1
                color: activity.color
            }
            PropertyChanges {
                target: progrItem
                opacity: 1
            }
        },
        State {
            name: "RUNNING"
            when: functionEnabled && functionActive && !onDelayVisible && !offDelayVisible

            StateChangeScript {
                script: {
                    delayAnim.stop()
                }
            }
            PropertyChanges {
                target: onOffdelay
                opacity: 0
            }
            PropertyChanges {
                target: enabled
                opacity: 0
            }
            PropertyChanges {
                target: progrItem
                opacity: 1
            }
        }
    ]
    transitions: Transition {
        NumberAnimation {
            property: "opacity"; duration: 400; easing.type: Easing.InOutQuad
        }
    }

    // inner components
    SequentialAnimation {
        id: delayAnim

        loops: Animation.Infinite
        running: false

        NumberAnimation {
            target: onOffdelay
            property: "opacity"; from: 1; to: 0; easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: onOffdelay
            property: "opacity"; from: 0; to: 0; duration: 750
        }
        NumberAnimation {
            target: onOffdelay
            property: "opacity"; from: 0; to: 1; easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: onOffdelay
            property: "opacity"; from: 1; to: 1; duration: 750
        }
    }

    Row {
        anchors.fill: parent

        Rectangle {
            id: type

            height: parent.height; width: height
            color: bgdColor

            FontIcon {
                color: Colors.skinFrameTXT
                anchors.verticalCenter: parent.verticalCenter
                size: parent.height * 0.9
                lib: Fonts.sfyIco
                icon: {
                    switch (animeoFunction) {
                    case 9:
                    case 10:
                    case 11:
                    case 12:
                        return SfyIco.Icon.Energy
                    case 7:
                    case 8:
                    case 13:
                        return SfyIco.Icon.Comfort1
                    default:
                        return SfyIco.Icon.Security
                    }
                }
            }
        }
        Rectangle {
            id: name

            height: parent.height
            width: parent.width - activity.width - type.width
            color: bgdColor

            Text {
                id: txtFunction
                anchors.centerIn: parent
                font.pixelSize: 17
                color: functionEnabled ? Colors.skinListTXT :
                                         Colors.disabled(Colors.skinListTXT)
            }
        }
        Rectangle {
            id: activity

            height: parent.height; width: height
            color: bgdColor

            FontIcon {
                id: progrItem

                color: Colors.themeMainColor
                anchors.centerIn: parent
                size: parent.width
                lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.Circle
                opacity: 0; visible: opacity > 0
            }

            FontIcon {
                id: enabled

                color: Colors.themeMainColor
                anchors.centerIn: parent
                size: parent.width
                lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.CircleThin
                opacity: 0; visible: opacity > 0
            }

            FontIcon {
                id: onOffdelay

                color: Colors.themeMainColor
                anchors.centerIn: parent
                size: parent.height * 0.9
                lib: Fonts.faSolid
                icon: {
                    if (onDelayVisible)
                        return FontAwesomeSolid.Icon.CaretUp
                    else if (offDelayVisible)
                        return FontAwesomeSolid.Icon.CaretDown
                    else
                        return ""
                }
                visible: opacity > 0; opacity: 0
            }
        }
    }
}
