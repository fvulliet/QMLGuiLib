import QtQuick 2.9
import GuiLib 1.0 as Gui

FocusScope {
    id: root

    property int _gapFromTitle: 30
    property string _trContext: "ControlWidgetsView"

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
                title: QT_TR_NOOP("CONTROL WIDGETS"); trContext: _trContext
            }
            Item {
                width: parent.width; height: parent.height - header.height

                Row {
                    anchors {
                        fill: parent; margins: 10
                    }

                    Column {
                        height: parent.height; width: parent.width/2

                        Item {
                            width: parent.width; height: parent.height/2

                            Gui.BasicPositionWidget {
                                height: Math.min(parent.width, parent.height); width: height
                                anchors.centerIn: parent
                            }
                        }
                        Item {
                            width: parent.width; height: parent.height/2

                            Gui.BasicPositionWidget {
                                height: Math.min(parent.width, parent.height); width: height
                                anchors.centerIn: parent
                                withGhost: true
                            }
                        }
                    }
                    Column {
                        height: parent.height; width: parent.width/2

                        Item {
                            width: parent.width; height: parent.height/2

                            Gui.AdvancedPositionWidget {
                                height: Math.min(parent.width*0.8, parent.height*0.8); width: height
                                anchors.centerIn: parent
                                markSize: 60
                            }
                        }
                        Item {
                            width: parent.width; height: parent.height/2

                            Gui.AdvancedAngleWidget {
                                height: Math.min(parent.width*0.8, parent.height*0.8); width: height
                                anchors.centerIn: parent
                                markSize: 60
                            }
                        }
                    }
                }
            }
        }
    }
}
