import QtQuick 2.9
import GuiLib 1.0 as Gui

FocusScope {
    id: root

    property int _gapFromTitle: 30
    property string _trContext: "ConnectorsView"
    property var dynComp
    property var dynObj

    function releaseItem() {
        if (dynObj.readyToDrop)
            dynObj.Drag.drop()
        dynObj.parent = bottomCircle
    }

    function pressItem() {
        console.log("-----pressItem")
        // change parent when dragged, in order to stay beyond drop area
        dynObj.parent = root
        console.log("-----mapToItem", root.mapToItem(dynObj, 0, 0))
    }

    Rectangle {
        id: frame

        anchors.fill: parent
        color: Gui.Colors.skinFrameFGD

        MouseArea {
            anchors.fill: parent
            onClicked: parent.focus = true
        }

        Column {
            anchors.fill: parent

            DemoHeader {
                id: header

                width: parent.width; height: parent.height / 15
                title: QT_TR_NOOP("CONNECTORS"); trContext: _trContext
            }
            Item {
                width: parent.width; height: parent.height - header.height

                Column {
                    width: 100; height: childrenRect.height
                    anchors.centerIn: parent
                    spacing: 100

                    Rectangle {
                        id: topCircle

                        property bool isHovered: upMouseArea.containsMouse

                        height: 100; width: height; radius: height/2
                        color: "transparent"
                        border.color: Gui.Colors.skinFrameTXT

                        DraggedRectangle {
                            width: parent.width/2; height: parent.height/2
                            anchors.centerIn: parent
                            color: Gui.Colors.themeStatusKo
                        }

                        onIsHoveredChanged: {
                            if (isHovered) {
                                if ((dynObj !== null) && (dynObj !== undefined))
                                    dynObj.destroy()

                                dynComp = Qt.createComponent("DraggedRectangle.qml", root);
                                if (dynComp.status === Component.Ready) {
                                    dynObj = dynComp.createObject(
                                                topCircle, {
                                                    "color": Gui.Colors.themeMainColor,
                                                    "width": topCircle.width/2,
                                                    "height": topCircle.height/2,
                                                    "x": topCircle.x + topCircle.width/2 - topCircle.width/4,
                                                    "y": topCircle.y + topCircle.height/2 - topCircle.height/4,
                                                    "maxDragY": root.y + root.height,
                                                    "maxDragX": root.x + root.width,
                                                    "hotSpotX": 0,
                                                    "hotSpotY": 0,
                                                    "z": 5
                                                })

                                    if (dynObj !== null) {
                                        dynObj.draggedItemPressed.connect(pressItem)
                                        dynObj.draggedItemReleased.connect(releaseItem)
                                    }
                                } else if (dynComp.status === Component.Error) {
                                    console.log("error while loading Rectangle")
                                } else {
                                    console.log("error while loading Rectangle!")
                                }
                            }
                        }

                        MouseArea {
                            id: upMouseArea

                            hoverEnabled: true
                            anchors.fill: parent
                        }
                    }
                    Rectangle {
                        id: bottomCircle

                        height: 100; width: height; radius: height/2
                        color: "transparent"
                        border.color: Gui.Colors.skinFrameTXT
                    }
                }
            }
        }
    }
}
