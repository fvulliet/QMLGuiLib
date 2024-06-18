import QtQuick 2.9
import GuiLib 1.0 as Gui


Gui.Page {
    id: root

    property int _itemHeight: 40
    property alias _navigable: list.navigable

    anchors.fill: parent
    color: Gui.Colors.skinFrameBGD

    Gui.Extensible {
        id: extensible

        anchors.fill: parent
        scaleFactor: 0.5
        hiddenWhenCollapsed: true
        mainItem: Rectangle {
            id: usedCtnr

            anchors.fill: parent
            color: root.color

            Rectangle {
                id: listTaskBar

                color: Gui.Colors.skinFrameFGD
                height: list.itemHeight; width: parent.width

                Gui.TaskBarAction {
                    id: plusAction

                    lib: Gui.Fonts.faSolid
                    icon: Gui.FontAwesomeSolid.Icon.PlusSign
                    color: Gui.Colors.skinFrameTXT
                    onActionClicked: {
                        extensible.extended = true
                    }

                    Component.onCompleted: taskbar.registerAction(plusAction)
                    Component.onDestruction: taskbar.unregisterAction(plusAction)
                }

                Gui.TaskBarAction {
                    id: filterAction

                    lib: Gui.Fonts.faSolid
                    icon: Gui.FontAwesomeSolid.Icon.Filter
                    color: Gui.Colors.skinFrameTXT
                    onActionClicked: {
                        extensible.extended = true
                    }

                    Component.onCompleted: taskbar.registerAction(filterAction)
                    Component.onDestruction: taskbar.unregisterAction(filterAction)
                }

                Row {
                    anchors.fill: parent

                    Item {
                        height: parent.height; width: height

                        Text {
                            anchors.centerIn: parent
                            text: list.count
                            color: Gui.Colors.skinFrameTXT
                            font {
                                family: Gui.Fonts.sfyFont
                                pixelSize: list.count < 100 ? 12 : list.count < 1000 ? 11 : 10
                            }
                        }
                    }
                    Gui.ListTaskBar {
                        id: taskbar

                        height: parent.height; width: parent.width-height
                        z: header.z + 1
                        color: Gui.Colors.skinHeaderBGD
                        taskbarTitle: "ITEM" + (list.count > 1 ? "S" : "")
                    }
                }
            }

            Gui.TiltingHeader {
                id: header

                height: list.itemHeight
                anchors {
                    top: listTaskBar.bottom;
                    topMargin: 3*list.spacing
                }
                z: list.z + 2
                tilt: list.visibleArea.yPosition > 0

                Row {
                    id: headerRow

                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    height: parent.height
                    spacing: bound((width - childrenWidth()) / (childrenLength()-1), 0, 50)

                    function bound(number, min, max) {
                        return Math.max(Math.min(number, max), min)
                    }

                    function childrenWidth() {
                        var w=0
                        for (var child in children) {
                            if (children[child].visible)
                                w += children[child].width
                        }
                        return w
                    }

                    function childrenLength() {
                        var l=0
                        for (var child in children) {
                            if (children[child].visible)
                                l += 1
                        }
                        return l
                    }

                    Gui.TableHeaderItem {
                        id: colAddress

                        text: "Address"
                        minColWidth: 50
                        canSort: false
                        font.family: Gui.Fonts.sfyFont
                        textColor: Gui.Colors.skinHeaderTXT
                    }
                    Gui.TableHeaderItem {
                        id: colType

                        text: "Type"
                        minColWidth: 50
                        canSort: false
                        font.family: Gui.Fonts.sfyFont
                        textColor: Gui.Colors.skinHeaderTXT
                    }
                    Gui.TableHeaderItem {
                        id: colLabel

                        text: "Label"
                        minColWidth: 50
                        canSort: false
                        font.family: Gui.Fonts.sfyFont
                        textColor: Gui.Colors.skinHeaderTXT
                        visible: !extensible.extended
                                 && !extensible.animationIsRunning
                    }
                    Gui.TableHeaderItem {
                        id: colOrientation

                        text: "Orientation"
                        minColWidth: 50
                        canSort: false
                        font.family: Gui.Fonts.sfyFont
                        textColor: Gui.Colors.skinHeaderTXT
                        visible: !extensible.extended
                                 && !extensible.animationIsRunning
                    }
                }
            }

            Gui.Hole {
                id: upperHole

                isUpperHole: true
                anchors.top: header.bottom
                flick: list
            }

            Item {
                anchors {
                    top: upperHole.bottom; bottom: parent.bottom
                    left: parent.left; leftMargin: -usedCtnr.anchors.leftMargin
                }
                width: root.width
                clip: true

                ListView {
                    id: list

                    property int itemHeight: _itemHeight
                    property bool navigable: count*itemHeight > height

                    anchors {
                        fill: parent
                        leftMargin: 5; rightMargin: 5
                    }
                    spacing: 3
                    boundsBehavior: Flickable.StopAtBounds
                    interactive: navigable
                    currentIndex: 0
                    model: myModel
                    delegate: Rectangle {
                        id: infoView

                        property bool selected: ListView.view.currentIndex === index

                        width: ListView.view.width
                        height: ListView.view.itemHeight
                        color: Gui.Colors.skinFrameFGD

                        states: State {
                            name: "SELECTED"
                            when: infoView.selected
                            PropertyChanges {
                                target: focus
                                elevation: 1
                            }
                            PropertyChanges {
                                target: infoView
                                z: parent.z + 1
                            }
                        }

                        Gui.ItemShadow {
                            id: focus

                            z: -1
                            height: parent.height+1; width: parent.width+1
                            anchors.horizontalCenter: parent.horizontalCenter

                            elevation: 0
                            anchors.horizontalCenterOffset: 1
                        }

                        Gui.TableContentItem {
                            id: infoViewAddress

                            header: colAddress
                            text: col1
                            font {
                                family: Gui.Fonts.sfyFont
                                capitalization: Font.AllUppercase
                                bold: true
                            }
                            textColor: Gui.Colors.skinFrameTXT
                            visible: colAddress.visible
                        }

                        Gui.TableContentItem {
                            id: infoViewType

                            header: colType
                            font.family: Gui.Fonts.sfyFont
                            text: col2
                            textColor: Gui.Colors.skinFrameTXT
                            visible: colType.visible
                        }

                        Gui.TableContentItem {
                            id: infoViewLabel

                            header: colLabel
                            text: col3
                            font.family: Gui.Fonts.sfyFont
                            font.capitalization: Font.AllUppercase
                            textColor: Gui.Colors.skinFrameTXT
                            visible: colLabel.visible
                        }

                        Gui.TableContentItem {
                            id: infoViewOrientation

                            header: colOrientation
                            text: col3
                            font.family: Gui.Fonts.sfyFont
                            textColor: Gui.Colors.skinFrameTXT
                            visible: colOrientation.visible
                        }

                        MouseArea {
                            anchors.fill: parent
                            z: -1
                            onClicked: {
                                //showContent()
                                list.currentIndex = index
                            }
                        }

                        Rectangle {
                            id: highlight

                            color: Gui.Colors.themeMainColor
                            height: parent.height; width: 4
                            opacity: infoView.selected ? 1 : 0
                            Behavior on opacity { NumberAnimation {} }
                            visible: opacity > 0
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

            Column {
                id: navigation

                width: parent.width; height: _navigable ? list.spacing + _itemHeight : 0
                anchors.bottom: parent.bottom

                Item {
                    width: parent.width; height: list.spacing
                }
                Rectangle {
                    width: parent.width; height: _itemHeight
                    color: Gui.Colors.skinMenuBGD

                    Row {
                        anchors.fill: parent

                        Item {
                            id: leftCtnr

                            property real scale: 1

                            height: parent.height; width: height

                            Gui.FontIcon {
                                id: leftIcon

                                anchors.centerIn: parent
                                lib: Gui.Fonts.faSolid
                                icon: Gui.FontAwesomeSolid.Icon.ChevronLeft
                                color: Gui.Colors.themeMainColor
                                size: parent.scale * parent.height * 0.9
                                states: [
                                    State {
                                        when: leftArea.pressed
                                        PropertyChanges {
                                            target: leftCtnr
                                            scale: 0.9
                                        }
                                    }
                                ]
                                transitions: [
                                    Transition {
                                        PropertyAnimation {
                                            property: " scale"; duration: 100
                                            easing.type: Easing.InOutQuad
                                        }
                                    }
                                ]
                            }

                            MouseArea {
                                id: leftArea

                                anchors.fill: parent
                                //onClicked: previous()
                            }
                        }
                        Item {
                            height: parent.height; width: parent.width - 2*height
                        }
                        Item {
                            id: rightCtnr

                            property real scale: 1

                            height: parent.height; width: height

                            Gui.FontIcon {
                                id: rightIcon

                                anchors.centerIn: parent
                                lib: Gui.Fonts.faSolid
                                icon: Gui.FontAwesomeSolid.Icon.ChevronRight
                                color: Gui.Colors.themeMainColor
                                size: parent.scale * parent.height * 0.9
                                states: [
                                    State {
                                        when: rightArea.pressed
                                        PropertyChanges {
                                            target: rightCtnr
                                            scale: 0.9
                                        }
                                    }
                                ]
                                transitions: [
                                    Transition {
                                        PropertyAnimation {
                                            property: "scale"; duration: 100
                                            easing.type: Easing.InOutQuad
                                        }
                                    }
                                ]
                            }

                            MouseArea {
                                id: rightArea

                                anchors.fill: parent
                                //onClicked: previous()
                            }
                        }
                    }
                }
            }
        }
        extendedItem: Rectangle {
            id: extendedCtnr

            color: Gui.Colors.skinFrameFGD

            Column {
                anchors.fill: parent

                Gui.ActionsMenuHeader {
                    width: parent.width; height: 2*30
                    lib: Gui.Fonts.faSolid
                    icon: Gui.FontAwesomeSolid.Icon.Filter
                    text: "FILTERS"
                    ctrlFont: Gui.Fonts.sfyFont
                }
                Item {
                    width: parent.width
                    height: parent.height - 2*30

                }
            }
        }
        onCollapse: extensible.extended = false
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
}

