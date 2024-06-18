import QtQuick 2.9

FontIcon {
    property real ratio: 2/3

    color: Colors.themeMainColor
    anchors.centerIn: parent
    size: Math.min(parent.width, parent.height) * ratio
    opacity: 0.05
}
