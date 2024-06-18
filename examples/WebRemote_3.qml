import QtQuick 2.9
import GuiLib 1.0 as Gui

Rectangle {
    id: root

    property alias model: list.model

    Connections {
        target: list
        onCurrentIndexChanged: {
            widgetName.text = model.get(list.currentIndex).name
            positionWidget.positionPCent = model.get(list.currentIndex).position
            angleWidget.angleDeg = model.get(list.currentIndex).angle
        }
    }

    Column {
        anchors.fill: parent

        Gui.MainMenu {
            id: viewHeader

            isVertical: false
            width: parent.width; height: 40
            canBeMinimized: false; animationSpeed: 400
            ctrlFont: Gui.Fonts.sfyFont
            selectionEnabled: false

            Item {
                height: parent.height; width: parent.width/2
                anchors.horizontalCenter: parent.horizontalCenter

                Gui.StandardText {
                    text: "Web Remote"
                    color: "white"
                    font.pixelSize: parent.height*3/4
                }
            }

            Column {
                height: parent.height; width: 2*height
                anchors.right: parent.right
                spacing: 2

                Item {
                    width: parent.width; height: (parent.height-parent.spacing)/2

                    Gui.FontIcon {
                        id: icon
                        lib: Gui.Fonts.faSolid; icon: Gui.FontAwesomeSolid.Icon.Profile
                        color: "white"
                        size: parent.height*0.8
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                    }
                }
                Item {
                    width: parent.width; height: (parent.height-parent.spacing)/2

                    Gui.StandardText {
                        verticalAlignment: Text.AlignTop
                        text: "toto"
                        color: "white"
                        font.pixelSize: parent.height*3/4
                    }
                }
            }
        }
        Item {
            width: parent.width; height: parent.height - viewHeader.height

            Gui.Extensible {
                id: extensible

                anchors {
                    fill: parent; margins: 10
                }
                scaleFactor: 0.33
                hiddenWhenCollapsed: true
                extended: false
                mainItem: Rectangle {
                    anchors.fill: parent

                    ListView {
                        id: list

                        property int itemHeight: 40
                        property bool navigable: count*itemHeight > height

                        anchors {
                            fill: parent
                            leftMargin: 5; rightMargin: 5
                        }
                        spacing: 3
                        boundsBehavior: Flickable.StopAtBounds
                        interactive: navigable
                        currentIndex: 0
                        delegate: Rectangle {
                            id: infoView

                            property bool selected: ListView.view.currentIndex === index

                            width: ListView.view.width
                            height: ListView.view.itemHeight
                            color: Gui.Colors.skinListBGD

                            Gui.StandardText {
                                text: name
                                font.pixelSize: 20
                            }

                            Rectangle {
                                id: highlight

                                color: Gui.Colors.themeMainColor
                                height: parent.height; width: 4
                                opacity: infoView.selected ? 1 : 0
                                Behavior on opacity { NumberAnimation {} }
                                visible: opacity > 0
                            }

                            MouseArea {
                                anchors.fill: parent
                                z: -1
                                onClicked: {
                                    list.currentIndex = index
                                    extensible.extended = true
                                }
                            }
                        }
                        Behavior on contentY {
                            NumberAnimation { easing.type: Easing.InOutQuad }
                        }
                    }

                    Gui.ScrollBar {
                        flick: list
                        withLift: false
                    }
                }
                extendedItem: Rectangle {
                    id: extendedCtnr

                    color: Gui.Colors.skinFrameFGD

                    Column {
                        anchors.fill: parent

                        Item {
                            width: parent.width; height: 40

                            Gui.StandardText {
                                id: widgetName

                                font.pixelSize: 20
                            }
                        }
                        Item {
                            width: parent.width; height: parent.height - 40

                            Column {
                                id: webRemote

                                anchors.fill: parent

                                Item {
                                    width: parent.width; height: (parent.height-actionCtnr.height)/2

                                    Gui.AdvancedPositionWidget {
                                        id: positionWidget

                                        height: Math.min(parent.width*0.8, parent.height*0.8); width: height
                                        anchors.centerIn: parent
                                        markSize: 60
                                    }
                                }
                                Item {
                                    width: parent.width; height: (parent.height-actionCtnr.height)/2

                                    Gui.AdvancedAngleWidget {
                                        id: angleWidget

                                        height: Math.min(parent.width*0.8, parent.height*0.8); width: height
                                        anchors.centerIn: parent
                                        markSize: 60
                                    }
                                }
                                Item {
                                    id: actionCtnr

                                    width: parent.width; height: 40

                                    Gui.Button {
                                        height: parent.height*0.8; width: parent.width/5
                                        anchors.centerIn: parent
                                        text: "Go"
                                    }
                                }
                            }
                        }
                    }
                }
                onCollapse: extensible.extended = false
            }
        }
    }
}
