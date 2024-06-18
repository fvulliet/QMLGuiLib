import QtQuick 2.9
import GuiLib 1.0

Item {
    anchors.fill: parent

    FontIcon {
        id: icn
        anchors.centerIn: parent
        lib: Fonts.faSolid; icon: "\uf0a6"
        color: Colors.themeMainColor
        size: parent.height / 2
    }
    Text {
        anchors.top: icn.bottom; anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        font {
            family: Fonts.sfyFont; pointSize: 14
        }
        color: Colors.themeMainColor
        text: "3"
    }
}
