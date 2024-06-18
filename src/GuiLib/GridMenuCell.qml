import QtQuick 2.9
import GuiLib 1.0

Rectangle {
    id: root

    // public properties
    property alias iconLib: iconTitle.iconLib
    property alias iconId: iconTitle.iconId
    property alias font: iconTitle.font
    property alias contentColor: iconTitle.contentColor
    property alias text: iconTitle.text
    property alias trContext: iconTitle.trContext
    property alias showNav: nav.visible
    property int cellId

    // signals
    signal clicked(int cellId)

    // Rectangle's properties
    color: Colors.skinFrameFGD
    states: State {
        when: mouseCtrl.containsMouse

        PropertyChanges { target: iconTitle; scale: 1.05 }
    }
    transitions: Transition {
        NumberAnimation {
            property: "scale"; duration: 250
            easing.type: Easing.InOutQuad
        }
    }

    // inner components
    IconTitle {
        id: iconTitle
        anchors.fill: parent
    }

    NavIcon {
        id: nav

        isNext: true
        anchors {
            bottom: parent.bottom
            right: parent.right
        }
    }

    MouseArea {
        id: mouseCtrl

        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked(root.cellId)
        hoverEnabled: true
    }
}

