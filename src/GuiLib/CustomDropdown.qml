import QtQuick 2.9
import Qt5Compat.GraphicalEffects 1.0 as Effects
import GuiLib 1.0

FocusScope {
    id: root

    // public properties
    property bool readOnly
    property int maxVisibleItems: -1
    property string trContext: ""
    property string ctrlFont: Fonts.sfyFont
    property int unrollShift: 0
    property bool needToBeReset: false
    property alias elements: elements
    property alias model: elements.model
    property alias delegate: elements.delegate
    property alias validator: txtInput.validator
    property alias acceptableInput: txtInput.acceptableInput
    property alias currentIndex: elements.currentIndex
    property alias text: txtInput.text
    property alias textColor: txtInput.textColor
    property alias bkgdColor: txtInput.bkgdColor
    property alias textPixelSize: txtInput.textPixelSize
    property alias notFocusedColor: txtInput.notFocusedColor
    property alias focusedColor: txtInput.focusedColor
    property alias count: elements.count

    // signals
    signal elementSelected()
    signal elementUnselected()

    // functions
    function resetDropdown() {
        elements.unselect()
    }

    // FocusScope properties
    state: "HIDDEN"
    states: State {
        name: "VISIBLE"
        PropertyChanges {
            target: elementsCtnr
            height: maxHeight
        }
        PropertyChanges {
            target: elementsCtnr
            opacity: 1
        }
    }
    transitions: Transition {
        NumberAnimation {
            properties: "height, opacity"
            easing.type: Easing.InOutQuad
        }
    }

    Component.onCompleted: Utils.bound(unrollShift, -1, maxVisibleItems)
    onUnrollShiftChanged: Utils.bound(unrollShift, -1, maxVisibleItems)
    onActiveFocusChanged: {
        if (!activeFocus && (state === "VISIBLE")) {
            state = "HIDDEN"
        }
    }
    onNeedToBeResetChanged: {
        if (needToBeReset) {
            resetDropdown()
            needToBeReset = false
        }
    }

    // inner components
    Item {
        anchors.fill: parent
        Keys.onPressed: {
            if (event.key === Qt.Key_Escape) {
                if (root.state === "VISIBLE") {
                    root.state = "HIDDEN"
                }
            }
        }

        SfyTextInput {
            id: txtInput

            width: root.width - iconCtn.width - separator.width
            height: iconCtn.height
            hasIcon: false
            focus: root.focus
            notFocusedColor: Colors.skinFrameTXT
            focusedColor: Colors.themeMainColor
            ctrlFont: root.ctrlFont

            onTextChanged: {
                if (root.state !== "VISIBLE" && text !== "")
                    root.state = "VISIBLE"
                else if (root.state === "VISIBLE" && text === "")
                    root.state = "HIDDEN"
            }
        }

        Item {
            id: iconCtn

            height: parent.height; width: height
            anchors {
                top: parent.top
                right: parent.right
            }

            FontIcon {
                id: fontIcon

                property real ratio: 1

                lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.CaretDown
                color: txtInput.icon.color
                size: parent.height * ratio
                anchors.centerIn: parent
            }
        }

        Rectangle {
            id: separator

            visible: !root.readOnly
            width: 1; height: parent.height
            anchors.left: txtInput.right
            color: Colors.skinFrameTXT
        }

        Item {
            id: elementsCtnr

            property alias maxHeight: elements.maxHeight

            width: parent.width; height: 0
            opacity: 0
            visible: height > 0
            z: root.z + 1
            anchors {
                top: parent.top
                topMargin: readOnly ? -1 * unrollShift * txtInput.height : txtInput.height
                left: parent.left
            }

            ItemShadow {
                elevation: 2
                anchors.fill: parent
                primaryColor: "black"
            }

            Item {
                anchors.fill: parent

                ListView {
                    id: elements

                    property int itemHeight: txtInput.height
                    property int maxHeight: count > maxVisibleItems && maxVisibleItems > 0 ?
                                                maxVisibleItems * itemHeight : count * itemHeight

                    function select(idx, txt) {
                        elements.currentIndex = idx
                        root.text = txt
                        elementSelected()
                    }

                    function unselect() {
                        elements.currentIndex = -1
                        root.text = ""
                        elementUnselected()
                    }
                    function setState(s) {
                        root.state = s
                    }

                    clip: true
                    anchors.fill: parent
                    highlightFollowsCurrentItem: false
                    currentIndex: -1
                    boundsBehavior: Flickable.StopAtBounds
                }

                Rectangle {
                    id: scrollbar

                    visible: (elements.count > maxVisibleItems) && (maxVisibleItems > 0)
                    anchors.right: elements.right
                    y: elements.visibleArea.yPosition * elements.height
                    width: 4
                    height: elements.visibleArea.heightRatio * elements.height
                    color: Colors.skinFrameTXT
                }
            }
        }

        NumberAnimation {
            id: iconAnim

            running: mouseClickArea.pressed
            target: fontIcon
            property: "ratio"
            from: 0.75; to: 1
            easing.type: Easing.InOutQuad
            duration: 100
        }

        MouseArea {
            id: mouseClickArea

            anchors {
                top: root.readOnly ? parent.top : iconCtn.top
                right: root.readOnly ? parent.right : iconCtn.right
                bottom: root.readOnly ? parent.bottom : iconCtn.bottom
                left: root.readOnly ? parent.left : iconCtn.left
            }
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (root.state !== "VISIBLE") {
                    root.state = "VISIBLE"
                    root.forceActiveFocus()
                } else
                    root.state = "HIDDEN"
            }
        }
    }
}

