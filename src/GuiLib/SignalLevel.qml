import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property int nbBars: 5
    property color offColor: "red"
    property color onColor: "green"
    property real level: 0
    property real curveRatio: 0.5
    property bool isLinear: false
    property real max: 100
    property real min: 0
    // maxOffset: offset from the max, which indicates the threshold for "on"
    // example: if maxOffset is 20, it means all values below (100-20) are "on"
    property real maxOffset: 0

    // inner components
    ListView {
        anchors.fill: parent
        orientation: Qt.Horizontal
        model: nbBars
        interactive: false
        delegate: Item {
            height: ListView.view.height
            width: ListView.view.width/nbBars

            Rectangle {
                height: isLinear ? parent.height*(index+1)/nbBars :
                                   Math.pow(parent.height, Math.pow((index+1)/nbBars, curveRatio))
                width: parent.width/2
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                }
                color: {
                    var boundedLevel = Math.min(max, Math.max(level, min))
                    var scaledLevel = (boundedLevel - min) / (max - maxOffset - min)

                    if (scaledLevel >= (height/(parent.height)))
                        return root.onColor
                    else
                        return root.offColor
                }
            }
        }
    }
}


