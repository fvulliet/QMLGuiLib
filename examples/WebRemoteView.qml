import QtQuick 2.9
import GuiLib 1.0 as Gui

Item {
    id: root

    property string _trContext: "WebRemoteView"

    DemoHeader {
        id: header

        width: parent.width; height: parent.height / 15
        anchors.top: parent.top
        title: QT_TR_NOOP("WEB REMOTE"); trContext: _trContext
    }

    Rectangle {
        anchors {
            top: header.bottom; bottom: parent.bottom
        }
        width: parent.width
        color: "black"//Gui.Colors.skinFrameBGD

        Gui.Carousel {
            id: myCarousel

            anchors {
                fill: parent; margins: 50
            }
            color: parent.color
            withViewer: false
            Component.onCompleted: {
                append(Qt.resolvedUrl("WebRemote_1.qml"), "WebRemote_1")
                append(Qt.resolvedUrl("WebRemote_2.qml"), "WebRemote_2")
                append(Qt.resolvedUrl("WebRemote_3.qml"), "WebRemote_3")
                append(Qt.resolvedUrl("WebRemote_4.qml"), "WebRemote_4")
                currentPanelIndex = 0
            }
            onCurrentPanelIndexChanged: {
                currentPanel.model = wrList
            }
        }
    }

    ListModel {
        id: wrList
        Component.onCompleted: {
            append({ name: "Web remote 1", position: 0, angle: 0 })
            append({ name: "Web remote 2", position: 25, angle: 15 })
            append({ name: "Web remote 3", position: 50, angle: 30 })
            append({ name: "Web remote 4", position: 75, angle: 45 })
            append({ name: "Web remote 5", position: 42, angle: 0 })
            append({ name: "Web remote 6", position: 42, angle: 42 })
            append({ name: "Web remote 7", position: 100, angle: 90 })
        }
    }
}

