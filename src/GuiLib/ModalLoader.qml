import QtQuick 2.9
import GuiLib 1.0

Item {
    // public properties
    property alias source: modal.source
    property alias sourceComponent: modal.sourceComponent
    property alias active: modal.active
    property alias item: modal.item
    property bool animate: true
    property alias status: modal.status

    // signals
    signal modalLoaded()
    signal modalUnloaded()

    // functions
    function close() {
        itemCollapsing.start()
    }

    function load() {
        itemExpansion.start()
        modalLoaded()
    }

    onSourceChanged: {
        if (source !== "")
            load()
    }

    onSourceComponentChanged: {
        if (source !== undefined)
            load()
    }

    // inner components
    Loader {
        id: modal
        anchors.fill: parent
    }

    ParallelAnimation {
        id: itemExpansion

        PropertyAnimation {
            target: modal.item
            property: "scale"
            from: 0.0; to: 1.0
            duration: animate ? 250 : 0
        }
        PropertyAnimation {
            target: modal.item
            property: "opacity"
            from: 0.0; to: 1.0
            duration: animate ? 250 : 0
        }
    }

    ParallelAnimation {
        id: itemCollapsing

        PropertyAnimation {
            target: modal.item
            property: "scale"
            from: 1.0; to: 0.0
            duration: animate ? 250 : 0
        }
        PropertyAnimation {
            target: modal.item
            property: "opacity"
            from: 1.0; to: 0.0
            duration: animate ? 200 : 0
        }
        onRunningChanged: {
            if (!running) {
                source = ""
                sourceComponent = undefined
                modalUnloaded()
            }
        }
    }
}
