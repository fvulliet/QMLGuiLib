import QtQuick 2.9
import GuiLib 1.0

Rectangle {
    id: root

    // public properties
    property bool tilt: false
    property int angle: 12

    // Rectangle's properties
    color: Colors.skinHeaderBGD
    width: parent.width
    transform: Rotation {
        id: rotation

        axis {
            x: 1
            y: 0
            z: 0
        }
        origin {
            x: width/2
            y: 0
        }
        angle: tilt ? root.angle : 0
        Behavior on angle { NumberAnimation {} }
    }
}
