import QtQuick 2.9
import GuiLib 1.0

Rectangle {
    id: root

    // public properties
    property bool isNext: true
    property int maxSize: 0
    property alias clickable: mouseArea.enabled

    // signals
    signal clicked()

    // Rectangle's properties
    height: Utils.limitMax(parent.height / 7, maxSize !== 0 ? maxSize : 30)
    width: height
    color: Qt.darker(Colors.skinFrameBGD, 1.5)

    // inner components
    FontIcon {
        lib: Fonts.faSolid
        icon: isNext ? FontAwesomeSolid.Icon.AngleRight : FontAwesomeSolid.Icon.AngleLeft
        color: Colors.skinFrameFGD
        size: parent.height*0.9
        anchors.centerIn: parent
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
