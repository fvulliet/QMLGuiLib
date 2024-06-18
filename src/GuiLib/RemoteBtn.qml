import QtQuick 2.9
import GuiLib 1.0

Item {
    // public properties
    property alias lib: btnIcon.lib
    property alias icon: btnIcon.icon
    property alias size: btnIcon.size
    property color fgdColor: Colors.themeMainColor
    property bool enabled: true
    property alias pressAndHoldInterval: btnArea.pressAndHoldInterval

    // signals
    signal btnClicked()
    signal btnPressAndHold()
    signal btnReleased()

    // Item's properties
    states: State {
        when: btnArea.pressed

        PropertyChanges {
            target: btnIcon
            color: Qt.lighter(fgdColor)
            scale: 0.95
        }
    }
    transitions: Transition {
        NumberAnimation {
            property: "scale"; easing.type: Easing.InOutQuad
        }
        ColorAnimation {
            property: "color"; easing.type: Easing.InOutQuad
        }
    }

    // inner components
    FontIcon {
        id: btnIcon

        size: parent.height
        color: parent.fgdColor
        anchors.centerIn: parent
    }

    MouseArea {
        id: btnArea

        visible: enabled
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: btnClicked()
        onPressAndHold: btnPressAndHold()
        onReleased: btnReleased()
    }
}
