import QtQuick 2.9

Item {
    id: root

    // public properties
    property color color: Colors.skinFrameTXT
    property alias bkgdColor: bkgd.color
    property alias enabled: mousearea.enabled
    property alias lib: icon.lib
    property alias icon: icon.icon
    property real lighterCoef: 1.25

    // signals
    signal clicked()

    // Item's properties
    states: State {
        name: "PRESSED"
        when: mousearea.pressed
        PropertyChanges {
            target: icon
            scale: 0.9
        }
    }
    transitions: [
        Transition {
            to: "PRESSED"
            NumberAnimation {
                property: "scale"
                duration: 100
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            from: "PRESSED"
            NumberAnimation {
                property: "scale"
                duration: 250
                easing.type: Easing.OutElastic
            }
        }
    ]

    // inner components
    Rectangle {
        id: bkgd

        anchors.centerIn: parent
        width: parent.width*0.75; height: width
        radius: width/2
        color: "transparent"
        scale: icon.scale
    }

    FontIcon {
        id: icon

        anchors.centerIn: parent
        color: Qt.lighter(root.color, mousearea.pressed ? lighterCoef : 1)
        size: parent.width
    }

    MouseArea {
        id: mousearea

        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}

