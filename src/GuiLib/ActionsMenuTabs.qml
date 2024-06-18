import QtQuick 2.9
import GuiLib 1.0

ListView {
    id: root

    // public properties
    property int pixelSize: 12

    // ListView's properties
    orientation: Qt.Horizontal
    spacing: 1
    highlightFollowsCurrentItem: false

    delegate: Item {
        property alias contentWidth: actionTxt.contentWidth

        height: ListView.view.height
        width: (ListView.view.width / ListView.view.count) - (ListView.view.count-1) * root.spacing

        Text {
            id: actionTxt

            font {
                family: Fonts.sfyFont; pixelSize: root.pixelSize; capitalization: Font.AllUppercase
            }
            color: Colors.skinFrameTXT
            anchors.centerIn: parent
            text: name
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: parent.ListView.view.currentIndex = index
        }
    }

    highlight: Rectangle {
        height: 2
        width: visible ? root.currentItem.contentWidth : 0
        color: Colors.themeMainColor
        visible: root.currentIndex >= 0
        opacity: 0
        x: visible ? (root.currentItem.x + ((root.currentItem.width-width)/2)) : 0
        y: visible ? root.currentItem.height * 2/3 : 0

        Component.onCompleted: opacity = 1

        Behavior on x { NumberAnimation { easing.type: Easing.InOutQuad } }
        Behavior on opacity { NumberAnimation {} }
    }
}
