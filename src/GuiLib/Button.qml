import QtQuick 2.9
import Qt5Compat.GraphicalEffects as Effects
import GuiLib 1.0

FocusScope {
    id: root

    // public properties
    property bool enabled: true
    property bool isFlat: false
    property color textColor: Colors.skinButtonTXT
    property color bgColor: Colors.skinFrameTXT
    property color bkgdColor: "white"
    property int textSize: 0
    property string ctrlFont: Fonts.sfyFont
    property bool withGlow: true
    property bool emphasized: false
    property bool capitalized: true
    property alias text: btnText.content
    property alias trContext: btnText.context
    property alias hovered: mousearea.containsMouse
    property alias activeFocusOnPress: mousearea.activeFocusOnPress
    property alias radius: innerRect.radius

    // private properties
    property int _maxTextSize: height/2

    // signals
    signal clicked()
    signal textSizeAdjusted(int size)

    // FocusScope's properties
    activeFocusOnTab: true
    implicitWidth: btnText.implicitWidth + 2*Style.stdMargin

    // inner components
    Rectangle {
        id: innerRect

        anchors.fill: parent
        color: bkgdColor
        radius: 3

        Effects.RectangularGlow {
            id: bkgd

            cornerRadius: 2
            glowRadius: 2
            spread: isFlat ? 0 : 0.5
            anchors.fill: parent
            color: root.enabled ? bgColor : Colors.disabled(bgColor)
            opacity: root.isFlat ? 0 : withGlow ? 0.25 : 1

            states: State {
                name: "HOVERED"
                when: root.hovered && root.enabled

                PropertyChanges {
                    target: bkgd
                    opacity: isFlat ? 0.10 : 0.35
                }
            }
            transitions: Transition {
                NumberAnimation {
                    property: "opacity"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }

        TrText {
            id: btnText

            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font {
                family: root.ctrlFont
                pixelSize: textSize > 0 ? textSize : root.height * 1/2
                capitalization: root.capitalized ? Font.AllUppercase : Font.MixedCase
                bold: emphasized
            }
            color: {
                if (root.enabled) {
                    if (isFlat)
                        return Colors.skinFrameTXT
                    else
                        return textColor
                } else {
                    if (isFlat)
                        return Colors.disabled(Colors.skinFrameTXT)
                    else
                        return Colors.disabled(textColor)
                }
            }
            clip: true
            focus: true
            fontSizeMode: Text.Fit
            minimumPixelSize: 5
        }

        FocusArea {
            id: mousearea

            anchors.fill: parent
            hoverEnabled: true
            visible: root.enabled
            clip: true
            focusWidth: root.width
            hasFocus: root.activeFocus /*!< inform the focusArea that we now have the focus */
            z: (root.z > 0) ? root.z - 1 : root.z

            onActiveFocusRequest: root.forceActiveFocus(Qt.MouseFocusReason) /*!< force active focus on the FocusScope */
            onClicked: root.clicked() /*!< forward the signal */
        }
    }
}
