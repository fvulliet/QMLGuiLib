import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property bool isLeft
    property bool blinking: false
    property alias color: icon.color

    // signals
    signal pressed()

    // Item's properties
    width: 50; height: width
    anchors {
        left: isLeft ? parent.left : undefined
        right: !isLeft ? parent.right: undefined
        verticalCenter: parent.verticalCenter
    }

    // inner components
    FontIcon {
        id: icon

        property real scale: 1

        anchors.centerIn: parent
        lib: Fonts.sfyIco
        icon: isLeft ? SfyIco.Icon.FatLeftArrow : SfyIco.Icon.FatRightArrow
        color: Colors.skinFrameTXT
        size: parent.width * scale
        NumberAnimation on opacity {
            id: anim; from: 0; to: 1; duration: 500; running: false
        }
        SequentialAnimation on color {
            running: blinking
            loops: Animation.Infinite
            alwaysRunToEnd: true
            ColorAnimation { to: "white"; duration: 500 ; easing.type: Easing.InOutQuad}
            ColorAnimation { to: root.color; duration: 500; easing.type: Easing.InOutQuad }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            anim.start()
            root.pressed()
        }
    }
}
