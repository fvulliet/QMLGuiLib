
import QtQuick 2.9
import GuiLib 1.0

Page {
    id: settingsLayoutView

    anchors.fill: parent

    Layout_3Blocks {
        anchors.fill: parent

        topLeftItem: LayoutItemSample {
            anchors.fill: parent
        }

        bottomLeftItem: LayoutItemSample {
            anchors.fill: parent
        }

        rightItem: LayoutItemSample {
            anchors.fill: parent
        }
    }
}
