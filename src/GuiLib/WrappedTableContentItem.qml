import QtQuick 2.2
import GuiLib 1.0

Item {
    id: root

    // public properties
    property var header
    property alias textColor: txt.color
    property string text
    property alias font: txt.font
    property alias textItem: txt
    property alias wrapMode: txt.wrapMode
    property int textSize: height * 2 / 5
    property int xOffset: 0
    property string additionalText
    property real ratio: 0.6

    // private properties
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
    x: header ? header.parent.x + header.x + xOffset : 0
    implicitWidth: txtCtnr.width // if width is not specified

    onImplicitWidthChanged: updateHeaderWidth()

    // inner components
    Item {
        id: txtCtnr

        height: parent.height
        width: _fixedSize ? header.fixedSize : txtCtnr.implicitWidth
        anchors.horizontalCenter: parent.horizontalCenter

        TextInput {
            id: txt

            height: parent.height
            width: _fixedSize ? parent.width : undefined
            color: Colors.skinFrameTXT
            font {
                family: Style.appFont
                pixelSize: textSize
            }
            verticalAlignment: Text.AlignVCenter
            text: root.text
            readOnly: true
            cursorVisible: false
            selectByMouse: false
        }
    }
}

