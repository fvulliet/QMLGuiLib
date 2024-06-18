import QtQuick 2.9
import GuiLib 1.0 as Gui


Item {
    id: root

    property string _trContext: "DialView"
    property alias current1: knob1.currentValue
    property alias current2: knob2.currentValue
    property alias current3: knob3.currentValue

    Component.onCompleted: {
        knob1.currentValue = 0
        knob2.currentValue = 7500
        knob3.currentValue = 42
    }

    DemoHeader {
        id: header
        width: parent.width; height: parent.height / 15
        anchors.top: parent.top
        title: QT_TR_NOOP("KNOB CONTROL"); trContext: _trContext
    }

    Column {
        anchors {
            top: header.bottom; bottom: parent.bottom
        }
        width: parent.width

        Row {
            width: parent.width; height: parent.height*3/4

            Item {
                height: parent.height; width: parent.width/3

                Gui.Knob {
                    id: knob1

                    anchors.fill: parent; anchors.margins: 5
                    txtTitle: "value"
                    txtValue: current1
                    txtUnit: "%"
                    minValue: 0; maxValue: 100
                    draggable: true
                }
            }
            Item {
                height: parent.height; width: parent.width/3

                Gui.Knob {
                    id: knob2

                    width: parent.width/2; height: parent.height/2
                    anchors.centerIn: parent
                    txtTitle: "speed"
                    txtValue: current2
                    txtUnit: "m/s"
                    minValue: 5000; maxValue: 10000
                    draggable: true
                    useBasicInput: true
                }
            }
            Item {
                height: parent.height; width: parent.width/3

                Gui.Knob {
                    id: knob3

                    anchors.fill: parent; anchors.margins: 5
                    txtTitle: "percent"
                    txtValue: current3
                    txtUnit: "%"
                    minValue: 0; maxValue: 100
                    draggable: true
                    useBasicInput: true
                }
            }
        }
        Row {
            width: parent.width; height: parent.height*1/4

            Item {
                height: parent.height; width: parent.width/3

                Gui.SfyTextInput {
                    anchors.centerIn: parent
                    width: parent.width/2; height: 40
                    text: current1
                    onEditingFinished: current1 = text
                }
            }
            Item {
                height: parent.height; width: parent.width/3

                Gui.SfyTextInput {
                    anchors.centerIn: parent
                    width: parent.width/2; height: 40
                    text: current2
                    onEditingFinished: current2 = text
                }
            }
            Item {
                height: parent.height; width: parent.width/3

                Gui.SfyTextInput {
                    anchors.centerIn: parent
                    width: parent.width/2; height: 40
                    text: current3
                    onEditingFinished: current3 = text
                }
            }
        }
    }
}

