import QtQuick 2.9
import GuiLib 1.0 as Gui

Gui.Page {
    id: root

    property string _trContext: "CarouselView"

    anchors.fill: parent

    Gui.Layout_Standard {
        anchors.fill: parent
        title: qsTr("SCOPE LIST"); trContext: _trContext
        iconLib: Gui.Fonts.faSolid
        iconId: Gui.FontAwesomeSolid.Icon.ThList
        showNav: false

        scope: Gui.ScopeList {
            caretHeight: 30
            isSearchable: false
            elementHeight: height/4
            currentIndex: 0
            model: ListModel {
                Component.onCompleted: {
                    for (var i=0; i<3; ++i)
                        append({ name: "zone"+i, isFiltered: false })
                }
            }
        }
        payload: Column {
            Item {
                width: parent.width; height: parent.height/2

                Gui.ScopeList {
                    anchors.fill: parent; anchors.margins: 10
                    caretHeight: 50
                    isSearchable: true
                    elementHeight: height/10
                    currentIndex: 0
                    fullNavigation: true
                    model: ListModel {
                        Component.onCompleted: {
                            for (var i=0; i<25; ++i) {
                                if (i%2 === 0)
                                    append({ name: "item"+i, isFiltered: false })
                                else
                                    append({ name: "meti"+i, isFiltered: false })
                            }
                        }
                    }
                }
            }
            Item {
                id: otherList

                function itemSelected(index, itemDeltaX, itemDeltaY) {

                }

                function itemPressed(index, itemDeltaX, itemDeltaY) {

                }

                width: parent.width; height: parent.height/2

                Column {
                    property bool _needsNavigation: list.contentHeight > list.height
                    property int elementHeight: 30
                    property int caretHeight: 30

                    anchors.fill: parent; anchors.margins: 20

                    Gui.ListScroller {
                        id: upScroller

                        width: parent.width; height: parent._needsNavigation ? parent.caretHeight : 0
                        upScroller: true
                        fullNavigation: true
                        hidden: list.topReached
                        onPrevious: list.previous()
                        onGoToTop: list.goToTop()
                    }
                    Gui.ListContent {
                        id: list

                        function itemSelected(index) {
                            console.log(index)
                        }

                        function itemPressed(index) {
                            console.log(index)
                        }

                        width: parent.width
                        height: parent.height - 2*parent.caretHeight - 3*parent.spacing
                        elementHeight: parent.elementHeight
                        borderRadius: 3
                        model: ListModel {
                            Component.onCompleted: {
                                for (var i=0; i<20; ++i)
                                    append({name: "toto"+i})
                            }
                        }
                        delegate: Item {
                            id: del

                            property bool selected: index === list.currentIndex

                            width: ListView.view.width; height: 30

                            Rectangle {
                                anchors.fill: parent; anchors.margins: 1
                                color: "lightgrey"
                                radius: 3

                                Item {
                                    id: itemText

                                    height: parent.height
                                    width: childrenRect.width
                                    anchors.centerIn: parent

                                    Text {
                                        height: parent.height
                                        verticalAlignment: Text.AlignVCenter
                                        font {
                                            pixelSize: 18; family: Gui.Fonts.sfyFont
                                        }
                                        color: del.selected ? Gui.Colors.skinFrameSelectedTXT : Gui.Colors.skinFrameTXT
                                        text: name
                                        Behavior on color { ColorAnimation { duration: 100 } }
                                    }
                                }
                            }

                            MouseArea {
                                id: mouseArea

                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    parent.ListView.view.currentIndex = index
                                    parent.ListView.view.itemSelected(index)
                                }
                                onPressed: {
                                    parent.ListView.view.currentIndex = index
                                    parent.ListView.view.itemPressed(index)
                                }
                            }
                        }
                    }
                    Gui.ListScroller {
                        id: downScroller

                        width: parent.width; height: parent._needsNavigation ? parent.caretHeight : 0
                        upScroller: false
                        fullNavigation: true
                        hidden: list.bottomReached
                        onNext: list.next()
                        onGoToBottom: list.goToBottom()
                    }
                }
            }
        }
    }
}

