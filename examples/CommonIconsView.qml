import QtQuick 2.9
import GuiLib 1.0


Page {
    id: iconsView

    property string _trContext: "CommonIconsView"

    anchors.fill: parent

    CommonIconsModel {
        id: myIconsModel
    }

    Layout_Standard {
        anchors.fill: parent
        //: "common deals" with icons
        //: will be somehow rendered with capital letters
        title: QT_TR_NOOP("common"); trContext: _trContext
        iconLib: Fonts.faSolid; iconId: FontAwesomeSolid.Icon.Joomla
        showNav: false

        scope: Item {
            id: iconPresenter
            anchors.fill: parent

            property real iconRatio: 0.75

            function display(name, id, lib) {
                presentedName.text = name
                if (id.length <= 0)
                    presentedId.text = "?"
                else
                    presentedId.text = id.charCodeAt(0).toString(16)
                presentedLib.text = lib
                presentedIcon.lib = lib
                presentedIcon.icon = id
            }

            Item {
                width: parent.width; height: parent.height * parent.iconRatio
                anchors.top: parent.top
                FontIcon {
                    id: presentedIcon
                    anchors.centerIn: parent
                    color: Colors.themeMainColor
                    size: parent.height * 0.95
                }
            }

            Item {
                id: presentation
                width: parent.width; height: parent.height * (1-parent.iconRatio)
                anchors.bottom: parent.bottom
                Column {
                    anchors.fill: parent
                    Item {
                        height: presentation.height/3; width: parent.width
                        Text {
                            id: presentedName
                            anchors.centerIn: parent
                            color: Colors.skinFrameTXT
                            font { pointSize: 14; family: Fonts.sfyFont }
                        }
                    }
                    Item {
                        height: presentation.height/3; width: parent.width
                        Text {
                            id: presentedId
                            anchors.centerIn: parent
                            color: Colors.skinFrameTXT
                            font { pointSize: 10; family: Fonts.sfyFont;
                                weight: Font.Black }
                        }
                    }
                    Item {
                        height: presentation.height/3; width: parent.width
                        Text {
                            id: presentedLib
                            anchors.centerIn: parent
                            color: Colors.skinFrameTXT
                            font { family: Fonts.sfyFont; pointSize: 8;
                                capitalization: Font.AllUppercase }
                        }
                    }
                }
            }
        }
        payload: Item {
            id: gridCtn
            anchors.fill: parent
            clip: true

            Item {
                anchors.fill: parent
                anchors.margins: 25

                Flickable {
                    anchors.fill: parent
                    interactive: true

                    ListView {
                        id: listOfMenus
                        anchors.fill: parent

                        model: ListModel {
                            id: category
                            Component.onCompleted: {
                                category.append({ myTitle: "1", myModel: myIconsModel.one });
                            }
                        }
                        delegate: Column {
                            width: ListView.view.width;
                            Item {
                                width: parent.width; height: 15
                                Text {
                                    anchors { left: parent.left; verticalCenter: parent.verticalCenter }
                                        font { pointSize: 9; family: Fonts.sfyFont }
                                    text: myTitle; color: Colors.skinFrameTXT
                                }
                            }
                            Rectangle {
                                color: Colors.skinFrameTXT
                                width: parent.width; height: 1
                            }

                            GridView {
                                id: grid
                                property int maxItemsPerLine: 7
                                property bool hovered: false

                                width: parent.width; interactive: false
                                height: {
                                    var mult = 1
                                    if (hovered) mult = 1.1

                                    return mult * ((parent.width/maxItemsPerLine) +
                                                   (parent.width/maxItemsPerLine) *
                                                   Math.floor(model.count/maxItemsPerLine - (1/maxItemsPerLine)))
                                }
                                Behavior on height { NumberAnimation { duration: 250 } }
                                cellWidth: width / maxItemsPerLine; cellHeight: cellWidth

                                model: myModel
                                delegate: Item {
                                    id: eltDelegate
                                    property int indexOfThisDelegate: index

                                    height: GridView.view.cellWidth; width: height

                                    onStateChanged: {
                                        if (state === "HOVERED") {
                                            GridView.view.hovered = true
                                        } else {
                                            GridView.view.hovered = false
                                        }
                                    }
                                    Text {
                                        id: eltText
                                        visible: opacity > 0
                                        anchors {
                                            top: eltIcon.bottom; topMargin: 2
                                            horizontalCenter: parent.horizontalCenter
                                        }
                                                font { pointSize: 9; family: Fonts.sfyFont;
                                            italic: model.valid ? false:true
                                        }
                                        text: model.iconName
                                        color: eltIcon.color
                                    }
                                    Text {
                                        id: eltLib
                                        visible: opacity > 0
                                        anchors {
                                            top: eltText.bottom; topMargin: 2
                                            horizontalCenter: parent.horizontalCenter
                                        }
                                                font { pointSize: 7; family: Fonts.sfyFont; weight: Font.Black
                                            italic: model.valid ? false:true;
                                        }
                                        text: {
                                            var str = model.iconId
                                            if (str.length <= 0) {
                                                return "?"
                                            } else {
                                                return str.charCodeAt(0).toString(16)
                                            }
                                        }
                                        color: eltIcon.color
                                    }
                                    FontIcon {
                                        id: eltIcon
                                        lib: model.iconLib; icon: model.iconId
                                        color: Colors.skinFrameTXT
                                        size: parent.height / 2; scale: 1
                                        transformOrigin: {
                                            var i = Math.floor(indexOfThisDelegate / (parent.GridView.view.maxItemsPerLine/2)) % 2
                                            if (i === 0)
                                                return Item.TopLeft
                                            else
                                                return Item.TopRight
                                        }
                                        anchors {
                                            top: parent.top; topMargin: Style.stdMargin
                                            horizontalCenter: parent.horizontalCenter
                                        }
                                    }
                                    Rectangle {
                                        width: parent.width*1/4; height: 3
                                        anchors {
                                            top: eltLib.bottom; topMargin: 2
                                            horizontalCenter: parent.horizontalCenter
                                        }
                                        color: model.valid ? Colors.themeMainColor:"transparent"
                                    }

                                    states: [
                                        State {
                                            name: "HOVERED"
                                            when: eltControl.containsMouse
                                            PropertyChanges { target: eltIcon; scale: 2 }
                                            PropertyChanges { target: eltIcon; color: Colors.themeMainColor }
                                            PropertyChanges { target: eltText; opacity: 0 }
                                        }
                                    ]

                                    transitions: [
                                        Transition {
                                            NumberAnimation {
                                                properties: "scale, opacity"
                                                duration: 250
                                                easing.type: Easing.InOutQuad
                                            }
                                            ColorAnimation {
                                                properties: "color"
                                                duration: 500
                                                easing.type: Easing.InOutQuad
                                            }
                                        }
                                    ]

                                    MouseArea {
                                        id: eltControl
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: {
                                            grid.currentIndex = index
                                            var iconId = parent.GridView.view.model.get(grid.currentIndex).iconId
                                            var iconName = parent.GridView.view.model.get(grid.currentIndex).iconName
                                            var iconLib = parent.GridView.view.model.get(grid.currentIndex).iconLib
                                            iconPresenter.display(iconName, iconId, iconLib)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
