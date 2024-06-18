import QtQuick 2.9
import GuiLib 1.0

FocusScope {
    id: root

    // public properties
    property string unit
    property bool hasIcon: true /*!< never display the icon */
    property bool alwaysShowIcon: false /*!< always display the left icon */
    property bool alwaysShowPlaceholder: true /*!< still show placeholder when text is entered */
    property string ctrlFont: Fonts.sfyFont
    property color notFocusedColor: Colors.skinFrameTXT
    property color focusedColor: Colors.themeMainColor
    property color bkgdColor: "transparent"
    property alias placeholderText: placeholder.content
    property alias placeholderTrContext: placeholder.context
    property alias icon: fontIcon
    property alias _textInput: textInput /*!< complete access to the internal textInput item */
    property alias acceptableInput: textInput.acceptableInput
    property alias echoMode: textInput.echoMode
    property alias inputMask: textInput.inputMask
    property alias inputMethodHints: textInput.inputMethodHints
    property alias maximumLength: textInput.maximumLength
    property alias readOnly: textInput.readOnly
    property alias text: textInput.text
    property alias textColor: textInput.color
    property alias validator: textInput.validator
    property alias cursorPosition: textInput.cursorPosition
    property alias textPixelSize: textInput.font.pixelSize
    property alias textFontCapital: textInput.font.capitalization

    // for unit tests purpose
    property alias iconOpacity: icon.opacity
    property alias iconType: fontIcon.icon

    // private properties
    property bool _isValidator: Qt.isQtObject(root.validator)
    property int _lineHeight: 2
    property real _textRatio: 2/3
    property real _placeHolderRatio: 3/4
    property bool _isTooLong: textInput.contentWidth > textInput.width

    // signals
    signal textHasChanged()
    signal editingFinished()
    signal focusTaken()
    signal focusReleased()
    signal textValidated()

    // FocusScope's properties
    activeFocusOnTab: true
    states: [
        State {
            name: "WRITING_PLACEHOLDER"
            when: {
                if (!root.alwaysShowPlaceholder)
                    return false

                if (root.text.length !== 0)
                    return true

                if (activeFocus)
                    return true

                return false
            }

            PropertyChanges {
                target: placeholder
                opacity: 0.5
                height: (textInput.height-sep.height) * 1/3
                anchors.leftMargin: 0
            }
            PropertyChanges {
                target: sep
                height: placeholderText.length > 0 ? 4 : 0
            }
            PropertyChanges {
                target: root
                _placeHolderRatio: 1
            }
            AnchorChanges {
                target: placeholder
                anchors.top: textInput.top
                anchors.verticalCenter: undefined
            }
        },
        State {
            name: "WRITING"
            when: !root.alwaysShowPlaceholder && (root.text.length !== 0)

            PropertyChanges {
                target: placeholder
                opacity: 0
            }
        }
    ]
    transitions: Transition {
        enabled: root.text.length === 0
        PropertyAnimation {
            properties: "opacity, height, anchors.leftMargin, _placeHolderRatio"
            easing.type: Easing.InOutQuad
        }
        AnchorAnimation {
            easing.type: Easing.InOutQuad
        }
    }

    onActiveFocusChanged: {
        if (activeFocus)
            focusTaken()
        else {
            focusReleased()
            cursorPosition = 0
        }
    }

    // inner components
    TextInput {
        id: textInput

        property real textHeightRatio_patch: 1

        height: parent.height - _lineHeight
        width: parent.width - iconCtn.width - unitCtn.width - truncText.width
        anchors {
            left: parent.left; right: truncate.left
            bottom: line.top
        }
        focus: true
        clip: true
        color: Colors.skinFrameTXT /*!< text color */
        selectionColor: color
        selectedTextColor: Colors.skinFrameFGD
        selectByMouse: true
        font { family: root.ctrlFont
            pixelSize: (height-sep.height) * _textRatio * textInput.textHeightRatio_patch
        }
        verticalAlignment: TextInput.AlignBottom
        cursorPosition: 0

        onEditingFinished: root.editingFinished()
        onTextChanged: {
            root.textHasChanged()
            if (readOnly)
                cursorPosition = 0
        }
        Component.onCompleted: {
            // this patch needs to be applied, otherwise the highlight is ugly with sfyFontDinReg
            if (font.family === Fonts.sfyFontDinReg || font.family === Fonts.somfySansRegular)
                textHeightRatio_patch = 0.85
        }
        Keys.onPressed: {
            if ((event.key === Qt.Key_Return) || (event.key === Qt.Key_Enter)) {
                root.textValidated()
            }
        }

        TrText {
            id: placeholder

            height: parent.height * _textRatio * _placeHolderRatio
            z: textInput.z + 1
            anchors {
                verticalCenter: textInput.verticalCenter
                left: textInput.left; leftMargin: 3
            }
            opacity: 0.7
            color: parent.color
            font { family: ctrlFont; pixelSize: placeholder.height }
        }

        Item {
            id: sep

            anchors {
                top: placeholder.bottom
                left: placeholder.left
            }
            width: placeholder.width; height: 0
            visible: height > 0
        }
    }

    Rectangle {
        id: truncate

        color: bkgdColor
        width: truncText.contentWidth
        height: root.height - _lineHeight
        anchors {
            right: unitCtn.left; bottom: line.top
        }
        z: textInput.z + 1
        visible: _isTooLong && !activeFocus

        Text {
            id: truncText

            visible: parent.width > 0
            color: textInput.color
            font {
                family: root.ctrlFont;
                pixelSize: textInput.height * _textRatio
            }
            anchors.bottom: parent.bottom; anchors.left: parent.left
            text: ".."
        }
    }

    Item {
        id: unitCtn

        height: root.height - _lineHeight;
        width: unit !== "" ? unitText.contentWidth : 0
        visible: width > 0
        anchors {
            right: iconCtn.left; bottom: line.top
        }

        Text {
            id: unitText

            visible: parent.width > 0
            color: textInput.color
            font { family: root.ctrlFont;
                pixelSize: textInput.height * (_textRatio * 0.8); italic: true}
            anchors {
                bottom: parent.bottom
                left: parent.left
            }
            text: unit
        }
    }

    Item {
        id: iconCtn

        width: hasIcon ? root.height*2/3 : 0; height: root.height - _lineHeight
        visible: width > 0
        anchors {
            right: root.right; bottom: line.top
        }
        z: textInput.z + 1

        Item {
            id: icon

            height: 0; width: height
            Behavior on height { NumberAnimation { duration : 250 } }
            anchors {
                bottom: parent.bottom; left: parent.left
            }
            opacity: 0
            Behavior on opacity { NumberAnimation { duration : 250 } }
            visible: !readOnly && hasIcon && (opacity > 0)

            states: [
                State {
                    name: "" /* create default state to work around behavior
                                conflicts with state changes */
                    PropertyChanges {
                        target: icon
                        height: 0
                        opacity: 0
                    }
                },
                State {
                    name: "EDIT"
                    when: root.activeFocus && !root._isValidator
                    extend: "SHOWN"

                    PropertyChanges {
                        target: fontIcon
                        color: focusedColor
                    }
                },
                State {
                    name: "EDIT_VALIDATOR_OK"
                    when: root.activeFocus && root._isValidator && root.acceptableInput
                    extend: "SHOWN"

                    PropertyChanges {
                        target: fontIcon
                        color: Colors.themeSignalOK
                    }
                },
                State {
                    name: "EDIT_VALIDATOR_KO"
                    when: root.activeFocus && root._isValidator && !root.acceptableInput
                    extend: "SHOWN"

                    PropertyChanges {
                        target: fontIcon
                        color: Colors.themeSignalKO
                    }
                },
                State {
                    name: "INVALID"
                    when: !root.activeFocus && root._isValidator && !root.acceptableInput
                    extend: "SHOWN"

                    PropertyChanges {
                        target: fontIcon
                        icon: FontAwesomeSolid.Icon.Remove
                        color: Colors.themeSignalKO
                    }
                },
                State { /* must be last since it will match before others if
                           alwaysShowIcon is set */
                    name: "SHOWN"
                    when: root.alwaysShowIcon
                    PropertyChanges {
                        target: icon
                        height: iconCtn.height * 2/3
                        opacity: 1
                    }
                }
            ]

            FontIcon {
                id: fontIcon

                lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.PencilAlt
                color: notFocusedColor
                size: parent.height
                anchors.centerIn: parent
            }
        }
    }

    Rectangle {
        id: line

        width: root.width - iconCtn.width - unitCtn.width; height: _lineHeight
        anchors {
            left: parent.left; bottom: root.bottom
        }
        color: fontIcon.color
    }
}
