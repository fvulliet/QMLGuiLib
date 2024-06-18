import QtQuick 2.9
import GuiLib 1.0


Page {
    id: root
    anchors.fill: parent

    property bool completed: false
    property ListModel items: ListModel {}
    property string _trContext: "DisplayListViewMenu"

    Component.onCompleted: {
        items.append({ iconLib: Fonts.faSolid,
                         iconId: FontAwesomeSolid.Icon.Fullscreen,
                         text: "full screen", trContext: _trContext,
                         url: Qt.resolvedUrl("DisplayListView.qml")
                     });
        items.append({ iconLib: Fonts.faSolid,
                         iconId: FontAwesomeSolid.Icon.ListAlt,
                         text: "integrated", trContext: _trContext,
                         url: Qt.resolvedUrl("InlineListView.qml")
                     });
        items.append({ iconLib: Fonts.faSolid,
                         iconId: FontAwesomeSolid.Icon.ListAlt,
                         text: "smart", trContext: _trContext,
                         url: Qt.resolvedUrl("SmartListView.qml")
                     });
        completed = true
    }

    onCompletedChanged: {
        if (completed)
            grid.model = items
    }

    GridMenu {
        id: grid
        anchors.fill: parent
        showNav: true

        onCellClicked: {
            if (cellIndex >= grid.model.count)
                return
            myHistory.displayNext(grid.model.get(cellIndex).url,
                                { iconLib: grid.model.get(cellIndex).iconLib,
                                    iconIcon: grid.model.get(cellIndex).iconId },
                                grid.model.get(cellIndex).name)
        }
    }
}
