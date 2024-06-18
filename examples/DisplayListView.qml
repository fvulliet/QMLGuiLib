import QtQuick 2.9
import GuiLib 1.0


Page {
    id: root

    property alias model: view.model
    property alias delegate: view.delegate
    property string _trContext: "DisplayListView"

    anchors.fill: parent
    clip: true

    function bound(number, min, max) {
        return Math.max(Math.min(number, max), min)
    }

    Item {
        id: iconsSelector
        width: parent.width / 2; height: 40
        anchors {
            top: parent.top
            left: parent.left
        }

        ListView {
            id: iconsList
            property int itemWidth
            anchors.fill: parent
            orientation: Qt.Horizontal
            spacing: 10
            highlightFollowsCurrentItem: false
            currentIndex: 0

            Component.onCompleted: itemWidth = 50

            model: ListModel {
                Component.onCompleted: {
                    append({ libr: Fonts.faSolid, icn: FontAwesomeSolid.Icon.CircleArrowLeft });
                    append({ libr: Fonts.faSolid, icn: FontAwesomeSolid.Icon.CircleArrowUp });
                    append({ libr: Fonts.faSolid, icn: FontAwesomeSolid.Icon.CircleArrowRight })
                }
            }
            delegate: Rectangle {
                color: Colors.skinFrameBGD
                width: ListView.view.itemWidth; height: ListView.view.height
                FontIcon {
                    lib: libr; icon: icn
                    color: Colors.skinListTXT
                    Behavior on color { ColorAnimation { duration : 250 } }
                    size: parent.height
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        parent.ListView.view.currentIndex = index;
                        switch (index) {
                        case 1:
                            view.model = myModel1
                            break;
                        case 2:
                            view.model = myModel2
                            break;
                        default:
                            view.model = myModel
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
        }
    }

    Rectangle {
        id: header
        color: Colors.skinFrameFGD

        width: parent.width; height: 40
        anchors.top: iconsSelector.bottom
        anchors.topMargin: 20
        z: view.z + 2

        Rectangle {
            id: headerClipper
            color: root.color
            height: parent.height + 10
            width: parent.width + 20
            anchors {
                top: parent.top
                topMargin: -10
                left: parent.left
                leftMargin: -10
            }
            z: -1
            clip: true
        }

        Row {
            function childrenWidth() {
                var w = 0
                for (var child in children) {
                    if (children[child].visible === true)
                        w += children[child].width
                }
                return w
            }
            function childrenLength() {
                var l = 0
                for (var child in children) {
                    if (children[child].visible === true)
                        l += 1
                }
                return l
            }

            anchors { left: parent.left; right: parent.right;
                leftMargin: Style.stdMargin; rightMargin: Style.stdMargin }
            height: parent.height
            spacing: bound((width - childrenWidth()) / (childrenLength()-1), 0, 50)

            Item {
                width: 40; height: parent.height
                TrText { content: QT_TR_NOOP("ID"); context: _trContext
                    color: Colors.skinFrameTXT
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: Fonts.sfyFont; font.pixelSize: 16
                    font.weight: Font.Black }
            }
            Item {
                width: 40; height: parent.height
                TrText { content: QT_TR_NOOP("TYPE"); context: _trContext
                    color: Colors.skinFrameTXT
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: Fonts.sfyFont; font.pixelSize: 16
                    font.weight: Font.Black }
            }
            Item {
                width: 80; height: parent.height
                TrText { content: QT_TR_NOOP("LABEL"); context: _trContext
                    color: Colors.skinFrameTXT
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: Fonts.sfyFont; font.pixelSize: 16
                    font.weight: Font.Black }
            }
            Item {
                width: 40; height: parent.height
                TrText { content: QT_TR_NOOP("FACADE"); context: _trContext
                    color: Colors.skinFrameTXT
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: Fonts.sfyFont; font.pixelSize: 16
                    font.weight: Font.Black }
            }
        }
    }

    Hole {
        id: upperHole
        isUpperHole: true
        anchors.top: header.bottom
        flick: view
    }

    Item {
        id: listCtnr
        // create an item which avoids clipping the elevation glow
        clip: true
        property int _clipMargin: 20
        anchors {
            top: upperHole.bottom; bottom: parent.bottom
            left: parent.left; right: parent.right
            leftMargin: -_clipMargin; rightMargin: -_clipMargin
        }

        ListView {
            id: view

            property int itemHeight: 40

            contentWidth: width; contentHeight: count*itemHeight
            delegate: Rectangle {
                id: listDelegate

                property bool selected: false

                color: Colors.skinFrameFGD
                width: ListView.view.width; height: ListView.view.itemHeight

                ItemShadow {
                    id: focus
                    z: -1
                    anchors.fill: parent
                    elevation: 0
                }

                Row {
                    function childrenWidth() {
                        var w = 0
                        for (var child in children) {
                            if (children[child].visible === true)
                                w += children[child].width
                        }
                        return w
                    }
                    function childrenLength() {
                        var l = 0
                        for (var child in children) {
                            if (children[child].visible === true)
                                l += 1
                        }
                        return l
                    }

                    anchors { left: parent.left; right: parent.right;
                        leftMargin: Style.stdMargin; rightMargin: Style.stdMargin }
                    height: parent.height
                    spacing: bound((width - childrenWidth()) / (childrenLength()-1), 0, 50)

                    Item {
                        width: 40; height: parent.height
                        TrText { content: col1; context: _trContext
                            color: Colors.skinFrameTXT
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: Fonts.sfyFont; font.pixelSize: 14 }
                    }
                    Item {
                        width: 40; height: parent.height
                        TrText { content: col2; context: _trContext
                            color: Colors.skinFrameTXT
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: Fonts.sfyFont; font.pixelSize: 14 }
                    }
                    Item {
                        width: 80; height: parent.height
                        TrText { content: col3; context: _trContext
                            color: Colors.skinFrameTXT
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: Fonts.sfyFont; font.pixelSize: 14 }
                    }
                    Item {
                        width: 40; height: parent.height
                        TrText { content: col4; context: _trContext
                            color: Colors.skinFrameTXT
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: Fonts.sfyFont; font.pixelSize: 14 }
                    }
                }

                states: [
                    State {
                        name: "SELECTED"
                        when: listDelegate.selected
                        PropertyChanges {
                            target: listDelegate
                            elevation: 1
                            z: parent.z + 1
                        }
                    }
                ]

                Rectangle {
                    id: highlight
                    color: Colors.themeMainColor
                    height: parent.height; width: 4
                    anchors {
                        left: parent.left
                    }
                    opacity: listDelegate.selected ? 1 : 0
                    Behavior on opacity { NumberAnimation {} }
                    visible: opacity > 0
                }
            }

            model: myModel
            anchors { fill: parent; leftMargin: listCtnr._clipMargin;
                rightMargin: listCtnr._clipMargin }
            spacing: 3
            boundsBehavior: Flickable.StopAtBounds
            Behavior on contentY { NumberAnimation {} }
        }

        ScrollBar {
            flick: view
            withLift: true
        }
    }

    ListModel {
        id: myModel
        ListElement { col1: "12E70A"; col2: "Screen"; col3: "Meeting Room 1"; col4: "NW" }
        ListElement { col1: "23F81B"; col2: "Screen"; col3: "Meeting Room 1"; col4: "NW" }
        ListElement { col1: "34092C"; col2: "EVB"; col3: "Meeting Room 1"; col4: "NW" }
        ListElement { col1: "451A3D"; col2: "EVB"; col3: "Meeting Room 1"; col4: "NW" }
        ListElement { col1: "562B4E"; col2: "Roller"; col3: "Office 1"; col4: "S" }
        ListElement { col1: "673C4F"; col2: "Screen"; col3: "Office 2"; col4: "N" }
        ListElement { col1: "784D50"; col2: "Screen"; col3: "Office 3"; col4: "E" }
        ListElement { col1: "895E61"; col2: "EVB"; col3: "Office 4"; col4: "W" }
        ListElement { col1: "9A6F72"; col2: "Roller"; col3: "Office 5"; col4: "SW" }
        ListElement { col1: "AB7083"; col2: "Roller"; col3: "Office 5"; col4: "SW" }
        ListElement { col1: "12E70A"; col2: "Screen"; col3: "Meeting Room 1"; col4: "NW" }
        ListElement { col1: "23F81B"; col2: "Screen"; col3: "Meeting Room 1"; col4: "NW" }
        ListElement { col1: "34092C"; col2: "EVB"; col3: "Meeting Room 1"; col4: "NW" }
        ListElement { col1: "451A3D"; col2: "EVB"; col3: "Meeting Room 1"; col4: "NW" }
        ListElement { col1: "562B4E"; col2: "Roller"; col3: "Office 1"; col4: "S" }
        ListElement { col1: "673C4F"; col2: "Screen"; col3: "Office 2"; col4: "N" }
        ListElement { col1: "784D50"; col2: "Screen"; col3: "Office 3"; col4: "E" }
        ListElement { col1: "895E61"; col2: "EVB"; col3: "Office 4"; col4: "W" }
        ListElement { col1: "9A6F72"; col2: "Roller"; col3: "Office 5"; col4: "SW" }
        ListElement { col1: "AB7083"; col2: "Roller"; col3: "Office 5"; col4: "SW" }
        ListElement { col1: "12E70A"; col2: "Screen"; col3: "Meeting Room 1"; col4: "NW" }
        ListElement { col1: "23F81B"; col2: "Screen"; col3: "Meeting Room 1"; col4: "NW" }
        ListElement { col1: "34092C"; col2: "EVB"; col3: "Meeting Room 1"; col4: "NW" }
        ListElement { col1: "451A3D"; col2: "EVB"; col3: "Meeting Room 1"; col4: "NW" }
        ListElement { col1: "562B4E"; col2: "Roller"; col3: "Office 1"; col4: "S" }
        ListElement { col1: "673C4F"; col2: "Screen"; col3: "Office 2"; col4: "N" }
        ListElement { col1: "784D50"; col2: "Screen"; col3: "Office 3"; col4: "E" }
        ListElement { col1: "895E61"; col2: "EVB"; col3: "Office 4"; col4: "W" }
        ListElement { col1: "9A6F72"; col2: "Roller"; col3: "Office 5"; col4: "SW" }
        ListElement { col1: "AB7083"; col2: "Roller"; col3: "Office 5"; col4: "SW" }
    }

    ListModel {
        id: myModel1
        ListElement { col1: "12E70A"; col2: "Screen"; col3: "Meeting Room 1"; col4: "NW" }
        ListElement { col1: "23F81B"; col2: "Screen"; col3: "Meeting Room 1"; col4: "NW" }
        ListElement { col1: "34092C"; col2: "EVB"; col3: "Meeting Room 1"; col4: "NW" }
        ListElement { col1: "451A3D"; col2: "EVB"; col3: "Meeting Room 1"; col4: "NW" }
        ListElement { col1: "AB7083"; col2: "Roller"; col3: "Office 5"; col4: "SW" }
    }

    ListModel {
        id: myModel2
        ListElement { col1: "12E70A"; col2: "Screen"; col3: "Meeting Room 1"; col4: "NW" }
        ListElement { col1: "AB7083"; col2: "Roller"; col3: "Office 5"; col4: "SW" }
    }
}
