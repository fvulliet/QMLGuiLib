import QtQuick 2.9
import GuiLib 1.0


Page {
    id: noSubMenuView

    property string _trContext: "NoSubMenuView"

    anchors.fill: parent
    Rectangle {
        anchors.fill: parent
        color: '#ffffff'

        TrText {
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 50
            }
            font { pointSize: 30; family: Fonts.sfyFont }
            content: QT_TR_NOOP("NO SUB MENU HERE"); context: _trContext
            color: Colors.themeMainColor
        }
        FontIcon {
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 50
            }
            lib: Fonts.sfyIco
            icon: SfyIco.Icon.SunCloud
            color: Colors.themeMainColor
            size: 250
        }

        Rectangle {
            id: previous
            width: 40; height: width; radius: width/2
            color: Colors.skinFrameTXT
            anchors {
                bottom: parent.bottom
                right: next.left
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
