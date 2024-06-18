import QtQuick 2.9
import GuiLib 1.0

Rectangle {
    id: root

    property int period: 2000
    property int minPos: 40
    property int maxPos: 60
    property color widgetColor: Colors.themeMainColor

    color: "transparent"
    border {
        width: 2; color: widgetColor
    }
//    height: winkBtn.height
//    width: height
//    anchors {
//        left: winkBtn.right; leftMargin: 4*Style.stdMargin
//        verticalCenter: parent.verticalCenter
//    }

    SequentialAnimation {
        id: anim

        NumberAnimation {
            target: positionRectangle
            property: "height"
            alwaysRunToEnd: true
            from: root.height * 0.4; to: root.height * maxPos/100
            easing.type: Easing.OutQuad
            duration: 250
        }
        NumberAnimation {
            target: positionRectangle
            property: "height"
            alwaysRunToEnd: true
            from: root.height * 0.6; to: root.height * minPos/100
            easing.type: Easing.OutQuad
            duration: 250
        }
    }

    Rectangle {
        id: positionRectangle

        color: parent.widgetColor
        width: parent.width; height: parent.height * minPos/100
    }

    Timer {
        interval: period
        repeat: true
        running: true
        onTriggered: anim.start()
    }
}
