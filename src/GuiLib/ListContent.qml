import QtQuick
import GuiLib 1.0
import QtQuick.Controls

ListView {
    id: list

    // public properties
    property bool topReached: contentY <= 0
    property bool bottomReached: contentY >= (contentHeight - height)
    property real elementHeight
    property int borderRadius
    property bool showHighlight
    property bool animateHighlight: false

    // functions
    function goToTop() {
        contentY = 0
    }

    function goToBottom() {
        contentY = contentHeight - height
    }

    function previous() {
        if (contentY >= elementHeight)
            contentY -= elementHeight
        else
            contentY = 0
    }

    function next() {
        if (contentY <= (contentHeight - height - elementHeight))
            contentY += elementHeight
        else
            contentY = contentHeight - height
    }

    // ListView's properties
    flickableDirection: Flickable.VerticalFlick
    boundsBehavior: Flickable.StopAtBounds
    clip: true
    currentIndex: -1
    highlightFollowsCurrentItem: false
    //if the listview height is less than the enclosing parent,
    // for usability concerns you should disable the scroll behavior
    interactive: contentHeight/height > 1 ? true : false
    Behavior on contentY {
        NumberAnimation {
            easing.type: Easing.InOutQuad
        }
    }
    highlight: Rectangle {
        property int margin: 0

        radius: borderRadius
        color: showHighlight ? Colors.skinFrameTXT : "transparent"
        width: list.currentItem.width - 2*margin; height: list.currentItem.height - 2*margin
        x: list.currentItem.x + margin
        y: list.currentItem.y + margin
        Behavior on y {
            enabled: animateHighlight
            NumberAnimation { easing.type: Easing.InOutQuad }
        }
    }
    ScrollBar.vertical: ScrollBar {
        parent: list.parent
        anchors {
            top: list.top
            right: list.right
            bottom: list.bottom
        }
    }
}
