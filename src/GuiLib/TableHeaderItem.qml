import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property int minColWidth: 0
    /*!< colWidth Used by TableContentItem elements to store the max row width */
    /*!< it means the TableHeaderItem width must be the width of the widest TableContentItem */
    property int colWidth: 0
    property real fixedSize: -1
    property int textSize: height * 2 / 5
    property bool canSort: false /*!< Enable item sorting */
    property int sortOrder: Qt.AscendingOrder /*!< Current sort order */
    property bool isSortActive: false /*!< Sorting is currently active for this item */
    property alias textColor: title.color
    property alias textItem: title
    property alias font: title.font
    property alias text: title.content
    property alias trContext: title.context

    // private properties
    property real _sortedExtraWidth: canSort ? height : 0

    // signals
    signal clicked()

    // Item's properties
    height: parent.height
    width: fixedSize >= 0 ? fixedSize
                          : Math.max(minColWidth, colWidth, title.paintedWidth + _sortedExtraWidth)

    // inner components
    Item {
        id: titleCtnr

        height: parent.height; width: childrenRect.width
        anchors.centerIn: parent

        TrText {
            id: title

            anchors.centerIn: parent
            font {
                family: Fonts.sfyFont; pixelSize: textSize; bold: true
            }
        }
    }

    Item {
        height: parent.height
        width: _sortedExtraWidth
        anchors.left: titleCtnr.right

        FontIcon {
            id: sortIcon

            opacity: (canSort && isSortActive) ? 1 : 0
            visible: opacity !== 0
            lib: Fonts.faSolid
            icon: (sortOrder === Qt.AscendingOrder) ?
                      FontAwesomeSolid.Icon.SortUp : FontAwesomeSolid.Icon.SortDown
            size: parent.height / 2
            anchors.centerIn: parent
            color: title.color
            Behavior on opacity { NumberAnimation {} }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}

