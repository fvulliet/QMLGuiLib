import QtQuick 2.9
import GuiLib 1.0


Page {
    id: subMenuView

    anchors.fill: parent
    Rectangle {
        anchors.fill: parent
        color: '#ffffff'

        Text {
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 50
            }
            font { pointSize: 30; family: Fonts.sfyFont }
            text: "SUB MENU 1"
            color: Colors.themeMainColor
        }
        FontIcon {
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 50
            }
            lib: Fonts.sfyIco
            icon: SfyIco.Icon.Storm
            color: Colors.themeMainColor
            size: 250
        }

        Rectangle {
            id: previous
            width: 40; height: width; radius: width/2
            color: Colors.skinFrameTXT
            anchors {
                bottom: parent.bottom
                right: parent.right
            }

            Item {
                anchors.fill: parent
                FontIcon {
                    lib: Fonts.sfyIco
                    icon: SfyIco.Icon.FatLeftArrow
                    color: Colors.skinFrameFGD
                    size: parent.height/2
                    anchors.centerIn: parent
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    currentScreen = 1
                }
            }
        }
    }
}
