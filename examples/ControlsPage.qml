import QtQuick 2.9
import GuiLib 1.0 as Gui

Gui.Page {
    id: root

    signal showPopupMessage(int type, string msg, var btns)

    Connections {
        target: myCarousel.currentPanel
        ignoreUnknownSignals: true
        function onShowPopupMessage(type, msg, btns) {
            showPopupMessage(type, msg, btns)
        }
    }

    Gui.Carousel {
        id: myCarousel

        anchors.fill: parent
        color: Gui.Colors.skinFrameFGD
        withViewer: true
        Component.onCompleted: {
            append(Qt.resolvedUrl("ControlsView2.qml"), "Controls2")
            append(Qt.resolvedUrl("ControlsView3.qml"), "Controls3")
            append(Qt.resolvedUrl("ControlsView4.qml"), "Controls4")
            append(Qt.resolvedUrl("ControlsView5.qml"), "Controls5")
            append(Qt.resolvedUrl("GaugeView.qml"), "Gauge")
            append(Qt.resolvedUrl("ProgressView.qml"), "Progress")
            append(Qt.resolvedUrl("DialView.qml"), "Dial")
            append(Qt.resolvedUrl("TypoView.qml"), "Typo")
            append(Qt.resolvedUrl("WidgetsView.qml"), "Widgets")
            append(Qt.resolvedUrl("PopupView.qml"), "Popup")
            append(Qt.resolvedUrl("DragDropView.qml"), "Drag'n'Drop")
            append(Qt.resolvedUrl("ClockView.qml"), "Clock")
            append(Qt.resolvedUrl("DateTimePickerView.qml"), "Controls6")
            append(Qt.resolvedUrl("SchedulersView.qml"), "Schedulers")
            append(Qt.resolvedUrl("IconLabView.qml"), "Icons")
            append(Qt.resolvedUrl("ColorsView.qml"), "Colors")
            currentPanelIndex = 0
        }
    }
}

