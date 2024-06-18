import QtQuick 2.9

Row {
    id: root

    // public properties
    property alias lib: icon.lib
    property alias icon: icon.icon
    property color color: Colors.skinFrameTXT
    property alias title: titleText.text
    property alias text: dataText.text
    property string ctrlFont: Fonts.sfyFont
    property bool capitalized: true
    property int horizontalAlignment: Text.AlignLeft
    property bool animate: true
    property bool _showTitle: title.length > 0

    // Row's properties
    spacing: 5

    // inner components
    Item {
        height: parent.height; width: (parent.width-parent.spacing)/2

        FontIcon {
            id: icon

            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
            }
            color: root.color
            size: Math.min(parent.height*0.9, parent.width*0.9)
        }
    }
    Column {
        height: icon.height; width: (parent.width-parent.spacing)/2
        spacing: root.spacing
        anchors.verticalCenter: parent.verticalCenter

        Item {
            width: parent.width
            height: _showTitle ?(parent.height-parent.spacing)/3 : 0

            StandardText {
                id: titleText

                font {
                    family: ctrlFont; bold: true
                    pixelSize: parent.height
                    capitalization: capitalized ? Font.AllUppercase : Font.MixedCase
                }
                color: root.color
                horizontalAlignment: root.horizontalAlignment
                verticalAlignment: Text.AlignBottom
            }
        }
        Item {
            width: parent.width
            height: _showTitle ? (parent.height-parent.spacing)*2/3 : parent.height

            StandardText {
                id: dataText

                font {
                    family: ctrlFont
                    pixelSize: parent.height
                    capitalization: titleText.font.capitalization
                }
                color: root.color
                horizontalAlignment: _showTitle ? root.horizontalAlignment : Text.AlignLeft
                verticalAlignment: _showTitle ? Text.AlignTop : Text.AlignVCenter

                onTextChanged: {
                    if (animate)
                        textAnim.restart()
                }

                PropertyAnimation on opacity {
                    id: textAnim
                    from: 0; to: 1; easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
