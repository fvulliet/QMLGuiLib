import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property real size
    property color bkgdColor: Colors.themeMainColor
    property color borderColor: Colors.skinFrameBGD
    property alias currentIndex: list.currentIndex
    property alias model: list.model
    property alias highlightFollowsCurrentItem: list.highlightFollowsCurrentItem

    // signals
    signal previous()
    signal next()

    // Item's properties
    height: size
    width: 5*size

    // inner components
    Rectangle {
        id: centralCtnr

        anchors.centerIn: parent
        height: size; width: 4*size
        color: bkgdColor
        radius: 10

        ListView {
            id: list

            anchors.fill: parent
            orientation: ListView.Horizontal
            currentIndex: 0
            clip: true
            delegate: Item {
                width: ListView.view.width
                height: ListView.view.height

                Item {
                    height: parent.height
                    width: parent.width - leftCtnr.radius - leftCtnr.border.width - rightCtnr.radius - rightCtnr.border.width
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        anchors.centerIn: parent
                        font {
                            family: Fonts.sfyFont
                            pixelSize: width > parent.width ?
                                           (parent.height/2) * parent.width/(width+1) : (parent.height/2)
                        }
                        color: Colors.skinFrameTXT
                        text: name
                    }
                }
            }
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
                anchors.leftMargin: -1
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
            id: leftIcon

            anchors.centerIn: parent
            lib: Fonts.faSolid
            icon: FontAwesomeSolid.Icon.ChevronLeft
            color: borderColor
            size: parent.iconScale * parent.height / 2
        }

        MouseArea {
            id: minusArea

            enabled: model.count > 1
            anchors.fill: parent
            onClicked: previous()
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
                anchors.rightMargin: -1
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
            id: rightIcon

            anchors.centerIn: parent
            lib: Fonts.faSolid
            icon: FontAwesomeSolid.Icon.ChevronRight
            color: borderColor
            size: parent.iconScale * parent.height / 2
        }

        MouseArea {
            id: plusArea

            enabled: model.count > 1
            anchors.fill: parent
            onClicked: next()
        }
    }

}
