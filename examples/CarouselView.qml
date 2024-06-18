import QtQuick 2.9
import GuiLib 1.0 as Gui

Gui.Page {
    id: root

    property string _trContext: "CarouselView"

    anchors.fill: parent

    Gui.Layout_Standard {
        anchors.fill: parent
        title: qsTr("CAROUSEL"); trContext: _trContext
        iconLib: Gui.Fonts.faSolid; iconId: "\uf121"
        showNav: false

        scope: Item {
        }
        payload: Item {
            anchors.fill: parent

            Column {
                anchors.fill: parent

                Item {
                    width: parent.width; height: parent.height/2

                    Gui.Carousel {
                        id: carousel

                        anchors.fill: parent; anchors.margins: 40
                        color: Gui.Colors.skinFrameFGD
                        withViewer: true
                        showTips: true
                        viewerRatio: 1/15
                        Component.onCompleted: {
                            append(Qt.resolvedUrl("HB1.qml"), "1111")
                            append(Qt.resolvedUrl("HB2.qml"), "2222")
                            append(Qt.resolvedUrl("HB3.qml"), "3333")
                            currentPanelIndex = 0
                        }
                        onCurrentPanelIndexChanged: {
                            if (currentPanel !== undefined) {
                                currentPanel.update()
                            }
                        }
                    }
                }
                Item {
                    id: container

                    property int nbItems: 1

                    width: parent.width; height: parent.height/2

                    Column {
                        anchors.fill: parent; anchors.margins: 40

                        Row {
                            width: parent.width; height: 40

                            Item {
                                height: parent.height; width: parent.width/3

                                Gui.Button {
                                    height: parent.height; width: parent.width/4
                                    anchors.centerIn: parent
                                    text: "-"
                                    onClicked: {
                                        if (container.nbItems > 1) {
                                            container.nbItems--
                                            dynCarContainer.fillCarousel()
                                        }
                                    }
                                }
                            }
                            Item {
                                height: parent.height; width: parent.width/3

                                Text {
                                    anchors.centerIn: parent
                                    font {
                                        family: Gui.Fonts.sfyFont; pointSize: 14
                                    }
                                    color: Gui.Colors.skinFrameTXT
                                    text: container.nbItems
                                }
                            }
                            Item {
                                height: parent.height; width: parent.width/3

                                Gui.Button {
                                    height: parent.height; width: parent.width/4
                                    anchors.centerIn: parent
                                    text: "+"
                                    onClicked: {
                                        if (container.nbItems < 3) {
                                            container.nbItems++
                                            dynCarContainer.fillCarousel()
                                        }
                                    }
                                }
                            }
                        }
                        Item {
                            id: dynCarContainer

                            width: parent.width; height: parent.height - 40

                            function fillCarousel() {
                                dynCarousel.clearCarousel()
                                dynCarousel.append(0, Qt.resolvedUrl("HB1.qml"), "1111")

                                if (container.nbItems > 2) {
                                    dynCarousel.append(1, Qt.resolvedUrl("HB2.qml"), "2222")
                                    dynCarousel.append(2, Qt.resolvedUrl("HB3.qml"), "3333")
                                } else if (container.nbItems > 1) {
                                    dynCarousel.append(1, Qt.resolvedUrl("HB2.qml"), "2222")
                                }
                                dynCarousel.currentPanelIndex = 0
                            }

                            Connections {
                                target: container
                                onNbItemsChanged: dynCarContainer.fillCarousel()
                            }

                            Gui.Carousel {
                                id: dynCarousel

                                anchors.fill: parent
                                withViewer: true
                                showTips: true
                                viewerRatio: 1/15
                                Component.onCompleted: {
                                    clearCarousel()
                                    append(Qt.resolvedUrl("HB1.qml"), "1111")

                                    if (container.nbItems > 2) {
                                        append(Qt.resolvedUrl("HB2.qml"), "2222")
                                        append(Qt.resolvedUrl("HB3.qml"), "3333")
                                    } else if (container.nbItems > 1) {
                                        append(Qt.resolvedUrl("HB2.qml"), "2222")
                                    }
                                    currentPanelIndex = 0
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

