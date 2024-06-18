import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property Item payload
    property Item scope
    property alias iconLib: iconTitle.iconLib
    property alias iconId: iconTitle.iconId
    property alias font: iconTitle.font
    property alias contentColor: iconTitle.contentColor
    property alias title: iconTitle.text
    property alias trContext: iconTitle.trContext
    property alias showNav: nav.visible
    property alias titleRatio: layout.titleRatio
    property alias leftColumnRatio: layout.leftColumnRatio

    // signals
    signal back()

    // inner components
    Layout_3Blocks {
        id: layout

        anchors.fill: parent

        topLeftItem: Item {
            anchors.fill: parent

            IconTitle {
                id: iconTitle
                anchors.fill: parent
            }
            NavIcon {
                id: nav
                isNext: false
                visible: showNav
                anchors { bottom: parent.bottom; right: parent.right }
                onClicked: back()
            }
        }
        bottomLeftItem: scope
        rightItem: payload
    }
}
