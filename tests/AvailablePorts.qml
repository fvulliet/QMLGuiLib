import QtQuick 2.2
import GuiLib 1.0

Item {
    id: root
    property bool displayed: false
    property real targetWidth: 0
    property real targetHeight: 0

    property alias model: list.model
    property alias currentIndex: list.currentIndex
    property alias currentItem: list.currentItem

    state: "HIDDEN"

    signal portSelected(int index)

    onDisplayedChanged: {
        if (displayed) {
            state = "SHOWN"
        } else {
            state = "HIDDEN"
        }
    }

    Rectangle {
        id: ctnr
        anchors.fill: parent
        visible: displayed
        color: Colors.skinMenuBGD

        Rectangle {
            id: leftBorder
            color: Colors.themeMainColor
            width: 1; height: parent.height
            anchors.left: parent.left
        }

        Rectangle {
            id: bottomBorder
            color: Colors.themeMainColor
            width: parent.width; height: 1
            anchors.bottom: parent.bottom
        }

        Rectangle {
            id: header
            anchors {
                left: leftBorder.right
                right: parent.right
                top: parent.top
            }
            height: headerText.contentHeight * 2
            color: Colors.themeMainColor

            FontIcon {
                id: headerIcon
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 5
                }
                lib: Fonts.fontAwesome
                icon: FontAwesome.Icon.Link
                color: Colors.skinMenuBGD
                size: parent.height/2
            }

            Text {
                id: headerText
                color: Colors.skinMenuBGD
                font {
                    family: Fonts.sfyFont
                    pointSize: 12
                }
                text: "Available ports"
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: parent.width * 0.2 / 2
                }
            }
        }

        Rectangle {
            id: comPorts
            radius: 2
            anchors {
                top: header.bottom
                bottom: bottomBorder.top
                left: leftBorder.right
                right: parent.right
                topMargin: list.itemHeight
            }
            color: Colors.skinMenuBGD

            Component {
                id: comPortsDelegateCompo
                Rectangle {
                    id: comPortsDelegate
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                    }

                    width: ListView.view.width * 0.8
                    height: ListView.view.itemHeight
                    color: ListView.isCurrentItem ? Colors.skinMenuTXT : Colors.skinMenuBGD

                    Text {
                        id: comPortText
                        text: name
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        color: parent.ListView.isCurrentItem ?
                                   Colors.skinMenuBGD : Colors.skinMenuTXT

                        font {
                            family: Fonts.sfyFont
                            pointSize: 12
                        }
                        smooth: true
                    }
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            parent.ListView.view.currentIndex = index;
                            portSelected(index)
                        }
                    }
                }
            }

            ListView {
                id: list
                property int itemHeight
                focus: true
                spacing: 1
                itemHeight: 40
                anchors.fill: parent
                delegate: comPortsDelegateCompo
                boundsBehavior : Flickable.StopAtBounds
                highlightFollowsCurrentItem: false
                footer: Rectangle { height: list.spacing }
                header: Rectangle { height: list.spacing }
                currentIndex: -1
            }
        }
    }

    states: [
        State {
            name: "SHOWN"
            PropertyChanges {
                target: root;
                width: targetWidth;
                height: targetHeight
            }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation {
                properties: "width, height";
                duration: 250
                easing.type: Easing.InOutQuad
            }
        }
    ]
}
