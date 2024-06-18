import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public preperties
    property int caretHeight: 40
    property alias model: list.model
    property alias isSearchable: search.visible
    property bool isDraggable: false
    property color dragColor: Colors.skinFrameBGD
    property alias currentIndex: list.currentIndex
    property alias currentItem: list.currentItem
    property bool fullNavigation: false
    property bool showHighlight: true
    property real elementHeight: 25
    property bool interactive: true
    property string ctrlFont: Fonts.sfyFont
    property int borderRadius: 3
    property bool animateHighlight: false

    // signals
    signal itemSelected(int index, real itemDeltaX, real itemDeltaY)
    signal itemPressed(int index, real itemDeltaX, real itemDeltaY)
    signal setFilter(string filter)

    // inner components
    Column {
        anchors {
            fill: parent
            leftMargin: caretHeight/2; rightMargin: caretHeight/2
        }
        spacing: 0

        Item {
            id: search

            visible: true
            height: visible ? caretHeight : 0; width: parent.width

            Rectangle {
                anchors {
                    fill: parent; margins: 1
                }
                border {
                    color: Colors.skinFrameTXT; width: 2
                }
                radius: 5

                Row {
                    anchors.fill: parent
                    anchors.margins: 3

                    Item {
                        height: parent.height
                        width: parent.width - searchIcon.width

                        TextInput {
                            anchors {
                                fill: parent; margins: 2
                            }
                            font {
                                family: Fonts.sfyFont
                                pixelSize: parent.height * 2/3
                            }
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            cursorPosition: 0
                            color: Colors.skinFrameTXT
                            selectionColor: Colors.skinFrameTXT
                            selectedTextColor: Colors.themeMainColor
                            clip: true
                            onTextChanged: {
                                setFilter(text)
//                                for (var i=0 ; i<model.count ; ++i) {
//                                    var reg = new RegExp(text)
//                                    if(reg.test(model.get(i).name))
//                                        model.get(i).isFiltered = false
//                                    else
//                                        model.get(i).isFiltered = true
//                                }
                            }
                        }
                    }
                    Item {
                        id: searchIcon

                        height: parent.height; width: height*1.5

                        FontIcon {
                            anchors.centerIn: parent
                            lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.Search
                            color: Colors.skinMenuBGD
                            size: parent.height * 0.9
                        }
                    }
                }
            }
        }
        Row {
            width: parent.width; height: caretHeight

            Item {
                id: singleChevronUp

                visible: width > 0
                height: parent.height
                width: fullNavigation ? parent.width/2 : 0
                opacity: list.topReached ? 0 : 1
                Behavior on opacity { NumberAnimation { } }

                FontIcon {
                    id: upIcon

                    lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.AngleUp
                    color: Colors.skinFrameTXT
                    size: parent.height
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    enabled: singleChevronUp.opacity > 0
                    cursorShape: singleChevronUp.opacity > 0 ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onPressed: upIcon.color = Colors.skinFrameFGD
                    onReleased: {
                        upIcon.color = Colors.skinFrameTXT
                        list.previous()
                    }
                }
            }
            Item {
                id: doubleChevronUp

                height: parent.height
                width: fullNavigation ? parent.width/2 : parent.width
                opacity: list.topReached ? 0 : 1
                Behavior on opacity { NumberAnimation { } }

                FontIcon {
                    id: doubleUpIcon

                    lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.AngleDoubleUp
                    color: Colors.skinFrameTXT
                    size: parent.height
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    enabled: doubleChevronUp.opacity > 0
                    cursorShape: doubleChevronUp.opacity > 0 ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onPressed: doubleUpIcon.color = Colors.skinFrameFGD
                    onReleased: {
                        doubleUpIcon.color = Colors.skinFrameTXT
                        list.goToTop()
                    }
                }
            }
        }
        ListView {
            id: list

            property bool topReached: contentY <= 0
            property bool bottomReached: (contentY + height) >= (contentHeight - 0.1)

            function goToTop() {
                contentY = 0
            }

            function goToBottom() {
                contentY = contentHeight - height - 0.1
            }

            function previous() {
                contentY -= elementHeight
                if (topReached)
                    goToTop()
            }

            function next() {
                contentY += elementHeight
                if (bottomReached)
                    goToBottom()
            }

            width: parent.width
            height: parent.height - search.height - 2*caretHeight - 3*parent.spacing
            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.StopAtBounds
            clip: true
            currentIndex: -1
            highlightFollowsCurrentItem: false
            //if the listview height is less than the enclosing parent,
            // for usability concerns you should disable the scroll behavior
            interactive: root.interactive && (contentHeight/height) > 1 ?
                             true : false
            Behavior on contentY { NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutCirc
                }
            }
            delegate: Item {
                id: del

                property bool isSelected: list.currentIndex === index

                width: ListView.view.width
                height: elementHeight
                visible: height > 0

                Rectangle {
                    anchors {
                        fill: parent
                        margins: 1
                    }
                    color: isDraggable ? dragColor : "transparent"
                    radius: borderRadius

                    Item {
                        height: parent.height; width: height
                        visible: isDraggable

                        FontIcon {
                            anchors.centerIn: parent
                            color: del.isSelected ? Colors.themeMainColor : Colors.skinFrameTXT
                            lib: Fonts.faSolid
                            icon: del.isSelected ? FontAwesomeSolid.Icon.Grab : FontAwesomeSolid.Icon.HandPaper
                            size: parent.height * 3/4
                        }
                    }

                    Item {
                        id: itemText

                        height: parent.height
                        width: childrenRect.width
                        anchors.centerIn: parent

                        Text {
                            height: parent.height
                            verticalAlignment: Text.AlignVCenter
                            font {
                                pixelSize: 18; family: root.ctrlFont
                            }
                            color: showHighlight && (del.ListView.view.currentIndex === index) ?
                                       Colors.skinFrameSelectedTXT : Colors.skinFrameTXT
                            Behavior on color { ColorAnimation { duration: 100 } }
                            text: name
                        }
                    }
                }

                MouseArea {
                    id: mouseArea

                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        list.currentIndex = index
                        itemSelected(index, list.x, list.y + index*elementHeight - list.contentY)
                    }
                    onPressed: {
                        list.currentIndex = index
                        itemPressed(index, list.x, list.y + index*elementHeight - list.contentY)
                    }
                }
            }
            highlight: Rectangle {
                property int margin: 0

                radius: borderRadius
                color: showHighlight ? Colors.skinFrameTXT : "transparent"
                width: list.currentItem.width - 2*margin; height: list.currentItem.height - 2*margin
                x: list.currentItem.x + margin
                y: list.currentItem.y + margin
                Behavior on y {
                    enabled: animateHighlight
                    NumberAnimation { easing.type: Easing.InOutQuad }
                }
            }
        }
        Row {
            width: parent.width; height: caretHeight

            Item {
                id: singleChevronDown

                visible: width > 0
                height: parent.height
                width: fullNavigation ? parent.width/2 : 0
                opacity: list.bottomReached ? 0 : 1
                Behavior on opacity { NumberAnimation { } }

                FontIcon {
                    id: downIcon

                    lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.AngleDown
                    color: Colors.skinFrameTXT
                    size: parent.height
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    enabled: singleChevronDown.opacity > 0
                    cursorShape: singleChevronDown.opacity > 0 ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onPressed: downIcon.color = Colors.skinFrameFGD
                    onReleased: {
                        downIcon.color = Colors.skinFrameTXT
                        list.next()
                    }
                }
            }
            Item {
                id: doubleChevronDown

                height: parent.height
                width: fullNavigation ? parent.width/2 : parent.width
                opacity: list.bottomReached ? 0 : 1
                Behavior on opacity { NumberAnimation { } }

                FontIcon {
                    id: doubleDownIcon

                    lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.AngleDoubleDown
                    color: Colors.skinFrameTXT
                    size: parent.height
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    enabled: doubleChevronDown.opacity > 0
                    cursorShape: doubleChevronDown.opacity > 0 ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onPressed: doubleDownIcon.color = Colors.skinFrameFGD
                    onReleased: {
                        doubleDownIcon.color = Colors.skinFrameTXT
                        list.goToBottom()
                    }
                }
            }
        }
    }
}
