import QtQuick 2.9
import GuiLib 1.0

Page {
    id: root
    anchors.fill: parent

    property bool completed: false
    property ListModel items: ListModel {}

    Component.onCompleted: {
        items.append({ "layoutItem": it1 });
        items.append({ "layoutItem": it2 });
        completed = true
    }

    onCompletedChanged: {
        if (completed) {
            grid.model = items
        }
    }

    LayoutGrid {
        id: grid
        anchors.fill: parent
    }

    Item {
        id: it1
        anchors.fill: parent
        Rectangle {
            anchors.fill: parent
            color: Colors.skinFrameFGD
            FontIcon {
                id: leftIcon
                lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.ThumbsUp
                color: Colors.themeMainColor
                size: parent.height / 4
                anchors.centerIn: parent
            }

            Text {
                anchors.top: leftIcon.bottom; anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                font { family: Fonts.sfyFont; pixelSize: 12 }
                color: leftIcon.color
                text: "THUMBS UP"
            }

            NavIcon {
                isNext: true
                anchors {
                    bottom: parent.bottom
                    right: parent.right
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    var icon = { iconLib: leftIcon.lib, iconIcon: leftIcon.icon }
                    myHistory.displayNext(Qt.resolvedUrl("InnerView21.qml"), icon, "ThumbUp")
                }
            }
        }
    }

    Item {
        id: it2
        anchors.fill: parent
        Rectangle {
            anchors.fill: parent
            color: Colors.skinFrameFGD
            FontIcon {
                id: rightIcon
                lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.ThumbsDown
                color: Colors.themeMainColor
                size: parent.height / 4
                anchors.centerIn: parent
            }

            Text {
                anchors.top: rightIcon.bottom; anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                font { family: Fonts.sfyFont; pixelSize: 12 }
                color: rightIcon.color
                text: "THUMBS DOWN"
            }

            NavIcon {
                isNext: true
                anchors {
                    bottom: parent.bottom
                    right: parent.right
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    var icon = { iconLib: rightIcon.lib, iconIcon: rightIcon.icon }
                    myHistory.displayNext(Qt.resolvedUrl("InnerView22.qml"), icon, "ThumbDown")
                }
            }
        }
    }
}

