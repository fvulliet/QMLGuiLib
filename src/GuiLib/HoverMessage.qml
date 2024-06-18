import QtQuick 2.9
import GuiLib 1.0

Rectangle {
    id: root

    property alias message: messageTxt.text
    property int maxWHratio: 6

    Behavior on opacity { NumberAnimation {} }
    visible: opacity > 0
    color: Colors.skinFrameBGD
    border {
        width: 1; color: Colors.themeMainColor
    }
    radius: height/2
    width: childrenRect.width

    Row {
        height: parent.height; width: childrenRect.width

        Rectangle {
            id: iconCtnr

            height: parent.height; width: height
            color: Colors.themeMainColor
            radius: height/2

            FontIcon {
                anchors.centerIn: parent
                color: Colors.skinFrameFGD
                lib: Fonts.faSolid
                icon: FontAwesomeSolid.Icon.WarningSign
                size: parent.height/2
            }
        }
        Item {
            height: parent.height; width: Style.stdMargin
        }
        Item {
            height: parent.height; width: childrenRect.width

            Text {
                id: messageTxt

                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font { family: Fonts.sfyFont; pixelSize: Math.min(16, parent.height/3) }
                color: Colors.skinFrameTXT
            }
        }
        Item {
            height: parent.height; width: Style.stdMargin
        }
    }
}
