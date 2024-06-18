import QtQuick 2.9
import GuiLib 1.0 as Gui

Gui.Page {
    id: root

    signal showPopupMessage(int type, string msg, var btns)

    Connections {
        target: myCarousel.currentPanel
        ignoreUnknownSignals: true
        onShowPopupMessage: showPopupMessage(type, msg, btns)
    }

    Gui.Carousel {
        id: myCarousel

        anchors.fill: parent
        color: Gui.Colors.skinFrameFGD
        withViewer: true
        Component.onCompleted: {
            append(Qt.resolvedUrl("ControlWidgetsView.qml"), "Control widgets")
            append(Qt.resolvedUrl("MagnifiedGridView.qml"), "Magnifying")
            append(Qt.resolvedUrl("WebRemoteView.qml"), "WebRemote")
            append(Qt.resolvedUrl("ConnectorsView.qml"), "Connectors")
            currentPanelIndex = 0
        }
    }
}

