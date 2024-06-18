import QtQuick 2.9
import GuiLib 1.0

FocusScope {
    id: root

    property color borderColor: Colors.skinFrameTXT
    property int borderWidth: 1
    property alias lib: icon.lib
    property alias icon: icon.icon
    property alias iconColor: icon.color
    property alias ctnrColor: ctnr.color
    property alias activeFocusOnPress: mousearea.activeFocusOnPress
    property alias enabled: mousearea.enabled

    signal clicked()

    Rectangle {
        id: ctnr

        anchors.fill: parent
        color: "transparent"
        border {
            width: borderWidth; color: borderColor
        }
        radius: height/2

        FontIcon {
            id: icon

            property real ratio: mousearea.containsMouse ? 0.9 : 1

            color: Colors.themeMainColor
            anchors.centerIn: parent
            size: (parent.height/2)*ratio
        }

        NumberAnimation {
            id: iconAnim

            target: icon
            property: "opacity"
            from: 0; to: 1
            alwaysRunToEnd: true
            easing.type: Easing.OutQuad; duration: 1000
        }

        FocusArea {
            id: mousearea

            width: parent.width; height: parent.height
            hoverEnabled: true
            visible: root.enabled
            focusWidth: root.width
            hasFocus: root.activeFocus /*!< inform the focusArea that we now have the focus */
            z: (root.z > 0) ? root.z - 1 : root.z
            centered: true
            focusX: ctnr.width / 2
            focusY: ctnr.height / 2

            onActiveFocusRequest: root.forceActiveFocus(Qt.MouseFocusReason) /*!< force active focus on the FocusScope */
            onClicked: {
                iconAnim.start()
                root.clicked() /*!< forward the signal */
            }
        }
    }
}
