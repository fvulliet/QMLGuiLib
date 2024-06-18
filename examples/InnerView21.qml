import QtQuick 2.9
import GuiLib 1.0

Page {
    id: root

    Rectangle {
        color: Colors.skinFrameFGD
        anchors.fill: parent

        states: [
            State {
                when: menuMouseControl.containsMouse
                PropertyChanges { target: icon; scale: 2 }
            }
        ]
        transitions: [
            Transition {
                NumberAnimation { properties: "scale"; duration: 1000;
                    easing.type: Easing.InOutQuad
                }
            }
        ]

        FontIcon {
            id: icon
            lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.ThumbsUp
            color: Colors.themeMainColor
            size: parent.height / 2
            anchors.centerIn: parent
        }

        MouseArea {
            id: menuMouseControl
            width: parent.width/2; height: parent.height/2
            anchors.centerIn: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
        }

        NavIcon {
            id: navBack
            isNext: false
            anchors {
                bottom: parent.bottom
                right: parent.right
            }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: history.displayPrevious()
        }
    }
}

