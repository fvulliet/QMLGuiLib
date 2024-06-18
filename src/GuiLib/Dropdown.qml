import QtQuick 2.9
import Qt5Compat.GraphicalEffects 1.0 as Effects
import GuiLib 1.0

FocusScope {
    id: root

    // public properties
    property int maxVisibleItems: -1
    property string trContext: ""
    property string ctrlFont: Fonts.sfyFont
    property int unrollShift: 0
    property bool accessByRole: true
    property alias model: elements.model
    property alias validator: txtInput.validator
    property alias acceptableInput: txtInput.acceptableInput
    property alias currentIndex: elements.currentIndex
    property alias readOnly: txtInput.readOnly
    property alias text: txtInput.text
    property alias textColor: txtInput.textColor
    property alias bkgdColor: txtInput.bkgdColor
    property alias textPixelSize: txtInput.textPixelSize
    property alias notFocusedColor: txtInput.notFocusedColor
    property alias focusedColor: txtInput.focusedColor
    property alias count: elements.count
    property alias enabled: mouseClickArea.enabled

    // signals
    signal elementSelected(int index)

    // functions
    function resetDropdown() {
        elements.currentIndex = -1
        text = ""
    }

    // FocusScope's properties
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
            duration: 250
            easing.type: Easing.InOutQuad
        }
    }

    onActiveFocusChanged: {
        if (!activeFocus && (state === "VISIBLE"))
            state = "HIDDEN"
    }

    Component.onCompleted: Utils.bound(unrollShift, -1, maxVisibleItems)
    onUnrollShiftChanged: Utils.bound(unrollShift, -1, maxVisibleItems)

    // inner components
    Item {
        anchors.fill: parent
        Keys.onPressed: {
            if (event.key === Qt.Key_Escape) {
                if (parent.state === "VISIBLE") {
                    parent.state = "HIDDEN"
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

            Rectangle {
                id: elementsRect

                anchors.fill: parent
                radius: 2
                color: "transparent"

                ListView {
                    id: elements

                    property int itemHeight: txtInput.height
                    property int maxHeight: count > maxVisibleItems && maxVisibleItems > 0 ?
                                                maxVisibleItems * itemHeight : count * itemHeight
                    property var currentModelData

                    function setText() {
                        if (accessByRole) {
                            if (model && (model.get(currentIndex) !== undefined) && (currentIndex >= 0) )
                                root.text = qsTranslate(trContext, model.get(currentIndex).name)
                        } else {
                            if (currentModelData && (currentIndex >= 0) )
                                root.text = qsTranslate(trContext, currentModelData.name)
                        }
                    }

                    clip: true
                    anchors.fill: parent
                    highlightFollowsCurrentItem: false
                    currentIndex: -1
                    boundsBehavior: Flickable.StopAtBounds
                    delegate: Clickable {
                        width: ListView.view.width; height: ListView.view.itemHeight
                        anchors.horizontalCenter: parent.horizontalCenter
                        centered: false
                        focusWidth: 50
                        color: Colors.skinItemBGD
                        Behavior on color { ColorAnimation { duration: 250 } }

                        TrText {
                            anchors.centerIn: parent
                            color: Colors.skinItemFGD
                            font { family: root.ctrlFont
                                pixelSize: Utils.limitMax(parent.height/2, 16)
                            }
                            smooth: true
                            content: accessByRole ? name : modelData.name; context: trContext
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            onClicked: {
                                if (!accessByRole)
                                    elements.currentModelData = modelData

                                elementSelected(index)
                                root.state = "HIDDEN"
                                parent.active = !parent.active
                            }
                            onEntered: color = Colors.skinItemHOV
                            onExited: color = Colors.skinItemBGD
                        }
                        Component.onCompleted: {
                            if ( (index === 0) || (index === ListView.view.count-1) )
                                radius = elementsRect.radius
                            else
                                radius = 0
                        }
                    }
                    Component.onCompleted: setText()
                    onCurrentIndexChanged: setText()
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
