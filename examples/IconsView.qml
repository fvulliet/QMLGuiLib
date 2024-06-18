import QtQuick 2.9
import GuiLib 1.0


Page {
    id: iconsView

    property int currentIcons: 0
    property string _trContext: "IconsView"
    property string currentIcon
    property bool sortByName: true

    anchors.fill: parent

    onCurrentIconsChanged: updateIcons(grid.model)

    onSortByNameChanged: updateIcons(grid.model)

    function updateIcons(model) {
        var obj
        switch (currentIcons) {
        case 1:
            obj = FontAwesomeSolid.Icon
            break;
        case 2:
            obj = GoogleMaterial.Icon
            break;
        default:
            obj = SfyIco.Icon
        }

        model.clear()
        for (var prop in obj) {
            if (obj.hasOwnProperty(prop)) {
                model.append({ "iconId": obj[prop], "iconName": prop.toString() });
            }
        }
        sortModel(model)
    }

    function toHex(str) {
        var result = '';
        for (var i=0; i<str.length; i++) {
            result += str.charCodeAt(i).toString(16);
        }
        return result;
    }

    function sortModel(model) {
        for(var i=0; i<model.count; i++)
        {
            for(var j=0; j<i; j++)
            {
                if (sortByName) {
                    if(toHex(model.get(i).iconName) < toHex(model.get(j).iconName))
                        model.move(i,j,1)
                } else {
                    if(toHex(model.get(i).iconId) < toHex(model.get(j).iconId))
                        model.move(i,j,1)
                }
                break
            }
        }
    }

    Layout_Standard {
        anchors.fill: parent
        title: qsTr("ALL"); trContext: _trContext
        iconLib: Fonts.faSolid; iconId: FontAwesomeSolid.Icon.Storage
        showNav: false
        titleRatio: 0.25

        scope: Column {
            anchors.fill: parent

            Column {
                width: parent.width; height: parent.height/4

                Item {
                    width: parent.width; height: parent.height/2

                    Dropdown {
                        height: 40; width: parent.width * 0.75
                        anchors.centerIn: parent
                        model: ListModel {
                            ListElement { name: "SfyIco" }
                            ListElement { name: "FontAwesome" }
                            ListElement { name: "GoogleMaterial" }
                        }
                        readOnly: true
                        currentIndex: globalSettings.iconsFont
                        onCurrentIndexChanged: iconsView.currentIcons = currentIndex
                        onElementSelected: globalSettings.iconsFont = index
                    }
                }
                Row {
                    width: parent.width; height: parent.height/2
                    spacing: 10

                    Item {
                        height: parent.height; width: (parent.width-parent.spacing)/2

                        RadioButton {
                            width: parent.width; height: parent.height/3
                            text: QT_TR_NOOP("name"); trContext: _trContext
                            anchors {
                                verticalCenter: parent.verticalCenter
                                right: parent.right
                            }
                            reversed: true
                            checked: sortByName
                            onClicked: sortByName = !sortByName
                        }
                    }
                    Item {
                        height: parent.height; width: (parent.width-parent.spacing)/2

                        RadioButton {
                            width: parent.width; height: parent.height/3
                            text: QT_TR_NOOP("id"); trContext: _trContext
                            anchors {
                                verticalCenter: parent.verticalCenter
                            }
                            reversed: false
                            checked: !sortByName
                            onClicked: sortByName = !sortByName
                        }
                    }
                }
                Rectangle {
                    width: parent.width
                    height: 1
                    color: Colors.skinFrameTXT
                }
            }
            Item {
                width: parent.width; height: parent.height*3/4

                FontIcon {
                    lib: iconsView.currentIcons === 0 ?
                             Fonts.sfyIco : iconsView.currentIcons === 1 ?
                                 Fonts.faSolid : Fonts.googleMaterial
                    icon: currentIcon
                    color: Colors.skinFrameTXT
                    size: parent.width
                    anchors.centerIn: parent
                }
            }
        }
        payload: Item {
            id: gridCtn
            anchors.fill: parent
            clip: true
            Item {
                anchors { fill: parent; margins: 20 }

                GridView {
                    id: grid
                    anchors {
                        fill: parent; margins: 10; centerIn: parent
                    }

                    model: ListModel {
                        id: mainmenumodel
                        Component.onCompleted: {
                            iconsView.updateIcons(mainmenumodel)
                        }
                    }

                    delegate: Item {
                        width: grid.width/5; height: width

                        states: [
                            State {
                                name: "HOVERED"
                                when: iconControl.containsMouse
                                PropertyChanges { target: icn; scale: 3 }
                                PropertyChanges { target: icn; color: Colors.themeMainColor }
                                PropertyChanges { target: icnTxt; opacity: 0 }
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
                        Text {
                            id: icnTxt
                            visible: opacity > 0
                            anchors {
                                top: icn.bottom; topMargin: 2
                                horizontalCenter: parent.horizontalCenter
                            }
                            font { pointSize: 9; family: Fonts.sfyFont }
                            text: iconName
                            color: icn.color
                        }
                        FontIcon {
                            id: icn
                            lib: iconsView.currentIcons === 0 ?
                                     Fonts.sfyIco : iconsView.currentIcons === 1 ?
                                         Fonts.faSolid : Fonts.googleMaterial
                            icon: iconId
                            color: Colors.skinFrameTXT
                            size: 30
                            scale: 1
                            anchors {
                                top: parent.top
                                horizontalCenter: parent.horizontalCenter
                            }
                        }
                        MouseArea {
                            id: iconControl
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: currentIcon = iconId
                        }
                    }
                }
            }
        }
    }
}
