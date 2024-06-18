import QtQuick 2.9
import GuiLib 1.0

FocusScope {
    id: root

    // public properties
    property bool checked: false
    property alias enabled: mousearea.enabled
    property int labelSize
    property string ctrlFont: Fonts.sfyFont
    property bool reversed: false
    property color color: Colors.skinFrameTXT
    property alias text: cboxText.content
    property alias trContext: cboxText.context
    property alias activeFocusOnPress: mousearea.activeFocusOnPress /*!< defaults to false */
    property alias propagateComposedEvents: mousearea.propagateComposedEvents
    property alias spacing: cboxRow.spacing

    // signals
    signal clicked()

    // FocusScope properties
    activeFocusOnTab: true
    implicitWidth: cboxRow.implicitWidth

    // inner components
    Row {
        id: cboxRow

        spacing: 10
        layoutDirection: root.reversed ? Qt.RightToLeft : Qt.LeftToRight

        Item {
            id: cboxIndicator

            height: root.height; width: height

            states: State {
                name: "ON"
                when: root.checked === true

                PropertyChanges { target: cboxOff; opacity: 0 }
                PropertyChanges { target: cboxOn; opacity: 1 }
            }
            transitions: Transition {
                NumberAnimation {
                    property: "opacity"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }

            FontIcon {
                id: cboxOff

                opacity: 1
                visible: opacity > 0
                lib: Fonts.faRegular; icon: FontAwesomeRegular.Icon.SignBlank
                styleName: "Regular"
                color: root.enabled ? root.color :
                                      Colors.disabled(root.color)
                size: parent.height
                anchors.centerIn: parent
            }

            FontIcon {
                id: cboxOn

                opacity: 0
                visible: opacity > 0
                lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.CheckSquare
                color: root.enabled ? Colors.themeMainColor : Colors.disabled(Colors.themeMainColor)
                size: parent.height
                anchors.centerIn: parent
            }
        }
        Item {
            width: cboxText.contentWidth
            height: root.height

            TrText {
                id: cboxText

                anchors.centerIn: parent
                font {
                    family: root.ctrlFont
                    pixelSize: labelSize > 0 ? labelSize : root.height * 2/3
                }
                horizontalAlignment: root.reversed ?
                                         Text.AlignRight : Text.AlignLeft
                color: root.enabled ? root.color :
                                      Colors.disabled(root.color)
                clip: true
                fontSizeMode: Text.Fit
                minimumPixelSize: 5
            }
        }
    }

    FocusArea {
        id: mousearea

        anchors.fill: parent
        hasFocus: root.activeFocus
        focusWidth: height * 1.4
        focusX: reversed ? width - cboxIndicator.width / 2 : cboxIndicator.width / 2
        focusY: cboxIndicator.height / 2
        centered: true
        active: root.checked
        z: (root.z > 0) ? root.z - 1 : root.z

        onActiveFocusRequest: root.forceActiveFocus(Qt.MouseFocusReason) /*!< force active focus on the FocusScope */
        onClicked: root.clicked() /*!< forward the signal */
        onDoubleClicked: {} /*!< ignore doubleClicks */
    }
}


