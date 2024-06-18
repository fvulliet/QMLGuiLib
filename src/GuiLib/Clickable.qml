import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property alias radius: rect.radius
    property alias color: rect.color
    property alias centered: foc.centered
    property alias focusWidth: foc.focusWidth
    property alias active: foc.active

    // signals
    signal clickableAnimationOver()

    // inner components
    Rectangle {
        id: rect

        anchors.fill: parent

        FocusArea {
            id: foc

            anchors.fill: parent

            onFocusAnimationOver: {
                clickableAnimationOver()
            }
        }
    }
}
