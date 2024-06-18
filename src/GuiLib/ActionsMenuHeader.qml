import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property int maxIconSize: height * 0.9
    property alias lib: icon.lib
    property alias icon: icon.icon
    property alias text: title.text
    property alias ctrlFont: title.font.family
    property alias capitalization: title.font.capitalization
    property alias pixelSize: title.font.pixelSize
    property bool centered: true
    property string trContext // kept for backward compatibility

    function childrenWidth() {
        var w=0
        for (var child in children) {
            if (children[child].visible)
                w += children[child].width
        }
        return w
    }

    Component.onCompleted: {
        titleCtnr.width = width - childrenWidth()
    }

    // inner components
    FontIcon {
        id: icon

        anchors {
            left: parent.left; leftMargin: 3
            verticalCenter: parent.verticalCenter
        }
        size: Math.min(maxIconSize, parent.height * 0.9)
        color: Colors.themeMainColor
    }

    Item {
        id: titleCtnr

        height: parent.height; width: 0

        anchors {
            left: icon.right; leftMargin: Style.stdMargin
            horizontalCenter: centered ? parent.horizontalCenter : undefined
            verticalCenter: parent.verticalCenter
        }

        StandardText {
            id: title

            font.bold: true
            font.pixelSize: Math.min(14, parent.height * 0.9)
            horizontalAlignment: centered ? Text.AlignHCenter : Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle {
        id: separator

        width: parent.width; height: 1
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
        }
        color: Colors.skinFrameTXT
    }
}
