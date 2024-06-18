import QtQuick 2.9
import GuiLib 1.0

FocusScope {
    id: root

    // public properties
    property bool checked: false
    property int textSize
    property string ctrlFont: Fonts.sfyFont
    property bool reversed: false
    property int gap: 10
    property alias activeFocusOnPress: mousearea.active
    property alias enabled: mousearea.enabled
    property alias text: rbText.content
    property alias trContext: rbText.context

    // signals
    signal clicked()

    activeFocusOnTab: true

    // inner components
    Row {
        id: rbRow

        anchors.fill: parent
        spacing: gap
        layoutDirection: reversed ? Qt.RightToLeft : Qt.LeftToRight

        Rectangle {
            id: rbIndicator

            color: "transparent"
            height: {
                // must be even ... otherwise central dot might be not centered
                var ceiled = Math.ceil(root.height)
                if (ceiled%2 === 0)
                    return ceiled
                else
                    return ceiled-1
            }
            width: height; radius: width / 2
            border {
                color: root.enabled ? Colors.skinFrameTXT :
                                             Colors.disabled(Colors.skinFrameTXT)
                width: width / 10
            }

            Rectangle {
                id: dot

                color: root.enabled ? Colors.skinFrameTXT :
                                      Colors.disabled(Colors.skinFrameTXT)
                width: 0 ; height: width; radius: width / 2
                visible: width > 0
                anchors {
                    centerIn: parent
                    alignWhenCentered: false
                }
            }

            states: State {
                name: "ON"
                when: root.checked === true

                PropertyChanges { target: rbIndicator; border.color: root.enabled ? Colors.themeMainColor : Colors.disabled(Colors.themeMainColor) }
                PropertyChanges { target: dot; width: root.height / 2 }
                PropertyChanges { target: dot; color: root.enabled ? Colors.themeMainColor : Colors.disabled(Colors.themeMainColor) }
            }
            transitions: Transition {
                ColorAnimation {
                    properties: "color, border.color"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    property: "width"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }
        Item {
            width: parent.width - rbIndicator.width - gap
            height: parent.height

            TrText {
                id: rbText

                anchors.fill: parent
                font {
                    family: root.ctrlFont
                    pixelSize: textSize > 0 ? textSize : root.height * 2/3
                }
                horizontalAlignment: reversed ?
                                         Text.AlignRight : Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                color: root.enabled ? Colors.skinFrameTXT :
                                      Colors.disabled(Colors.skinFrameTXT)
                minimumPixelSize: 5
                fontSizeMode: Text.Fit
            }
        }
    }

    FocusArea {
        id: mousearea

        anchors.fill: parent
        hasFocus: root.activeFocus
        focusWidth: height * 1.4
        focusX: reversed ? width - rbIndicator.width / 2 : rbIndicator.width / 2
        focusY: rbIndicator.height / 2
        centered: true
        active: root.checked
        z: (root.z > 0) ? root.z - 1 : root.z

        onActiveFocusRequest: root.forceActiveFocus(Qt.MouseFocusReason) /*!< force active focus on the FocusScope */
        onClicked: root.clicked() /*!< forward the signal */
        onDoubleClicked: {} /*!< ignore doubleClicks */
    }
}


