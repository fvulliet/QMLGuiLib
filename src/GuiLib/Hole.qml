import QtQuick 2.9
import GuiLib 1.0

ItemShadow {
    id: root

    // public properties
    property Flickable flick
    property bool isUpperHole: true
    property int elevationLevel: 2

    // ItemShadow's properties
    z: flick.z + 1
    width: flick.width - 2*elevationLevel; height: flick.spacing
    anchors.horizontalCenter: parent.horizontalCenter
    elevation: {
        if (isUpperHole) {
            if (flick.visibleArea.yPosition > 0)
                return elevationLevel
            else
                return 0
        } else {
            if (flick.visibleArea.yPosition <= (1-flick.visibleArea.heightRatio-0.01))
                return elevationLevel
            else
                return 0
        }
    }
    rotation: isUpperHole ? 0 : 180
}
