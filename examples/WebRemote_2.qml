import QtQuick 2.9
import GuiLib 1.0 as Gui

Rectangle {
    id: root

    property alias model: grid.model
    property bool _wrDisplayed: false

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

            GridView {
                id: grid

                property int maxItemsPerLine: 2
                property int maxItemsPerColumn: 2

                visible: !_wrDisplayed
                anchors.fill: parent
                clip: true
                cellWidth: width/maxItemsPerLine
                cellHeight: height/maxItemsPerColumn
                interactive: count > (maxItemsPerLine * maxItemsPerColumn)
                boundsBehavior: Flickable.StopAtBounds
                delegate: Item {
                    width: GridView.view.cellWidth; height: GridView.view.cellHeight

                    Rectangle {
                        id: innerRect

                        property real _ratio: 1

                        anchors.centerIn: parent
                        width: parent.width - 5
                        height: parent.height - 5
                        color: Gui.Colors.skinFrameBGD
                        radius: 2

                        Gui.StandardText {
                            text: name
                            font.pixelSize: 20
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            webRemote.pos = position
                            _wrDisplayed = true
                        }
                    }
                }
            }
            Item {
                id: webRemote

                property alias pos: positionWidget.positionPCent

                anchors.fill: parent
                visible: _wrDisplayed

                Gui.AdvancedPositionWidget {
                    id: positionWidget

                    height: Math.min(parent.width*0.8, parent.height*0.8); width: height
                    anchors.centerIn: parent
                    markSize: 60
                }

                Item {
                    width: 50; height: width

                    Gui.FontIcon {
                        lib: Gui.Fonts.faSolid;
                        icon: Gui.FontAwesomeSolid.Icon.ArrowLeft
                        color: Gui.Colors.skinFrameTXT
                        size: parent.height*0.8
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: _wrDisplayed = false
                    }
                }
            }
        }
    }
}
