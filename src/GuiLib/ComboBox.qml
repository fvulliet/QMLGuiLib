import QtQuick 2.9
import GuiLib 1.0

Rectangle {
    id: root

    // public properties
    property var items
    property alias selectedItem: chosenItemText.text
    property alias selectedIndex: listView.currentIndex

    // signals
    signal comboClicked()

    // Rectangle properties
    smooth: true
    states: State {
        name: "dropDown"
        PropertyChanges {
            target: dropDown
            height: root.height*root.items.length
        }
    }
    transitions: Transition {
        NumberAnimation {
            target: dropDown; properties: "height"
            easing.type: Easing.OutExpo; duration: 500
        }
    }

    // inner components
    Rectangle {
        id: chosenItem

        radius: 4
        width: parent.width
        height: root.height
        color: Colors.skinFrameTXT
        smooth: true

        Text {
            id: chosenItemText

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            text: root.items[selectedIndex]
            font { family: Fonts.sfyFont; pixelSize: 14 }
            smooth: true
            color: Colors.skinFrameBGD
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.state = root.state === "dropDown"? "" : "dropDown"
            }
        }
    }

    Rectangle {
        id: dropDown

        width: parent.width
        height: 0
        clip: true
        radius: 4
        anchors.top: chosenItem.bottom
        anchors.margins: 2
        color: Colors.skinListBGD

        ListView {
            id: listView

            height: count*root.height
            width: parent.width
            model: root.items
            currentIndex: 0
            delegate: Item {
                width: ListView.view.width
                height: root.height

                Text {
                    text: modelData
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    font { family: Fonts.sfyFont; pixelSize: 14 }
                    smooth: true
                    color: Colors.skinFrameTXT
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        var prevSelection = chosenItemText.text
                        root.state = ""
                        chosenItemText.text = modelData
                        if (chosenItemText.text !== prevSelection)
                            root.comboClicked()
                        listView.currentIndex = index
                    }
                }
            }
        }
    }

    Component {
        id: highlight

        Rectangle {
            width: root.width
            height: root.height
            color: Colors.themeMainColor
            radius: 4
        }
    }
}

