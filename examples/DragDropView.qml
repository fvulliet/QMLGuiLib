import QtQuick 2.0
import QtQml.Models 2.1
import GuiLib 1.0 as Gui

Item {
    id: root

    property string _trContext: "DragDropView"

    DemoHeader {
        id: header

        width: parent.width; height: parent.height / 15
        anchors.top: parent.top
        title: QT_TR_NOOP("DRAG'N'DROP"); trContext: _trContext
    }

    Item {
        id: mainCtnr

        anchors {
            top: header.bottom; topMargin: Gui.Style.stdMargin
            bottom: parent.bottom; bottomMargin: Gui.Style.stdMargin
        }
        width: parent.width

        Component {
            id: dragDelegate

            MouseArea {
                id: dragArea

                property bool held: false

                anchors { left: parent.left; right: parent.right }
                height: content.height

                drag.target: held ? content : undefined
                drag.axis: Drag.YAxis

                onPressAndHold: held = true
                onReleased: held = false

                Rectangle {
                    id: content

                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }
                    width: dragArea.width/2; height: column.implicitHeight + 4

                    border.width: 1
                    border.color: Gui.Colors.skinMenuBGD

                    color: dragArea.held ? Gui.Colors.skinMenuBGD : Gui.Colors.skinFrameFGD
                    Behavior on color { ColorAnimation { duration: 100 } }

                    radius: 2
                    Drag.active: dragArea.held
                    Drag.source: dragArea
                    Drag.hotSpot.x: width / 2
                    Drag.hotSpot.y: height / 2
                    states: State {
                        when: dragArea.held

                        ParentChange { target: content; parent: root }
                        AnchorChanges {
                            target: content
                            anchors { horizontalCenter: undefined; verticalCenter: undefined }
                        }
                    }

                    Column {
                        id: column
                        anchors { fill: parent; margins: 2 }

                        Text { text: 'Name: ' + name }
                        Text { text: 'Type: ' + type }
                        Text { text: 'Age: ' + age }
                        Text { text: 'Size: ' + size }
                    }
                }
                DropArea {
                    anchors { fill: parent; margins: 10 }

                    onEntered: {
                        visualModel.items.move(
                                    drag.source.DelegateModel.itemsIndex,
                                    dragArea.DelegateModel.itemsIndex)
                    }
                }
            }
        }

        DelegateModel {
            id: visualModel

            model: ListModel {
                ListElement {
                    name: "Polly"
                    type: "Parrot"
                    age: 12
                    size: "Small"
                }
                ListElement {
                    name: "Penny"
                    type: "Turtle"
                    age: 4
                    size: "Small"
                }
                ListElement {
                    name: "Felix"
                    type: "Cat"
                    age: 18
                    size: "Small"
                }
                ListElement {
                    name: "Danny"
                    type: "Dog"
                    age: 12
                    size: "Big"
                }
            }
            delegate: dragDelegate
        }

        ListView {
            id: view

            anchors { fill: parent; margins: 2 }
            model: visualModel
            spacing: 4
        }
    }
}



