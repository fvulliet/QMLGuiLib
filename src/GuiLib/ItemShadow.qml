import QtQuick
import Qt5Compat.GraphicalEffects
import GuiLib 1.0

Item {
    id: root

    // public properties
    property int elevation
    property real radius: 0
    property alias primaryColor: g1.color
    property int verticalShift: 0
    property int horizontalShift: 0

    // inner components
    RectangularGlow {
        id: g1

        anchors {
            top: parent.top; topMargin: verticalShift
            left: parent.left; leftMargin: horizontalShift
        }
        width: parent.width; height: parent.height
        spread: 0.16
        opacity: 0
        cornerRadius: parent.radius + glowRadius

        states: [
            State {
                name: "L0"; when: elevation <= 0
                PropertyChanges { target: g1; opacity: 1.5 *  0 } },
            State {
                name: "L1"; when: elevation == 1
                PropertyChanges { target: g1; anchors.verticalCenterOffset: 1; glowRadius: 3; opacity: 1.5 *  0.12 } },
            State {
                name: "L2"; when: elevation == 2
                PropertyChanges { target: g1; anchors.verticalCenterOffset: 3; glowRadius: 6; opacity: 1.5 *  0.16 } },
            State {
                name: "L3"; when: elevation == 3
                PropertyChanges { target: g1; anchors.verticalCenterOffset: 10; glowRadius: 20; opacity: 1.5 *  0.19 } },
            State {
                name: "L4"; when: elevation == 4
                PropertyChanges { target: g1; anchors.verticalCenterOffset: 14; glowRadius: 28; opacity: 1.5 *  0.25 } },
            State {
                name: "L5"; when: elevation >= 5
                PropertyChanges { target: g1; anchors.verticalCenterOffset: 19; glowRadius: 38; opacity: 1.5 *  0.30 } }
        ]
        transitions: [
            Transition {
                NumberAnimation { properties: "anchors.verticalCenterOffset,glowRadius,opacity"; duration: 600; easing.type: Easing.InOutQuad }
            }
        ]
    }

    RectangularGlow {
        id: g2

        anchors {
            top: parent.top; topMargin: verticalShift
            left: parent.left; leftMargin: horizontalShift
        }
        width: parent.width; height: parent.height
        color: "black"
        spread: 0.16
        opacity: 0
        cornerRadius: parent.radius + glowRadius

        states: [
            State {
                name: "L0"; when: elevation <= 0
                PropertyChanges { target: g2; opacity: 1.5 *  0 } },
            State {
                name: "L1"; when: elevation == 1
                PropertyChanges { target: g2; anchors.verticalCenterOffset: 1; glowRadius: 2; opacity: 1.5 *  0.24 } },
            State {
                name: "L2"; when: elevation == 2
                PropertyChanges { target: g2; anchors.verticalCenterOffset: 3; glowRadius: 6; opacity: 1.5 *  0.23 } },
            State {
                name: "L3"; when: elevation == 3
                PropertyChanges { target: g2; anchors.verticalCenterOffset: 6; glowRadius: 6; opacity: 1.5 *  0.23 } },
            State {
                name: "L4"; when: elevation >= 4
                PropertyChanges { target: g2; anchors.verticalCenterOffset: 10; glowRadius: 10; opacity: 1.5 *  0.22 } },
            State {
                name: "L5"; when: elevation >= 5
                PropertyChanges { target: g2; anchors.verticalCenterOffset: 15; glowRadius: 12; opacity: 1.5 *  0.22 } }
        ]
        transitions: [
            Transition {
                NumberAnimation { properties: "anchors.verticalCenterOffset,glowRadius,opacity"; duration: 600; easing.type: Easing.OutQuad }
            }
        ]
    }
}
