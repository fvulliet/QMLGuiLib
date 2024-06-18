import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property string iconLib
    property string iconId
    property string font: Fonts.sfyFont
    property string contentColor: Colors.themeMainColor
    property alias text: title.content
    property alias trContext: title.context
    property alias scale: icon.scale
    property int maxTextSize: 16
    property int maxTextWidth: parent.width

    // signals
    signal textSizeAdjusted(int size)

    // inner components
    Item {
        anchors.fill: parent

        Column {
            anchors.fill: parent

            Item {
                height: parent.height * 2/3; width: parent.width

                FontIcon {
                    id: icon

                    anchors {
                        bottom: parent.bottom; bottomMargin: parent.height/10
                        horizontalCenter: parent.horizontalCenter
                    }
                    lib: iconLib; icon: iconId
                    color: contentColor
                    size: parent.height * 2/3; scale: 1
                }
            }
            Item {
                height: parent.height/3; width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter

                TrText {
                    id: title

                    function adjust() {
                        if ( (maxTextWidth > 0)
                                && (contentWidth > 0)
                                && (contentWidth >= maxTextWidth)) {
                            text = text.replace(/ ([^ ]*)$/, "\n"+'$1')
                            resize()
                        }
                    }
                    function resize() {
                        var adjusted = 0
                        while ( (contentWidth >= maxTextWidth)
                               && (title.font.pointSize > 0)) {
                            title.font.pointSize -= 1
                            adjusted = 1
                        }
                        if (adjusted !== 0) {
                            textSizeAdjusted(title.font.pointSize)
                        }
                    }

                    anchors {
                        top: parent.top; topMargin: parent.height/10
                        horizontalCenter: parent.horizontalCenter
                    }
                    font {
                        family: root.font
                        pointSize: Utils.limitMax(parent.height/4, maxTextSize)
                    }
                    horizontalAlignment: Text.AlignHCenter
                    color: Colors.skinFrameTXT

                    onTextChanged: adjust()
                    Component.onCompleted: adjust()
                }
            }
        }
    }
}

