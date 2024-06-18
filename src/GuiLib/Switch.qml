import QtQuick 2.9
import GuiLib 1.0

FocusScope {
    id: root

    // public properties
    property int checked: 0
    property int labelSize
    property string ctrlFont: Fonts.sfyFont
    property color handleColor: Colors.skinFrameTXT
    property color activeColor: Colors.themeMainColor
    property bool slide: false
    property bool animationEnabled: true
    property bool labelOnRight: true
    property alias labelItem: swText
    property alias activeFocusOnPress: mousearea.activeFocusOnPress /*!< defaults to false */
    property alias enabled: mousearea.enabled
    property alias label: swText.content
    property alias trContext: swText.context

    // private properties
    property int _borderWidth: 2
    property bool _readyToAnchor: false
    property bool _dragged: false

    // signals
    signal clicked()

    // FocusScope's properties
    activeFocusOnTab: true
    implicitWidth: swRow.implicitWidth
    implicitHeight: swRow.implicitHeight

    // inner components
    Row {
        id: swRow

        spacing: label.length > 0 ? 10 : 0
        layoutDirection: labelOnRight ? Qt.LeftToRight : Qt.RightToLeft

        Item {
            id: swButton

            function release() {
                if (!slide)
                    return

                if (_readyToAnchor) {
                    _readyToAnchor = false
                    root.clicked()
                } else {
                    if (_dragged) {
                        if (root.checked > 0)
                            swHandle.x = swGroove.width/2
                        else
                            swHandle.x = 0
                    } else {
                        root.clicked()
                    }
                }
                _dragged = false
            }

            height: root.height; width: 2 * height
            states: [
                State {
                    name: "ON"
                    when: root.checked === 1

                    PropertyChanges {
                        target: swBkgd
                        color: activeColor
                        opacity: 0.25
                    }
                    PropertyChanges {
                        target: swHandle
                        color: activeColor
                        opacity: 1
                        x: swGroove.width / 2
                    }
                },
                State {
                    name: "OFF"
                    when: root.checked === 0

                    PropertyChanges {
                        target: swHandle
                        x: 0
                    }
                },
                State {
                    name: "UNDEF"
                    when: root.checked === -1

                    PropertyChanges {
                        target: swBkgd
                        color: Colors.disabled(Colors.skinFrameTXT)
                        opacity: 0.25
                    }
                    PropertyChanges {
                        target: swHandle
                        color: "white"
                        opacity: 1
                        x: swGroove.width / 4
                        border.width: _borderWidth
                    }
                }
            ]
            transitions: Transition {
                enabled: animationEnabled
                PropertyAnimation {
                    properties: "color, opacity, x, border.width"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }

            Rectangle {
                id: swBkgd

                anchors.fill: parent; anchors.margins: _borderWidth
                radius: height / 2
                color: "transparent"
            }

            Rectangle {
                id: swHandle

                height: parent.height; width: height
                radius: height / 2
                color: root.enabled ? Colors.inactive(handleColor) :
                                      Colors.disabled(handleColor)
                border {
                    color: root.enabled ? Colors.skinFrameTXT :
                                                 Colors.disabled(Colors.skinFrameTXT)
                    width: 0
                }
                opacity: 0.5

                onXChanged: {
                    if (!slide)
                        return

                    if (mousearea.pressed) {
                        _dragged = true
                        if ((root.checked <= 0) && (x >= swGroove.width/4))
                            _readyToAnchor = true
                        else if ((root.checked > 0) && (x <= swGroove.width/4))
                            _readyToAnchor = true
                    }
                }
            }

            Rectangle {
                id: swGroove

                anchors.fill: parent
                radius: height / 2
                border {
                    color: root.enabled ? Colors.skinFrameTXT :
                                                 Colors.disabled(Colors.skinFrameTXT)
                    width: _borderWidth
                }
                color: "transparent"
            }

            FocusArea {
                id: mousearea

                anchors.fill: parent
                hasFocus: root.activeFocus
                focusWidth: height * 1.4
                focusX: swHandle.x + swHandle.width / 2
                focusY: swHandle.y + swHandle.height / 2
                centered: true
                active: root.checked === 1
                z: (root.z > 0) ? root.z - 1 : root.z

                drag.target: slide ? swHandle : undefined
                drag.axis: Drag.XAxis
                drag.maximumX: swGroove.x + swGroove.width/2
                drag.minimumX: swGroove.x

                onActiveFocusRequest: root.forceActiveFocus(Qt.MouseFocusReason) /*!< force active focus on the FocusScope */
                onClicked: {
                    if (!slide)
                        root.clicked() /*!< forward the signal */
                }
                onDoubleClicked: {} /*!< ignore doubleClicks */
                onReleased: swButton.release()
            }
        }
        Item {
            width: swText.contentWidth; height: root.height

            TrText {
                id: swText

                function adjust() {
                    if ((contentWidth > 0) && (contentWidth >= root.width)) {
                        text = text.replace(/ ([^ ]*)$/, "\n"+'$1')
                    }
                }

                anchors.centerIn: parent
                font {
                    family: root.ctrlFont
                    pixelSize: labelSize > 0 ? labelSize : root.height * 2/3
                }
                color: root.enabled ? handleColor :
                                      Colors.disabled(handleColor)
                clip: true

                onTextChanged: adjust()
                Component.onCompleted: adjust()
            }
        }
    }
}

