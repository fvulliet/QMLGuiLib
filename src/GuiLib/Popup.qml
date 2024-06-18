import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property bool displayed: false
    property string msg
    property string subMsg
    property var buttons: ["Ok"]
    property int borderRadius: 3
    property string ctrlFont: Fonts.sfyFont
    property real textSize: 14
    property real buttonHeight: 40
    property real ratio: 0.618
    property int animDuration: 400
    property color typeColor
    property string typeLib
    property string typeIcon
    property bool capitalizeButtons: true
    property int margin: Style.stdMargin
    property alias customContentComponent: customContent.sourceComponent

    // signals
    signal btn1Clicked()
    signal btn2Clicked()
    signal btn3Clicked()

    // inner components
    SequentialAnimation {
        running: displayed

        ParallelAnimation {
            NumberAnimation {
                target: modalityRect
                property: "opacity"
                from: 0; to: 0.25
            }
            NumberAnimation {
                target: popup
                property: "opacity"
                from: 0; to: 1
            }
        }
        ParallelAnimation {
            NumberAnimation {
                target: popup
                property: "width"
                from: 0; to: root.width * ratio
                easing.type: Easing.OutBack
                duration: animDuration
            }
            NumberAnimation {
                target: popup
                property: "height"
                from: 0; to: root.height * ratio
                easing.type: Easing.OutBack
                duration: animDuration
            }
        }
        NumberAnimation {
            target: contents
            property: "opacity"
            from: 0; to: 1
        }
    }

    SequentialAnimation {
        running: !displayed

        NumberAnimation {
            target: contents
            property: "opacity"
            to: 0
        }
        ParallelAnimation {
            NumberAnimation {
                target: popup
                property: "width"
                to: 0
                duration: animDuration
                easing.type: Easing.InBack
            }
            NumberAnimation {
                target: popup
                property: "height"
                to: 0
                duration: animDuration
                easing.type: Easing.InBack
            }
        }
        ParallelAnimation {
            NumberAnimation {
                target: popup
                property: "opacity"
                to: 0
            }
            NumberAnimation {
                target: modalityRect
                property: "opacity"
                to: 0
            }
        }
    }

    Rectangle {
        id: modalityRect

        color: "black"
        opacity: 0
        Behavior on opacity { NumberAnimation {} }
        anchors.fill: parent
        visible: opacity > 0

        MouseArea {
            enabled: parent.visible
            anchors.fill: parent
        }
    }

    Rectangle {
        id: popup

        radius: borderRadius
        color: Colors.skinMenuBGD
        width: 0; height: 0
        anchors.centerIn: parent
        opacity: 0
        visible: opacity > 0

        Rectangle {
            id: container

            anchors {
                fill: parent
                margins: borderRadius
            }
            radius: borderRadius
            color: typeColor

            Rectangle {
                anchors {
                    fill: parent
                    margins: borderRadius
                }
                radius: borderRadius
                color: Colors.skinFrameFGD

                Column {
                    id: contents

                    width: parent.width - margin
                    height: customContentComponent ? customContentComponent.status === Component.Null ? parent.height - 2*margin : 0 : parent.height - 2*margin
                    opacity: 0
                    visible: height > 0

                    Item {
                        width: parent.width; height: parent.height/3

                        FontIcon {
                            anchors {
                                horizontalCenter: parent.horizontalCenter
                                bottom: parent.bottom
                            }
                            lib: typeLib
                            icon: typeIcon
                            color: container.color
                            size: parent.height/2
                        }
                    }
                    Column {
                        width: parent.width; height: parent.height/3
                        spacing: subMsg.length > 0 ? margin : 0

                        Item {
                            width: parent.width
                            height: subMsg.length > 0 ? (parent.height-parent.spacing)/2 : parent.height

                            Text {
                                anchors.fill: parent
                                verticalAlignment: subMsg.length ? Text.AlignBottom : Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font {
                                    family: ctrlFont; pixelSize: textSize
                                    bold: subMsg.length > 0 ? true : false
                                }
                                color: Colors.skinFrameTXT
                                text: msg
                            }
                        }
                        Item {
                            width: parent.width
                            height: subMsg.length > 0 ? (parent.height-parent.spacing)/2 : 0
                            visible: height > 0

                            Text {
                                anchors.fill: parent
                                verticalAlignment: subMsg.length ? Text.AlignTop : Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font {
                                    family: ctrlFont; pixelSize: textSize*0.75
                                }
                                color: Colors.skinFrameTXT
                                text: subMsg
                            }
                        }
                    }
                    Row {
                        width: parent.width; height: parent.height/3

                        Item {
                            height: parent.height
                            width: parent.width / buttons.length

                            Button {
                                height: buttonHeight
                                width: buttons.length ? parent.width/2 : parent.width/4
                                anchors.horizontalCenter: parent.horizontalCenter
                                isFlat: true
                                capitalized: root.capitalizeButtons
                                text: buttons[0].toString(); trContext: "Popup"
                                ctrlFont: root.ctrlFont
                                onClicked: btn1Clicked()
                            }
                        }
                        Item {
                            visible: buttons.length > 1
                            height: parent.height
                            width: parent.width / buttons.length

                            Button {
                                height: buttonHeight; width: parent.width/2
                                anchors.horizontalCenter: parent.horizontalCenter
                                isFlat: true
                                capitalized: root.capitalizeButtons
                                text: buttons.length >= 2 ? buttons[1] : ""; trContext: "Popup"
                                ctrlFont: root.ctrlFont
                                onClicked: btn2Clicked()
                            }
                        }
                        Item {
                            visible: buttons.length > 2
                            height: parent.height
                            width: parent.width / buttons.length

                            Button {
                                height: buttonHeight; width: parent.width/2
                                anchors.horizontalCenter: parent.horizontalCenter
                                isFlat: true
                                capitalized: root.capitalizeButtons
                                text: buttons.length >= 3 ? buttons[2] : ""; trContext: "Popup"
                                ctrlFont: root.ctrlFont
                                onClicked: btn3Clicked()
                            }
                        }
                    }
                }
                Loader {
                    id: customContent

                    width: parent.width - 2*margin
                    height: sourceComponent ? sourceComponent.status !== Component.Null ? parent.height - 2*margin : 0 : 0
                    visible: height > 0
                    sourceComponent: Qt.createComponent("")
                }
            }
        }
    }
}
