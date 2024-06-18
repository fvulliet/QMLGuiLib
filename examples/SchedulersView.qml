import QtQuick 2.9
import GuiLib 1.0 as Gui

FocusScope {
    id: root

    property int _gapFromTitle: 30
    property string _trContext: "SchedulersView"

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
                title: QT_TR_NOOP("SCHEDULERS"); trContext: _trContext
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
                                hasCronScheduler: true
                                isPeriod: true
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
                            width: parent.width; height: parent.height*9/10

                            Gui.DateTimePicker {
                                id: dtPicker2

                                width: parent.width; height: width/2
                                anchors.centerIn: parent
                                hasCronScheduler: true
                                isPeriod: true
                            }
                        }
                        Item {
                            width: parent.width; height: parent.height*1/10

                            Gui.StandardText {
                                font.pixelSize: height/2
                                text: Qt.formatDateTime(dtPicker2.currentDateTime, "dd MM yyyy - hh:mm")
                            }
                        }
                    }
                }
                Row {
                    width: parent.width; height: (parent.height-parent.spacing)/2

                    Item {
                        width: parent.width*4/5; height: parent.height

                        Gui.Scheduler {
                            id: scheduler

                            height: parent.height; width: parent.width*0.8
                            anchors.centerIn: parent
                            hasMonthDays: false
                            isPeriod: true
                        }
                    }
                    Column {
                        width: parent.width/5; height: parent.height

                        Row {
                            width: parent.width; height: parent.height/5

                            Item {
                                height: parent.height; width: parent.width/2

                                Gui.RadioButton {
                                    width: parent.width; height: parent.height/2
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: "vertical"
                                    checked: scheduler.isColumn
                                    onClicked: scheduler.isColumn = !scheduler.isColumn
                                }
                            }
                            Item {
                                height: parent.height; width: parent.width/2

                                Gui.RadioButton {
                                    width: parent.width; height: parent.height/2
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: "horizontal"
                                    checked: !scheduler.isColumn
                                    onClicked: scheduler.isColumn = !scheduler.isColumn
                                }
                            }
                        }
                        Item {
                            width: parent.width; height: parent.height/5

                            Gui.StandardText {
                                font.pixelSize: height/2
                                text: scheduler.selectedMonths.toString(2)
                            }
                        }
                        Item {
                            width: parent.width; height: parent.height/5

                            Gui.StandardText {
                                font.pixelSize: height/2
                                text: scheduler.selectedWeekDays.toString(2)
                            }
                        }
                        Item {
                            width: parent.width; height: parent.height/5

                            Gui.StandardText {
                                font.pixelSize: height/2
                                text: scheduler.selectedMonthDays.toString(2)
                            }
                        }
                        Item {
                            width: parent.width; height: parent.height/5

                            Gui.StandardText {
                                font.pixelSize: height/2
                                text: ""
                            }
                        }
                    }
                }
            }
        }
    }
}
