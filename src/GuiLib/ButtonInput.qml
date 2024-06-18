import QtQuick 2.0
import GuiLib 1.0

Item {
    id: root

    // public properties
    property alias text: textDisplayed.text
    property alias iconLib: iconDisplayed.lib
    property alias iconId: iconDisplayed.icon
    property alias iconSize: iconDisplayed.size
    property alias textSize: textDisplayed.font.pixelSize
    property color color: Colors.skinFrameTXT
    property bool operator: false
    property bool dimmable: false
    property bool dimmed: false
    property bool enabled: true

    // signals
    signal buttonClicked(bool operator)

    // Item's properties
    width: 70; height: 70
    states: State{
        name: "pressed"
        when: mouse.pressed && !dimmed

        PropertyChanges {
            target: textDisplayed
            color: Qt.lighter(root.color)
        }
        PropertyChanges {
            target: iconDisplayed
            color: Qt.lighter(root.color)
        }
    }

    // inner components
    Rectangle {
        anchors.fill: parent
        color: Colors.skinFrameBGD
        radius: 3

        FontIcon {
            id: iconDisplayed

            visible: !textDisplayed.visible
            color: (dimmable && dimmed) ? Qt.darker(root.color) : root.color
            Behavior on color { ColorAnimation
                { duration: 120; easing.type: Easing.OutElastic} }
            size: parent.height * 2/3
            anchors.centerIn: parent
        }

        Text {
            id: textDisplayed

            visible: text.length > 0
            font {
                family: Fonts.sfyFont; pixelSize: parent.height * 2/3
            }
            anchors.centerIn: parent
            wrapMode: Text.WordWrap
            color: (dimmable && dimmed) ?
                       Qt.darker(root.color) : root.color
            Behavior on color { ColorAnimation
                { duration: 120; easing.type: Easing.OutElastic} }
        }

        MouseArea {
            id: mouse

            anchors.fill: parent
            onClicked: {
                if (enabled)
                    buttonClicked(operator)
            }
        }
    }
}

