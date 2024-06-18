import QtQuick 2.9
import Qt5Compat.GraphicalEffects 1.0 as Effects
import GuiLib 1.0

FocusScope {
    id: root

    // public properties
    property color fgColor: Colors.skinFrameTXT
    property alias iconLib: btnIcon.lib
    property alias iconIcon: btnIcon.icon
    property alias iconSize: btnIcon.size
    property color iconColor: Colors.skinFrameFGD
    property alias hovered: mousearea.containsMouse
    property alias activeFocusOnPress: mousearea.activeFocusOnPress
    property alias verticalShift: glow.verticalShift
    property alias horizontalShift: glow.horizontalShift
    property int elevation: 1

    // signals
    signal clicked()

    // FocusScope's properties
    width: height
    activeFocusOnTab: true

    // inner components
    ItemShadow {
        id: glow

        anchors.fill: foreground; radius: foreground.radius
        elevation: root.elevation

        states: State {
            name: "HOVERED"
            when: root.hovered

            PropertyChanges {
                target: glow
                elevation: root.elevation + 1
                opacity: 0.75
            }
        }
        transitions: Transition {
            NumberAnimation {
                property: "opacity"
                easing.type: Easing.InOutQuad
            }
        }
    }

    Rectangle {
        id: foreground

        height: parent.height; width: height; radius: height/2
        color: fgColor
        z: glow.z + 1

        FontIcon {
            id: btnIcon

            color: iconColor
            anchors.centerIn: parent
        }
    }

    FocusArea {
        id: mousearea

        anchors.fill: parent
        hoverEnabled: true
        centered: true
        clip: true
        focusWidth: root.width
        hasFocus: root.activeFocus /*!< inform the focusArea that we now have the focus */
        z: (root.z > 0) ? root.z - 1 : root.z

        onActiveFocusRequest: root.forceActiveFocus(Qt.MouseFocusReason) /*!< force active focus on the FocusScope */
        onClicked: root.clicked() /*!< forward the signal */
    }
}
