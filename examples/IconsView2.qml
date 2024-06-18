import QtQuick 2.2
import GuiLib 1.0


Item {
    id: iconsView

    property int currentIcons: 0

    onCurrentIconsChanged: updateIcons(grid.model)

    function updateIcons(model) {
        var obj
        switch (currentIcons) {
        case 1:
            obj = FontAwesome.Icon
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
    }

    Rectangle {
        id: header
        width: parent.width; height: parent.height / 15
        anchors.top: parent.top
        color: Colors.themeMainColor

        Item {
            id: theme
            width: parent.width / 4; height: parent.height
            anchors.left: parent.left
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: Colors.skinButtonTXT
                font { family: Fonts.sfyFont; pixelSize: parent.height / 2; capitalization: Font.AllUppercase }
                text: currentTheme
            }
        }
        Item {
            height: parent.height
            anchors {
                left: theme.right; right: skin.left
            }
            Dropdown {
                id: dd1
                height: parent.height/2; width: parent.width/2
                anchors.centerIn: parent
                z: gridCtn.z + 1
                model: myModel
                readOnly: true

                currentIndex: globalSettings.iconsFont
                onCurrentIndexChanged: iconsView.currentIcons = currentIndex
                onElementSelected: globalSettings.iconsFont = index
            }

            ListModel {
                id: myModel
                ListElement { name: "SfyIco" }
                ListElement { name: "FontAwesome" }
                ListElement { name: "GoogleMaterial" }
            }
        }
        Item {
            id: skin
            width: parent.width / 4; height: parent.height
            anchors.right: parent.right
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: Colors.skinButtonTXT
                font { family: Fonts.sfyFont; pixelSize: parent.height / 2; capitalization: Font.AllUppercase }
                text: currentSkin
            }
        }
    }

    Item {
        id: gridCtn
        anchors {
            top: header.bottom; bottom: parent.bottom; left: parent.left
            right: parent.right
        }
        clip: true
        Item {
            anchors {
                fill: parent; margins: 20
            }

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
                            top: icn.bottom
                            topMargin: 2
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
                                     Fonts.fontAwesome : Fonts.googleMaterial

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
                    }
                }
            }
        }
    }
}
