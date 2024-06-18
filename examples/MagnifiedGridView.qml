import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    property string _trContext: "MagnifiedGridView"

    DemoHeader {
        id: header

        width: parent.width; height: parent.height / 15
        anchors.top: parent.top
        title: QT_TR_NOOP("MAGNIFIER"); trContext: _trContext
    }

    Column {
        anchors {
            top: header.bottom; topMargin: Style.stdMargin
            bottom: parent.bottom; bottomMargin: Style.stdMargin
        }
        width: parent.width

        Item {
            width: parent.width; height: parent.height/5

            Magnifier {
                id: magnifierWidget

                width: parent.width/2; height: 50
                anchors.centerIn: parent
                widgetValue: 0.75
            }
        }
        Item {
            width: parent.width; height: parent.height*4/5

            GridView {
                id: zonesGrid

                property int maxItemsPerLine: 1 + (1-magnifierWidget.widgetValue) * 5
                property int maxItemsPerColumn: 1 + (1-magnifierWidget.widgetValue) * 5

                anchors {
                    fill: parent; margins: 20
                }
                model: 20
                clip: true
                cellWidth: width/maxItemsPerLine
                cellHeight: height/maxItemsPerColumn
                interactive: count > (maxItemsPerLine * maxItemsPerColumn)
                boundsBehavior: Flickable.StopAtBounds
                delegate: Item {
                    width: GridView.view.cellWidth; height: GridView.view.cellHeight

                    Rectangle {
                        id: innerRect

                        property real _ratio: 1

                        anchors.centerIn: parent
                        width: parent.width - 5
                        height: parent.height - 5
                        color: Colors.skinFrameBGD
                        radius: 2
                    }
                }
            }
        }
    }
}

