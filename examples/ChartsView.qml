import QtQuick 2.9
import GuiLib 1.0
import QtCharts 2.2

Page {
    id: chartsView

    property string _trContext: "ChartsView"

    anchors.fill: parent

    Column {
        anchors.fill: parent

        Item {
            width: parent.width; height: parent.height * 2/3

            ChartView {
                width: height; height: parent.height
                anchors.centerIn: parent
                theme: ChartView.ChartThemeLight
                antialiasing: true

                LineSeries {
                    name: "LineSeries"
                    XYPoint { x: 0; y: 0 }
                    XYPoint { x: 1.1; y: 2.1 }
                    XYPoint { x: 1.9; y: 3.3 }
                    XYPoint { x: 2.1; y: 2.1 }
                    XYPoint { x: 2.9; y: 4.9 }
                    XYPoint { x: 3.4; y: 3.0 }
                    XYPoint { x: 4.1; y: 3.3 }
                }

                ScatterSeries {
                    id: scatter1
                    name: "Scatter1"
                    XYPoint { x: 1.5; y: 1.5 }
                    XYPoint { x: 1.5; y: 1.6 }
                    XYPoint { x: 1.57; y: 1.55 }
                    XYPoint { x: 1.8; y: 1.8 }
                    XYPoint { x: 1.9; y: 1.6 }
                    XYPoint { x: 2.1; y: 1.3 }
                    XYPoint { x: 2.5; y: 2.1 }
                }
            }
        }
        Item {
            width: parent.width; height: parent.height * 1/3
        }
    }
}

