import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property bool isHorizontal: true
    property int border: 2
    property real scaleFactor: 0.5
    property int splitWidth: 40
    property int splitMargin: 4
    property bool extended: false
    property color splitColor: Colors.skinFrameBGD
    property color iconColor: Colors.skinFrameTXT
    property bool hiddenWhenCollapsed: false
    property bool animated: true
    property bool animationIsRunning: extensionTransition.running
                                      || closingTransition.running
    property Item mainItem
    property Rectangle extendedItem
    property bool withSeparator: false
    property real maxSplitRatio: 1/5

    // signals
    signal extend()
    signal collapse()
    signal extensionOver()

    // Item's properties
    states: [
        State {
            name: "EXTENDED"
            when: extended

            PropertyChanges { target: extension; opacity: 1 }
            PropertyChanges {
                target: main
                width: isHorizontal ? root.width * scaleFactor : root.width
                height: isHorizontal ? root.height : root.height * scaleFactor
            }
            PropertyChanges { target: closing; opacity: 1 }
        },
        State {
            when: !extended

            PropertyChanges { target: extending; opacity: 1 }
        }
    ]
    transitions: [
        Transition {
            id: extensionTransition

            to: "EXTENDED"
            enabled: animated

            SequentialAnimation {
                NumberAnimation {
                    target: extending; property: "opacity"
                    duration: 100; easing.type: Easing.InQuad
                }
                NumberAnimation {
                    targets: [main, extension]
                    properties: isHorizontal ? "opacity, width" : "opacity, height"
                    duration: 250; easing.type: Easing.InQuad
                }
                NumberAnimation {
                    target: closing; property: "opacity"
                    duration: 250; easing.type: Easing.InQuad
                }
            }
        },
        Transition {
            id: closingTransition

            from: "EXTENDED"
            enabled: animated

            onRunningChanged: {
                if (!running)
                    extensionOver()
            }

            SequentialAnimation {
                NumberAnimation {
                    target: closing; property: "opacity"
                    duration: 250; easing.type: Easing.InQuad
                }
                NumberAnimation {
                    targets: [extension, main]
                    properties: isHorizontal ? "opacity, width" : "opacity, height"
                    duration: 250; easing.type: Easing.InQuad
                }
                NumberAnimation {
                    target: extending; property: "opacity"
                    duration: 500; easing.type: Easing.InQuad
                }
            }
        }
    ]


    onMainItemChanged: {
        if (mainItem) {
            mainItem.parent = main
            mainItem.anchors.fill = main
        }
    }

    onExtendedItemChanged: {
        if (extendedItem) {
            extendedItem.parent = extension
            extendedItem.anchors.fill = extension
            extendedItem.anchors.margins = extension.border.width
        }
    }

    // inner components
    Item {
        id: main

        z: 3
        visible: mainItem ? true : false
        height: root.height; width: root.width
        anchors { left: root.left; top: root.top }
    }

    Rectangle {
        id: extension

        z: 2
        visible: !extendedItem ? false : (opacity > 0)
        opacity: 0
        height: isHorizontal ? root.height : root.height * (1 - scaleFactor) - closing.height
        width: isHorizontal ? root.width * (1 - scaleFactor) - closing.width : root.width
        anchors {
            left: isHorizontal ? closing.right : root.left
            top: isHorizontal ? root.top : closing.bottom
        }
        color: "transparent"
        border {
            width: root.border
            color: splitColor
        }
    }

    Rectangle {
        id: extending

        height: isHorizontal ? parent.height : Math.min(parent.height*maxSplitRatio, splitWidth)
        width: isHorizontal ? Math.min(parent.width*maxSplitRatio, splitWidth) : parent.width
        anchors {
            right: isHorizontal ? parent.right : undefined
            bottom: isHorizontal ? undefined : parent.bottom
        }
        visible: opacity > 0 && !hiddenWhenCollapsed
        opacity: 0
        color: "transparent"

        Item {
            anchors {
                fill: parent
                margins: splitMargin
            }

            FontIcon {
                anchors.centerIn: parent
                lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.SurroundedArrowL
                size: Math.min(parent.width, parent.height)-2
                color: iconColor
                rotation: isHorizontal ? 0 : 90
            }
        }

        MouseArea {
            width: isHorizontal ? parent.width : 2*splitWidth
            height: isHorizontal ? 2*splitWidth : parent.height
            anchors {
                verticalCenter: isHorizontal ? parent.verticalCenter : undefined
                horizontalCenter: isHorizontal ? undefined : parent.horizontalCenter
            }
            cursorShape: Qt.PointingHandCursor
            onClicked: extend()
        }
    }

    Rectangle {
        id: closing

        height: extending.height
        width: extending.width
        visible: opacity > 0; opacity: 0
        anchors {
            left: isHorizontal ? main.right : undefined
            top: isHorizontal ? undefined : main.bottom
        }
        color: splitColor
        z: 1

        Item {
            anchors {
                fill: parent
                margins: splitMargin
            }

            FontIcon {
                anchors.centerIn: parent
                lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.SurroundedArrowR
                size: Math.min(parent.width, parent.height)-2
                color: iconColor
                rotation: isHorizontal ? 0 : 90
            }
        }

        MouseArea {
            width: isHorizontal ? parent.width : 2*splitWidth
            height: isHorizontal ? 2*splitWidth : parent.height
            anchors {
                verticalCenter: isHorizontal ? parent.verticalCenter : undefined
                horizontalCenter: isHorizontal ? undefined : parent.horizontalCenter
            }
            cursorShape: Qt.PointingHandCursor
            onClicked: collapse()
        }

        Rectangle {
            height: withSeparator ? isHorizontal ? (parent.height - splitWidth)/2 - Style.stdMargin : 1 : 0
            width: isHorizontal ? 1 : (parent.width - splitWidth)/2 - Style.stdMargin
            visible: height > 0
            color: iconColor
            anchors {
                horizontalCenter: isHorizontal ? parent.horizontalCenter : parent.verticalCenter
            }
        }
        Rectangle {
            height: withSeparator ? isHorizontal ? (parent.height - splitWidth)/2 - Style.stdMargin : 1 : 0
            width: isHorizontal ? 1 : (parent.width - splitWidth)/2 - Style.stdMargin
            visible: height > 0
            color: iconColor
            anchors {
                horizontalCenter: isHorizontal ? parent.horizontalCenter : parent.verticalCenter
                bottom: isHorizontal ? parent.bottom : undefined
                right: isHorizontal ? undefined : parent.right
            }
        }
    }
}
