import QtQuick 2.9
import GuiLib 1.0

Page {
    id: root

    anchors.fill: parent

    property bool completed: false
    property ListModel items: ListModel {}

    Component.onCompleted: {
        items.append({ "layoutItem": it1 });
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

    LayoutItemSample {
        id: it1
    }
}
