import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property bool running: false
    property int gap: progressWidth
    property alias buttonWidth: button.width
    property alias buttonHeight: button.height
    property alias progressWidth: progress.width
    property alias progressHeight: progress.height
    property alias bkgdColor: progress.bkgdColor
    property alias enabled: button.enabled
    property alias isFlat: button.isFlat
    property alias textColor: button.textColor
    property alias bgColor: button.bgColor
    property alias textSize: button.textSize
    property alias ctrlFont: button.ctrlFont
    property alias text: button.text
    property alias trContext: button.trContext
    property alias hovered: button.hovered
    property alias activeFocusOnPress: button.activeFocusOnPress
    property alias withGlow: button.withGlow
    property alias emphasized: button.emphasized
    property alias capitalized: button.capitalized
    property alias iconColor: customIcon.color
    property alias iconLib: customIcon.lib
    property alias iconIcon: customIcon.icon

    // signals
    signal clicked()

    // Item's properties
    states: State {
        when: running
        name: "RUNNING"

        PropertyChanges {
            target: button
            x: root.x + (root.width - button.width) / 2 - gap
        }
        PropertyChanges {
            target: progress
            opacity: 1
            x: root.x + (root.width - progress.width) / 2 + gap + (button.width - gap)/2
        }
    }
    transitions: [
        Transition {
            to: "RUNNING"

            NumberAnimation {
                property: "x"
                duration: 500
                easing {
                    type: Easing.OutElastic
                    amplitude: 1.25; period: 0.5
                }
            }
            NumberAnimation {
                property: "opacity"
                duration: 100
                easing.type: Easing.OutQuint
            }
        },
        Transition {
            from: "RUNNING"

            NumberAnimation {
                property: "x"
                duration: 500
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                property: "opacity"
                easing.type: Easing.InQuad
            }
        }
    ]

    // inner components
    ProgressItem {
        id: progress

        anchors.verticalCenter: parent.verticalCenter
        size: button.height
        x: root.x + (root.width - progress.width) / 2
        opacity: 0
        visible: opacity > 0
        withSustain: false

        onVisibleChanged: {
            if (visible)
                progress.start()
            else
                progress.stop()
        }

        FontIcon {
            id: customIcon

            anchors.centerIn: parent
            size: parent.height / 2
            visible: icon.length > 0
        }
    }

    Button {
        id: button

        anchors.verticalCenter: parent.verticalCenter
        x: root.x + (root.width - button.width) / 2
        bkgdColor: progress.bkgdColor

        onClicked: root.clicked()
    }
}
