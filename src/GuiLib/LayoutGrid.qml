import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property bool resizeCells: true
    property alias gap: grid.gap
    property alias model: grid.model

    onWidthChanged: grid.resize()
    onHeightChanged: grid.resize()

    // inner components
    GridView {
        id: grid

        property int gap: 10

        cellHeight: 0; cellWidth: 0
        interactive: false
        anchors.fill: parent

        function resize() {
            if (!model)
                return

            switch (model.count) {
            case 1:
                if (resizeCells)
                    cellWidth = parent.width
                else
                    cellWidth = parent.width / 4
                break;
            case 2:
            case 3:
            case 4:
                if (resizeCells)
                    cellWidth = parent.width / 2
                else
                    cellWidth = parent.width / 4
                break;
            case 5:
            case 6:
                cellWidth = parent.width / 3
                break;
            case 7:
            case 8:
                cellWidth = parent.width / 4
                break;
            default:
                cellWidth = 0
            }

            switch (model.count) {
            case 1:
            case 2:
                if (resizeCells)
                    cellHeight = parent.height
                else
                    cellHeight = parent.height / 2
                break;
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
                cellHeight = parent.height / 2
                break;
            default:
                cellHeight = 0
            }
        }

        onModelChanged: resize()

        delegate: Item {
            id: deleg

            property Item customItem

            width: GridView.view.cellWidth; height: GridView.view.cellHeight
            customItem: layoutItem
            onCustomItemChanged: {
                if (customItem) {
                    customItem.parent = deleg
                    customItem.anchors.fill = deleg
                    customItem.anchors.margins = grid.gap/2
                }
            }
        }
    }
}
