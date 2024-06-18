import QtQuick 2.9
import QtQuick.Controls
import GuiLib 1.0

FocusScope {
    id: root

    // public properties
    property alias placeholderText: placeholderTxt.content
    property alias placeholderTrContext: placeholderTxt.context
    property alias text: txtArea.text
    property alias textColor: txtArea.color
    property alias textPixelSize: txtArea.font.pixelSize
    property alias background: txtArea.background
    property alias cursorPosition: txtArea.cursorPosition
    property string ctrlFont: Fonts.sfyFont
    property color notFocusedColor: Colors.skinFrameTXT
    property color focusedColor: Colors.themeMainColor
    property alias bkgdColor: border.color

    // signals
    signal textHasChanged()
    signal focusTaken()
    signal focusReleased()
    signal editingFinished()

    // FocusScope's properties
    activeFocusOnTab: true
    states: [
        State {
            when: root.activeFocus

            PropertyChanges {
                target: fontIcon
                size: textPixelSize
            }
            PropertyChanges {
                target: placeholderCtnr
                height: textPixelSize/2
            }
            PropertyChanges {
                target: placeholderTxt
                opacity: 0.5
                anchors.leftMargin: 0
            }
        },
        State {
            when: text.length !== 0

            PropertyChanges {
                target: placeholderCtnr
                height: textPixelSize/2
            }
            PropertyChanges {
                target: placeholderTxt
                opacity: 0.5
                anchors.leftMargin: 0
            }
        }

    ]
    transitions: [
        Transition {
            PropertyAnimation {
                properties: "size, opacity, height, anchors.leftMargin"
                easing.type: Easing.InOutQuad
            }
        }
    ]

    onActiveFocusChanged: {
        if (activeFocus)
            focusTaken()
        else {
            focusReleased()
            cursorPosition = 0
        }
    }

    // inner components
    Rectangle {
        id: border

        anchors.fill: parent
        radius: 3
        border {
            width: 2
            color: fontIcon.color
        }

        Item {
            id: mainCtnr

            anchors {
                fill: parent
                margins: 5
            }

            Row {
                id: header

                width: parent.width; height: textPixelSize

                Item {
                    id: placeholderCtnr

                    height: textPixelSize; width: parent.width-textPixelSize

                    TrText {
                        id: placeholderTxt

                        height: parent.height
                        anchors {
                            verticalCenter: parent.verticalCenter
                            left: parent.left; leftMargin: 3
                        }
                        opacity: 0.7
                        color: textColor
                        font { family: ctrlFont; pixelSize: placeholderCtnr.height }
                    }
                }
                Item {
                    id: iconCtnr

                    height: textPixelSize; width: height

                    FontIcon {
                        id: fontIcon

                        lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.Pencil
                        color: root.activeFocus ? focusedColor : notFocusedColor
                        size: 1
                        visible: size > 1
                        anchors.bottom: parent.bottom
                    }
                }
            }

            Flickable {
                id: flickable

                anchors.top: header.bottom
                width: parent.width; height: parent.height - header.height
                flickableDirection: Flickable.VerticalFlick
                interactive: contentHeight > height
                clip: interactive
                boundsBehavior: Flickable.StopAtBounds

                TextArea.flickable: TextArea {
                    id: txtArea

                    focus: true
                    font.family: ctrlFont
                    font.pixelSize: 12
                    wrapMode: TextArea.Wrap
                    padding: 0
                    selectByMouse: true
                    selectionColor: textColor
                    selectedTextColor: Colors.skinFrameFGD
                    inputMethodHints: Qt.ImhNone

                    onTextChanged: root.textHasChanged()
                    onEditingFinished: root.editingFinished()
                }
            }
        }
    }
}
