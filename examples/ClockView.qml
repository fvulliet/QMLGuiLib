import QtQuick 2.9
import GuiLib 1.0


Item {
    id: root

    property string _trContext: "ClockView"

    DemoHeader {
        id: header

        width: parent.width; height: parent.height / 15
        anchors.top: parent.top
        title: QT_TR_NOOP("CLOCK"); trContext: _trContext
    }

    Row {
        anchors {
            top: header.bottom; topMargin: Style.stdMargin
            bottom: parent.bottom; bottomMargin: Style.stdMargin
        }
        width: parent.width

        Rectangle {
            width: (parent.width-parent.spacing)/2; height: parent.height
            color: "transparent"
            border {
                width: 1; color: Colors.skinFrameBGD
            }

            Clock {
                id: clockWidget

                anchors.fill: parent
                maxRadioBtnHeight: 40
                amPm1224BottomLayout: false
                mechanicalBehavior: true

                Row {
                    width: parent.width; height: 40
                    anchors.bottom: parent.bottom

                    Item {
                        height: parent.height/2; width: parent.width/2

                        StandardText {
                            font.pixelSize: height
                            text: "hourGUI: <b>" + clockWidget.hourGui + "</b>, minute: <b>" + clockWidget.minute + "</b>"
                        }
                    }
                    Item {
                        height: parent.height/2; width: parent.width/2

                        StandardText {
                            font.pixelSize: height
                            text: "hour24: <b>" + clockWidget.hour24 + "</b>, minute: <b>" + clockWidget.minute + "</b>"
                        }
                    }
                }
            }
        }
        Column {
            width: (parent.width-parent.spacing)/2; height: parent.height

            Rectangle {
                width: parent.width; height: parent.height/2
                color: "transparent"
                border {
                    width: 1; color: Colors.skinFrameBGD
                }

                Clock {
                    anchors.fill: parent
                    mechanicalBehavior: true
                }
            }
            Row {
                width: parent.width; height: parent.height/2

                Rectangle {
                    height: parent.height; width: parent.width/2
                    color: "transparent"
                    border {
                        width: 1; color: Colors.skinFrameBGD
                    }

                    Clock {
                        anchors.fill: parent
                        amPm1224BottomLayout: false
                        switch1224: false
                    }
                }
                Column {
                    height: parent.height; width: parent.width/2

                    Rectangle {
                        width: parent.width; height: parent.height/2
                        color: "transparent"
                        border {
                            width: 1; color: Colors.skinFrameBGD
                        }

                        Clock {
                            anchors.fill: parent
                        }
                    }
                    Item {
                        width: parent.width; height: parent.height/4
                    }
                    Rectangle {
                        width: parent.width; height: parent.height/4
                        color: "transparent"
                        border {
                            width: 1; color: Colors.skinFrameBGD
                        }

                        Clock {
                            anchors.fill: parent
                            amPm1224BottomLayout: false
                        }
                    }
                }
            }
        }
    }
}

