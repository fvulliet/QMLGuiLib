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

    LayoutItemSample {
        id: it1
    }
    LayoutItemSample {
        id: it2
    }
    LayoutItemSample {
        id: it3
    }
    LayoutItemSample {
        id: it4
    }
}
