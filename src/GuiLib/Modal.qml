import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property string color
    property string textColor
    property string title
    property string coreText
    property bool withActions: true

    // signals
    signal accepted()
    signal rejected()

    // Item's properties
    height: ctnr.height

    // inner components
    Rectangle {
        id: ctnr

        color: parent.color
        radius: 2
        width: parent.width
        height: header.height + core.height + footer.height
        opacity: visible ? 1.0 : 0.0
        Behavior on opacity { NumberAnimation {duration: 250} }

        Item {
            id: header

            width: parent.width; height: headerTitle.contentHeight * 2
            visible: root.title !== ""

            Text {
                id: headerTitle

                color: root.textColor
                font {
                    family: Fonts.sfyFont; bold: true
                    pointSize: Utils.limitMax(parent.height/3, 12)
                }
                text: root.title
                anchors {
                    left: parent.left
                    leftMargin: parent.width * 0.1
                    verticalCenter: parent.verticalCenter
                }
            }
            anchors {
                top: parent.top
                left: parent.left
            }

            Rectangle {
                id: bottomSeparator

                width: parent.width * 0.8; height: 1
                color: Colors.themeMainColor
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                }
            }
        }

        Item {
            id: core

            width: parent.width; height: coreContent.contentHeight * 2

            Text {
                id: coreContent

                color: root.textColor
                font { family: Fonts.sfyFont
                    pointSize: Utils.limitMax(parent.height/4, 10) }
                text: root.coreText
                anchors {
                    left: parent.left
                    leftMargin: parent.width * 0.1
                    verticalCenter: parent.verticalCenter
                }
            }
            anchors {
                top: header.bottom
            }
        }

        Item {
            id: footer

            width: parent.width
            height: reject.height * 2
            anchors.top: core.bottom

            Button {
                id: reject

                width: 90; height: width/3
                isFlat: true
                text: "CANCEL"
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: accept.left
                    rightMargin: parent.width * 0.1
                }
                onClicked: {
                    root.rejected()
                }
            }

            Button {
                id: accept

                width: 90; height: width/3
                isFlat: true
                text: "OK"
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: parent.width * 0.1
                }
                onClicked: {
                    root.accepted()
                }
            }

            Rectangle {
                id: topSeparator

                width: parent.width * 0.8; height: 1
                color: Colors.themeMainColor
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                }
            }
        }
    }
}
