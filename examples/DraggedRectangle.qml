import QtQuick 2.9

Rectangle {
    id: root

    property bool readyToDrop: false
    property string name
    property real yOffset
    property real maxDragX
    property real maxDragY
    property int hotSpotX: 0
    property int hotSpotY: 0
    property bool alignH: true

    signal draggedItemPressed()
    signal draggedItemReleased()

    Drag.active: draggedMouseArea.drag.active
    Drag.hotSpot.x: hotSpotX
    Drag.hotSpot.y: hotSpotY
    radius: height/2

    MouseArea {
        id: draggedMouseArea

        anchors.fill: parent
        cursorShape: Qt.DragMoveCursor
        drag.target: root
        drag.axis: Drag.XAndYAxis
        drag.smoothed: true
        drag.minimumY: 0
        drag.minimumX: 0
        drag.maximumY: maxDragY
        drag.maximumX: maxDragX
        onPressed: draggedItemPressed()
        onReleased: draggedItemReleased()
    }
}
