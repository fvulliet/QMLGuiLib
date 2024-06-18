import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property real size
    property color bkgdColor: Colors.themeMainColor
    property color borderColor: Colors.skinFrameBGD
    property int currentValue
    property int minValue
    property int maxValue

    // private properties
    property bool _pressed: minusArea.pressed

    // signals
    signal decreased()
    signal increased()

    // Item's properties
    height: size
    width: 3*size

    // inner components
    Rectangle {
        id: centralCtnr

        anchors.centerIn: parent
        height: size; width: 2*size
        color: bkgdColor
        radius: 10

        StandardText {
            font.pixelSize: parent.height/2
            text: currentValue
        }
    }

    Rectangle {
        id: leftCtnr

        property real scale: 1
        property real iconScale: 1

        anchors {
            left: parent.left; leftMargin: 0
            verticalCenter: parent.verticalCenter
        }
        height: scale * size; width: scale * size
        radius: height/2
        color: bkgdColor
        border { color: borderColor; width: 2 }
        states: State {
            when: minusArea.pressed

            PropertyChanges {
                target: leftCtnr
                color: Qt.darker(bkgdColor, 1.02)
            }
            PropertyChanges {
                target: leftCtnr
                anchors.leftMargin: 1
            }
        }
        transitions: Transition {
            ParallelAnimation {
                ColorAnimation {
                    properties: "color"
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    properties: "scale, anchors.leftMargin"
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
        }

        FontIcon {
            id: minusIcon

            anchors.centerIn: parent
            lib: Fonts.faSolid
            icon: FontAwesomeSolid.Icon.Minus
            color: borderColor
            size: parent.iconScale * parent.height / 2
        }

        MouseArea {
            id: minusArea

            anchors.fill: parent
            onClicked: {
                if (currentValue > minValue)
                    decreased()
            }
        }
    }
    Rectangle {
        id: rightCtnr

        property real scale: 1
        property real iconScale: 1

        anchors {
            right: parent.right; rightMargin: 0
            verticalCenter: parent.verticalCenter
        }
        height: scale * size; width: scale * size
        radius: height/2
        color: bkgdColor
        border { color: borderColor; width: 2 }
        states: State {
            when: plusArea.pressed

            PropertyChanges {
                target: rightCtnr
                color: Qt.darker(bkgdColor, 1.02)
            }
            PropertyChanges {
                target: rightCtnr
                anchors.rightMargin: 1
            }
        }
        transitions: Transition {
            ParallelAnimation {
                ColorAnimation {
                    properties: "color"
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    properties: "scale, anchors.rightMargin"
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
        }

        FontIcon {
            id: plusIcon

            anchors.centerIn: parent
            lib: Fonts.faSolid
            icon: FontAwesomeSolid.Icon.Plus
            color: borderColor
            size: parent.iconScale * parent.height / 2
        }

        MouseArea {
            id: plusArea

            anchors.fill: parent
            onClicked: {
                if (currentValue < maxValue)
                    increased()
            }
        }
    }

}
