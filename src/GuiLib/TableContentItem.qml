import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property var header
    property alias textColor: txt.color
    property alias text: txt.text
    property alias font: txt.font
    property alias textItem: txt
    property alias iconLib: icon.lib
    property alias iconId: icon.icon
    property alias iconColor: icon.color
    property int textSize: height * 2 / 5
    property int xOffset: 0
    property string additionalText
    property real ratio: 0.6

    // private properties
    property bool _withIcon: iconLib && iconId
    property bool _fixedSize: header.fixedSize > 0

    // functions
    /*  brief update TableHeaderItem width according to the current width;
    *   if a max allowed width is specified and reached, then the TableHeaderItem
    *   takes this maxWidth value
    */
    function updateHeaderWidth() {
        // FIXME: recalc size when removing items (have some refcount on same-sized items)
        if (header && !_fixedSize && (header.colWidth < root.implicitWidth))
            header.colWidth = root.implicitWidth
    }

    // Item's properties
    width: header ? header.width : 0; height: parent.height
    anchors.verticalCenter: parent.verticalCenter
    x: header ? header.parent.x + header.x + xOffset : 0
    implicitWidth: rowCtnr.width // if width is not specified

    onImplicitWidthChanged: updateHeaderWidth()

    // inner components
    Row {
        id: rowCtnr

        height: parent.height
        width: _fixedSize ? childrenRect.width : iconCtnr.width + txtCtnr.implicitWidth
        anchors.horizontalCenter: parent.horizontalCenter

        Item {
            id: iconCtnr

            height: parent.height; width: _withIcon ? height : 0
            visible: width > 0

            FontIcon {
                id: icon

                size: parent.height / 2
                anchors.centerIn: parent
                color: Colors.skinFrameTXT
            }
        }
        Column {
            id: txtCtnr

            height: parent.height
            width: text.length > 0 ? _fixedSize ? root.width - iconCtnr.width :
                                                  Math.max(mainTextCtnr.width, additionalTextCtnr.width) : 0
            visible: width > 0
            spacing: 2

            Item {
                id: mainTextCtnr

                height: additionalText.length > 0 ? (parent.height-parent.spacing)*ratio : parent.height
                width: _fixedSize ? parent.width : txt.width
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: txt

                    height: parent.height
                    width: _fixedSize ? parent.width : undefined
                    color: Colors.skinFrameTXT
                    font {
                        family: Fonts.sfyFont
                        pixelSize: textSize
                    }
                    minimumPixelSize: 5
                    fontSizeMode: _fixedSize ? Text.Fit : Text.FixedSize
                    verticalAlignment: _fixedSize ?
                                           additionalText.length > 0 ? Text.AlignBottom : Text.AlignVCenter : -1
                    horizontalAlignment: _fixedSize ? Text.AlignHCenter : -1
                }
            }
            Item {
                id: additionalTextCtnr

                height: additionalText.length > 0 ? (parent.height-parent.spacing)*(1-ratio) : 0
                visible: height > 0
                width: _fixedSize ? parent.width : addTxt.width
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: addTxt

                    height: parent.height
                    width: _fixedSize ? parent.width : undefined
                    color: Colors.skinFrameTXT
                    font {
                        pixelSize: txt.font.pixelSize*0.8
                        family: txt.font.family
                        italic: true
                    }
                    text: additionalText
                    minimumPixelSize: 5
                    fontSizeMode: _fixedSize ? Text.Fit : Text.FixedSize
                    verticalAlignment: _fixedSize ? Text.AlignTop : -1
                    horizontalAlignment: _fixedSize ? Text.AlignHCenter : -1
                }
            }
        }
    }
}

