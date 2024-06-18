import QtQuick 2.9
import GuiLib 1.0


Page {
    id: root
    anchors.fill: parent

    property bool completed: false
    property ListModel items: ListModel {}
    property string _trContext: "DisplayLayoutViewMenu"

    Component.onCompleted: {
        items.append({ iconLib: Fonts.faSolid,
                         iconId: FontAwesomeSolid.Icon.Th,
                         text: "layout 1", trContext: _trContext,
                         url: Qt.resolvedUrl("LayoutGrid1View.qml")
                     });
        items.append({ iconLib: Fonts.faSolid,
                         iconId: FontAwesomeSolid.Icon.Th,
                         text: "layout 2", trContext: _trContext,
                         url: Qt.resolvedUrl("LayoutGrid2View.qml")
                     });
        items.append({ iconLib: Fonts.faSolid,
                         iconId: FontAwesomeSolid.Icon.Th,
                         text: "layout 3", trContext: _trContext,
                         url: Qt.resolvedUrl("Layout_3BlocksView.qml")
                     });
        items.append({ iconLib: Fonts.faSolid,
                         iconId: FontAwesomeSolid.Icon.Th,
                         text: "layout 4", trContext: _trContext,
                         url: Qt.resolvedUrl("LayoutGrid4View.qml")
                     });
        items.append({ iconLib: Fonts.faSolid,
                         iconId: FontAwesomeSolid.Icon.Th,
                         text: "layout 6", trContext: _trContext,
                         url: Qt.resolvedUrl("LayoutGrid6View.qml")
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
