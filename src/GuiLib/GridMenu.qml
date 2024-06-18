import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property ListModel model
    property ListModel items: ListModel {}
    property bool completed: false
    property bool showNav: false
    property alias resizeCells: grid.resizeCells
    property string ctrlFont: Fonts.sfyFont

    // signals
    signal cellClicked(int cellIndex)

    // functions
    function forwardSignal(cellId) {
        cellClicked(cellId)
    }

    onModelChanged: {
        if (model.count > 0) {
            var component
            var cell
            for (var i=0 ; i<model.count; ++i) {
                component = Qt.createComponent("GridMenuCell.qml");
                cell = component.createObject(root, {
                    "cellId": i,
                    "iconLib": model.get(i).iconLib,
                    "iconId": model.get(i).iconId,
                    "text": model.get(i).text,
                    "showNav": showNav,
                    "font": ctrlFont,
                    "trContext": model.get(i).trContext});
                if (cell !== null) {
                    cell.clicked.connect(forwardSignal)
                    items.append({ "layoutItem": cell });
                }
            }
            completed = true
        }
    }

    onCompletedChanged: {
        if (completed) {
            grid.model = items
        }
    }

    // inner components
    LayoutGrid {
        id: grid
        anchors.fill: parent
    }
}
