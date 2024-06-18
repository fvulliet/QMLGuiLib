import QtQuick 2.2
import GuiLib 1.0 as Gui

FocusScope {
    id: root

    property int _gapFromTitle: 30
    property string _trContext: "GaugeView"

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
                title: QT_TR_NOOP("GAUGE"); trContext: _trContext
            }
            Column {
                width: parent.width; height: parent.height - header.height
                spacing: 10

                Row {
                    width: parent.width; height: parent.height/2

                    Item {
                        height: parent.height; width: parent.width/3

                        Gui.Gauge {
                            anchors {
                                fill: parent; margins: 10
                            }
                            minValue: 0
                            maxValue: 100
                            currentValue: 0
                        }
                    }
                    Item {
                        height: parent.height; width: parent.width/3

                        Gui.Gauge {
                            anchors {
                                fill: parent; margins: 10
                            }
                            minValue: 0
                            maxValue: 100
                            currentValue: 25
                        }
                    }
                    Item {
                        height: parent.height; width: parent.width/3

                        Gui.Gauge {
                            anchors {
                                fill: parent; margins: 10
                            }
                            minValue: 0
                            maxValue: 100
                            currentValue: 50
                        }
                    }
                }
                Row {
                    width: parent.width; height: parent.height/2

                    Item {
                        height: parent.height; width: parent.width/3

                        Gui.Gauge {
                            anchors {
                                fill: parent; margins: 10
                            }
                            minValue: 0
                            maxValue: 100
                            currentValue: 75
                        }
                    }
                    Item {
                        height: parent.height; width: parent.width/3

                        Gui.Gauge {
                            anchors {
                                fill: parent; margins: 10
                            }
                            minValue: 0
                            maxValue: 100
                            currentValue: 100
                        }
                    }
                }
            }
        }
    }
}
