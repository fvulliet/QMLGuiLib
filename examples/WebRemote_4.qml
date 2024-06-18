import QtQuick 2.9
import GuiLib 1.0 as Gui

Rectangle {
    id: root

    property alias model: list.model

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

            ListView {
                id: list

                anchors {
                    fill: parent
                    leftMargin: 5; rightMargin: 5
                }
                currentIndex: 0
                orientation: Qt.Horizontal
                clip: true
                boundsBehavior: Flickable.StopAtBounds
                delegate: Loader {
                    id: wrLoader

                    width: ListView.view.width
                    height: ListView.view.height
                    sourceComponent: wrComp
                    onStatusChanged: {
                        if (status === Loader.Ready) {
                            item.name =  name
                            item.position = position
                            item.angle = angle
                        }
                    }

                    Connections {
                        ignoreUnknownSignals: true
                        target: wrLoader.item
                        onNext: {
                            if (list.currentIndex < (list.count-1))
                                list.currentIndex++
                            else
                                list.currentIndex = 0
                        }
                        onPrevious: {
                            if (list.currentIndex > 0)
                                list.currentIndex--
                            else
                                list.currentIndex = list.count-1
                        }
                    }
                }
            }
        }
    }

    Component {
        id: wrComp

        Row {
            id: rowCtnr

            signal next()
            signal previous()

            property int position
            property int angle
            property string name

            Item {
                width: 50; height: parent.height

                Gui.CarouselNav {
                    isLeft: true
                    width: parent.width
                    onPressed: rowCtnr.previous()
                }
            }
            Column {
                height: parent.height; width: parent.width-100

                Item {
                    width: parent.width; height: 40

                    Gui.StandardText {
                        id: widgetName

                        font.pixelSize: 20
                        text: rowCtnr.name
                    }
                }
                Item {
                    width: parent.width; height: parent.height - 40

                    Gui.AdvancedPositionWidget {
                        id: positionWidget

                        height: Math.min(parent.width*0.8, parent.height*0.8); width: height
                        anchors.centerIn: parent
                        markSize: 60
                        positionPCent: rowCtnr.position
                    }
                }
            }
            Item {
                width: 50; height: parent.height

                Gui.CarouselNav {
                    isLeft: false
                    width: parent.width
                    onPressed: rowCtnr.next()
                }
            }
        }
    }
}
