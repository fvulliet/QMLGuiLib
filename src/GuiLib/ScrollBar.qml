import QtQuick 2.9
import GuiLib 1.0

Rectangle {
    id: root

    // public properties
    property bool withLift: true
    property Flickable flick
    property int defaultWidth: 4
    property int margin: 1

    // Rectangle's properties
    anchors {
        left: flick.right
        leftMargin: margin
    }
    y: flick.visibleArea.yPosition * flick.height + flick.y
    width: visible ? defaultWidth : 0
    height: flick.visibleArea.heightRatio * flick.height
    color: Colors.skinFrameTXT
    visible: flick.visibleArea.heightRatio < 0.9999

    // inner components
    Item {
        id: lift

        property alias icon: arrowIcon.icon

        width: 30; height: width
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.left
        }
        opacity: 0
        visible: withLift && opacity > 0

        states: [
            State {
                name: "TOP"
                when: flick.contentY < 1

                PropertyChanges {
                    target: lift; icon: FontAwesomeSolid.Icon.AngleDown
                    opacity: 1
                }
            },
            State {
                name: "BOTTOM"
                when: flick.contentY >= (flick.contentHeight - flick.height - 1)

                PropertyChanges {
                    target: lift; icon: FontAwesomeSolid.Icon.AngleUp
                    opacity: 1
                }
            }
        ]
        transitions: Transition {
            NumberAnimation {
                property: "opacity"
            }
        }

        FontIcon {
            id: arrowIcon

            lib: Fonts.faSolid
            icon: ""
            color: Colors.skinFrameTXT
            size: parent.height*0.9
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (lift.state === "BOTTOM")
                    flick.contentY = 0
                else if (lift.state === "TOP") {
                    flick.contentY = flick.contentHeight - flick.height
                    flick.returnToBounds()
                }
            }
        }
    }
}
