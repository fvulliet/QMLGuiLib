import QtQuick 2.0
import GuiLib 1.0

Rectangle {
    id: root

    // public properties
    property bool withLift: true
    property Flickable flick

    // Rectangle's properties
    color: Colors.skinFrameBGD
    width: 4
    visible: (flick.visibleArea.heightRatio < 1.0)
    anchors {
        top: flick.top
        right: flick.right
        bottom: flick.bottom
    }

    // inner components
    Rectangle {
        id: handle

        height: (root.height * flick.visibleArea.heightRatio)
        color: Colors.skinMenuBGD
        anchors {
            left: parent.left
            right: parent.right
        }

        Binding { // Calculate handle's x/y position based on the content position of the Flickable
            target: handle
            property: "y"
            value: (flick.visibleArea.yPosition * root.height)
            when: (!dragger.drag.active)
        }

        Binding { // Calculate Flickable content position based on the handle x/y position
            target: flick
            property: "contentY"
            value: (handle.y / root.height * flick.contentHeight)
            when: (dragger.drag.active)
        }

        MouseArea {
            id: dragger

            anchors.fill: parent
            drag {
                target: handle
                minimumX: handle.x
                maximumX: handle.x
                minimumY: 0
                maximumY: (root.height - handle.height)
                axis: Drag.YAxis
            }
        }
    }
}
