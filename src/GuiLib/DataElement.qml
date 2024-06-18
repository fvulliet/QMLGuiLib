import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property bool capitalized: true
    property alias title: titleText.text
    property alias titlePixelSize: titleText.font.pixelSize
    property alias titleHeight: titleItem.height
    property alias titleColor: titleText.color
    property alias content: contentItem.customItem
    property bool centered: true
    property string ctrlFont: Fonts.sfyFont

    // Item's properties
    height: childrenRect.height

    // inner components
    Item {
        id: titleItem

        width: parent.width; height: 20

        Text {
            id: titleText

            font {
                family: ctrlFont;  pixelSize: 12; weight: Font.Bold
                capitalization: capitalized ? Font.AllUppercase : Font.MixedCase
            }
            color: Colors.skinFrameTXT
            anchors.centerIn: centered ? parent : undefined
        }
    }

    Item {
        id: contentItem

        property Item customItem

        anchors.top: titleItem.bottom
        visible: customItem ? true : false

        onCustomItemChanged: {
            if (customItem) {
                customItem.parent = contentItem
                contentItem.width = customItem.width
                contentItem.height = customItem.height
            }
        }
    }
}
