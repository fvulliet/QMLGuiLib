import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property alias topLeftItem: topLeft.customItem
    property alias bottomLeftItem: bottomLeft.customItem
    property alias rightItem: right.customItem
    property real titleRatio: 0.5
    property real leftColumnRatio: 1/3

    // inner components
    Item {
        id: container

        property real gap: 10
        property real caseWidth: container.width * leftColumnRatio - gap / 2
        property real caseHeight: container.height * titleRatio - gap / 2

        anchors.fill: parent

        Rectangle {
            id: topLeft

            property Item customItem

            visible: customItem ? 1 : 0
            width: container.caseWidth
            height: container.caseHeight
            anchors {
                top: container.top
                left: container.left
            }
            color: Colors.skinFrameFGD

            onCustomItemChanged: {
                if (customItem) {
                    customItem.parent = topLeft
                    customItem.anchors.fill = topLeft
                }
            }
        }

        Rectangle {
            id: bottomLeft

            property Item customItem

            visible: customItem ? 1 : 0
            width: container.caseWidth
            height: container.height - container.caseHeight - container.gap/2
            anchors {
                left: container.left
                bottom: container.bottom
            }
            color: Colors.skinFrameFGD

            onCustomItemChanged: {
                if (customItem) {
                    customItem.parent = bottomLeft
                    customItem.anchors.fill = bottomLeft
                }
            }
        }

        Rectangle {
            id: right

            property Item customItem

            visible: customItem ? 1 : 0
            width: container.width - topLeft.width - container.gap/2
            height: container.height
            anchors {
                right: container.right
                bottom: container.bottom
            }
            color: Colors.skinFrameFGD

            onCustomItemChanged: {
                if (customItem) {
                    customItem.parent = right
                    customItem.anchors.fill = right
                }
            }
        }
    }
}
