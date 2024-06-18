import QtQuick 2.9
import GuiLib 1.0 as Gui

FocusScope {
    id: root

    property int _gapFromTitle: 30
    property string _trContext: "DateTimePickerView"

    property int myStartHour: 18
    property int myStartMinute: 0

    Rectangle {
        id: frame

        anchors.fill: parent
        color: Gui.Colors.skinFrameFGD

        MouseArea {
            anchors.fill: parent
            onClicked: parent.focus = true
        }

        Column {
            anchors.fill: parent; anchors.margins: 10

            DemoHeader {
                id: header

                width: parent.width; height: parent.height / 15
                title: QT_TR_NOOP("DATETIME PICKER"); trContext: _trContext
            }
            Column {
                width: parent.width; height: parent.height - header.height
                spacing: 10

                Row {
                    width: parent.width; height: (parent.height-parent.spacing)/2
                    spacing: 10

                    Column {
                        height: parent.height; width: (parent.width-parent.spacing)/2

                        Item {
                            width: parent.width; height: parent.height*9/10

                            Gui.DateTimePicker {
                                id: dtPicker1

                                height: parent.height*0.9; width: height
                                anchors.centerIn: parent
                            }
                        }
                        Item {
                            width: parent.width; height: parent.height*1/10

                            Gui.StandardText {
                                font.pixelSize: height/2
                                text: Qt.formatDateTime(dtPicker1.currentDateTime, "dd MM yyyy - hh:mm")
                            }
                        }
                    }
                    Column {
                        height: parent.height; width: (parent.width-parent.spacing)/2

                        Item {
                            width: parent.width; height: parent.height/2

                            Gui.LinearDateTimePicker {
                                id: myDateTime1

                                anchors.fill: parent
                                borderWidth: 0
                            }
                        }
                        Item {
                            id: myDateTime1Text

                            width: parent.width; height: parent.height/2

                            function pad2(number) {
                                return (number < 10 ? '0' : '') + number
                            }

                            Gui.StandardText {
                                font.pixelSize: height/2
                                text: myDateTime1Text.pad2(myDateTime1.currentDateTime.getHours()) + ":" + myDateTime1Text.pad2(myDateTime1.currentDateTime.getMinutes())
                            }
                        }
                    }
                }
                Row {
                    width: parent.width; height: (parent.height-parent.spacing)/2

                    Item {
                        width: parent.width*5/6; height: parent.height

                        Gui.Scheduler {
                            id: scheduler2

                            height: parent.height; width: parent.width*0.8
                            anchors.centerIn: parent
                            hasMonthDays: false
                            isPeriod: false
                            isColumn: false
                            startHour: myStartHour
                            startMinute: myStartMinute
                            onNewStartHour: myStartHour = value
                            onNewStartMinute: myStartMinute = value
                        }
                    }
                    Column {
                        width: parent.width/6; height: parent.height
                        spacing: 20

                        Gui.RadioButton {
                            width: parent.width; height: 20
                            text: "vertical"
                            checked: scheduler2.isColumn
                            onClicked: scheduler2.isColumn = !scheduler2.isColumn
                        }
                        Gui.RadioButton {
                            width: parent.width; height: 20
                            text: "horizontal"
                            checked: !scheduler2.isColumn
                            onClicked: scheduler2.isColumn = !scheduler2.isColumn
                        }
                        Column {
                            width: parent.width; height: childrenRect.height

                            Item {
                                width: parent.width; height: 20

                                Gui.StandardText {
                                    font.pixelSize: height
                                    text: "monthDays: " + scheduler2.selectedMonthDays
                                }
                            }
                            Item {
                                width: parent.width; height: 20

                                Gui.StandardText {
                                    font.pixelSize: height
                                    text: "weekDays: " + scheduler2.selectedWeekDays
                                }
                            }
                            Item {
                                width: parent.width; height: 20

                                Gui.StandardText {
                                    font.pixelSize: height
                                    text: "months: " + scheduler2.selectedMonths
                                }
                            }
                            Item {
                                width: parent.width; height: 20

                                Gui.StandardText {
                                    font.pixelSize: height
                                    text: "startHour: " + myStartHour
                                }
                            }
                            Item {
                                width: parent.width; height: 20

                                Gui.StandardText {
                                    font.pixelSize: height
                                    text: "startMinute: " + myStartMinute
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
