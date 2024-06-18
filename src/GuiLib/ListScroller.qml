import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property bool upScroller: true
    property bool fullNavigation: true
    property bool hidden: false

    // signals
    signal previous()
    signal next()
    signal goToTop()
    signal goToBottom()

    // inner components
    Row {
        anchors.fill: parent

        Item {
            visible: width > 0 && opacity > 0
            height: parent.height
            width: fullNavigation ? parent.width/2 : 0
            opacity: hidden ? 0 : 1
            Behavior on opacity { NumberAnimation { } }

            FontIcon {
                id: singleIcon

                lib: Fonts.faSolid
                icon: upScroller ? FontAwesomeSolid.Icon.AngleUp : FontAwesomeSolid.Icon.AngleDown
                color: x1mouseArea.pressed ? Colors.skinFrameFGD : Colors.skinFrameTXT
                size: parent.height
                anchors.centerIn: parent
            }

            MouseArea {
                id: x1mouseArea

                anchors.fill: singleIcon
                cursorShape: x1mouseArea.containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                enabled: opacity > 0
                hoverEnabled: enabled
                onClicked: {
                    if (upScroller)
                        previous()
                    else
                        next()
                }
            }
        }
        Item {
            height: parent.height
            width: fullNavigation ? parent.width/2 : parent.width
            opacity: hidden ? 0 : 1
            Behavior on opacity { NumberAnimation { } }

            FontIcon {
                id: doubleIcon

                lib: Fonts.faSolid
                icon: upScroller ? FontAwesomeSolid.Icon.AngleDoubleUp : FontAwesomeSolid.Icon.AngleDoubleDown
                color: x2MouseArea.pressed ? Colors.skinFrameFGD : Colors.skinFrameTXT
                size: parent.height
                anchors.centerIn: parent
            }

            MouseArea {
                id: x2MouseArea

                anchors.fill: doubleIcon
                cursorShape: x2MouseArea.containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                enabled: opacity > 0
                hoverEnabled: enabled
                onClicked: {
                    if (upScroller)
                        goToTop()
                    else
                        goToBottom()
                }
            }
        }
    }
}


