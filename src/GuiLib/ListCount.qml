import QtQuick 2.0
import GuiLib 1.0

Item {
    id: root

    property bool filtered: false
    property int value
    property int borderWidth: 1
    property color borderColor: Colors.skinFrameTXT
    property alias textColor: countText.color
    property alias textSize: countText.font.pixelSize
    property alias filteredIconBkgd: filteredIcon.color

    Rectangle {
        id: rect

        width: parent.width - 2 // 1 pixel margin
        height: width
        anchors.centerIn: parent
        color: "transparent"
        radius: width/2
        border {
            width: borderWidth; color: borderColor
        }

        Item {
            id: centeredSquare

            width: 2 * Math.sqrt(Math.pow((parent.radius-parent.border.width),2)/2)
            height: width
            anchors.centerIn: parent

            StandardText {
                id: countText

                text: value
                font.pixelSize: value < 100 ?
                                    parent.height*2/3 : value < 1000 ?
                                        parent.height*2/3.25 : parent.height*2/3.5
            }
        }

        Rectangle {
            id: filteredIcon

            width: parent.width/2; height: width
            anchors {
                left: centeredSquare.right; leftMargin: - width/2
                top: centeredSquare.top; topMargin: - height/2
            }
            color: Colors.skinFrameFGD
            radius: width/2
            visible: filtered

            FontIcon {
                anchors.centerIn: parent
                lib: Fonts.faSolid
                icon: FontAwesomeSolid.Icon.Search
                color: borderColor
                size: parent.height*0.95
            }
        }
    }
}
