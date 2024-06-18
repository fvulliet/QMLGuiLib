import QtQuick 2.9
import GuiLib 1.0


Page {
    id: root

    property bool completed: false
    property ListModel items: ListModel {}
    property string _trContext: "NavigationView"

    anchors.fill: parent

    Component.onCompleted: {
        items.append({ "layoutItem": it1 });
        items.append({ "layoutItem": it2 });
        items.append({ "layoutItem": it3 });
        items.append({ "layoutItem": it4 });
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
                id: topLeftIcon
                lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.BarChart
                color: Colors.themeMainColor
                size: parent.height / 4
                anchors.centerIn: parent
            }

            TrText {
                anchors.top: topLeftIcon.bottom; anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                font { family: Fonts.sfyFont; pixelSize: 12 }
                color: topLeftIcon.color
                content: QT_TR_NOOP("CHART"); context: _trContext
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
                    var icon = { iconLib: topLeftIcon.lib, iconIcon: topLeftIcon.icon }
                    myHistory.displayNext(Qt.resolvedUrl("InnerView1.qml"), icon, "Chart")
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
                id: topRighttIcon
                lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.ListAlt
                color: Colors.themeMainColor
                size: parent.height / 4
                anchors.centerIn: parent
            }

            TrText {
                anchors.top: topRighttIcon.bottom; anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                font { family: Fonts.sfyFont; pixelSize: 12 }
                color: topRighttIcon.color
                content: QT_TR_NOOP("MAIN MENU CONFIG"); context: _trContext
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
                    var icon = { iconLib: topRighttIcon.lib, iconIcon: topRighttIcon.icon }
                    myHistory.displayNext(Qt.resolvedUrl("MainMenuConfigView.qml"), icon, "configview")
                }
            }
        }
    }
    Item {
        id: it3
        anchors.fill: parent
        Rectangle {
            anchors.fill: parent
            color: Colors.skinFrameFGD
            FontIcon {
                id: bottomLeftIcon
                lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.Calendar
                color: Colors.themeMainColor
                size: parent.height / 4
                anchors.centerIn: parent
            }

            TrText {
                anchors.top: bottomLeftIcon.bottom; anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                font { family: Fonts.sfyFont; pixelSize: 12 }
                color: bottomLeftIcon.color
                content: QT_TR_NOOP("CALENDAR"); context: _trContext
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
                    var icon = { iconLib: bottomLeftIcon.lib, iconIcon: bottomLeftIcon.icon }
                    myHistory.displayNext(Qt.resolvedUrl("InnerView2.qml"), icon, "Calendar")
                }
            }
        }
    }
    Item {
        id: it4
        anchors.fill: parent
    }
}
