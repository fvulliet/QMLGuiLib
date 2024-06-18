import QtQuick 2.9
import GuiLib 1.0


Page {
    id: inlineListView

    property string _trContext: "InlineListView"

    anchors.fill: parent

    Layout_Standard {
        anchors.fill: parent
        title: QT_TR_NOOP("INLINE"); trContext: _trContext
        iconLib: Fonts.faSolid
        iconId: FontAwesomeSolid.Icon.ListAlt
        showNav: false

        scope: Item {}
        payload: Rectangle {
            anchors.fill: parent
            id: bkgd
            color: Colors.skinFrameFGD

            Item {
                id: iconsSelector
                width: parent.width * 0.75; height: 40
                anchors {
                    top: parent.top; topMargin: 50
                    horizontalCenter: parent.horizontalCenter
                }

                ListView {
                    id: iconsList
                    property int itemWidth
                    anchors.fill: parent
                    orientation: Qt.Horizontal
                    spacing: 10
                    highlightFollowsCurrentItem: false
                    currentIndex: 0
                    interactive: false

                    Component.onCompleted: itemWidth = 80

                    model: ListModel {
                        Component.onCompleted: {
                            append({ libr: Fonts.faSolid, icn: FontAwesomeSolid.Icon.CircleArrowLeft, txt: "A" });
                            append({ libr: Fonts.faSolid, icn: FontAwesomeSolid.Icon.CircleArrowRight, txt: "B" })
                        }
                    }
                    delegate: Item {
                        width: ListView.view.itemWidth; height: ListView.view.height
                        Text {
                            anchors.centerIn: parent
                            font {
                                family: Fonts.sfyFont; pointSize: parent.height * 0.75
                            }
                            color: Colors.skinFrameTXT
                            text: txt
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                parent.ListView.view.currentIndex = index;
                                switch (index) {
                                case 1:
                                    view.model = myModel0
                                    break;
                                default:
                                    view.model = myModel1
                                }
                            }
                        }
                    }

                    highlight: Rectangle {
                        height: 4; width: iconsList.itemWidth
                        color: Colors.themeMainColor
                        visible: iconsList.currentIndex >= 0
                        opacity: 0
                        x: visible ? (iconsList.currentItem.x + ((iconsList.currentItem.width-width)/2)) : 0
                        y: visible ? iconsList.currentItem.height : 0

                        Component.onCompleted: opacity = 1

                        Behavior on x { NumberAnimation { easing.type: Easing.InOutQuad } }
                        Behavior on opacity { NumberAnimation {} }
                    }

                    ListModel {
                        id: myModel0
                        ListElement { col1: "12E70A"; col2: "Screen"; col3: "Meeting Room 1"; col4: "NW" }
                        ListElement { col1: "448721"; col2: "Roller"; col3: "Meeting Room 2"; col4: "S" }
                        ListElement { col1: "34092C"; col2: "EVB"; col3: "Meeting Room 1"; col4: "NW" }
                        ListElement { col1: "AB7083"; col2: "Roller"; col3: "Office 5"; col4: "SW" }
                    }

                    ListModel {
                        id: myModel1
                        ListElement { col1: "12E70A"; col2: "Screen"; col3: "Meeting Room 1"; col4: "N" }
                        ListElement { col1: "23F81B"; col2: "Screen"; col3: "Meeting Room 1"; col4: "NW" }
                        ListElement { col1: "451A3D"; col2: "EVB"; col3: "Meeting Room 1"; col4: "NW" }
                        ListElement { col1: "AB7083"; col2: "Screen"; col3: "Office 5"; col4: "SE" }
                    }
                }
            }

            Rectangle {
                id: header
                color: Colors.skinListBGD

                width: iconsSelector.width; height: 40
                anchors {
                    top: iconsSelector.bottom; topMargin: 20
                    left: iconsSelector.left
                }
                z: view.z + 2

                Row {
                    anchors.fill: parent
                    Item {
                        width: parent.width/2; height: parent.height
                        TrText { content: QT_TR_NOOP("ID"); context: _trContext
                            color: Colors.skinListTXT
                            anchors.centerIn: parent
                            font.family: Fonts.sfyFont; font.pixelSize: 16
                            font.weight: Font.Black }
                    }
                    Item {
                        width: parent.width/2; height: parent.height
                        TrText { content: QT_TR_NOOP("TYPE"); context: _trContext
                            color: Colors.skinListTXT
                            anchors.centerIn: parent
                            font.family: Fonts.sfyFont; font.pixelSize: 16
                            font.weight: Font.Black }
                    }
                }
            }

            Item {
                id: listCtnr

                property int listSpacing: 3

                width: header.width
                anchors {
                    top: header.bottom; topMargin: listSpacing
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                }

                ListView {
                    id: view

                    property int itemHeight: 40
                    property real contentHeight: count*itemHeight

                    anchors.fill: parent
                    model: myModel0
                    spacing: parent.listSpacing
                    delegate: Rectangle {
                        id: listElt
                        color: Colors.skinListBGD
                        height: ListView.view.itemHeight
                        width: ListView.view.width

                        Row {
                            anchors.fill: parent
                            Item {
                                width: parent.width/2; height: parent.height
                                TrText { content: col1; context: _trContext
                                    color: Colors.skinListTXT;
                                    anchors.centerIn: parent
                                    font.family: Fonts.sfyFont; font.pixelSize: 14 }
                            }
                            Item {
                                width: parent.width/2; height: parent.height
                                TrText { content: col2; context: _trContext
                                    color: Colors.skinListTXT;
                                    anchors.centerIn: parent
                                    font.family: Fonts.sfyFont; font.pixelSize: 14 }
                            }
                        }
                    }
                }
            }
        }
    }
}
