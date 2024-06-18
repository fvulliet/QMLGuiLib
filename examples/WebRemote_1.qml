import QtQuick 2.9
import GuiLib 1.0 as Gui

Rectangle {
    id: root

    property alias model: wrDropdown.model

    Column {
        anchors.fill: parent

        Gui.MainMenu {
            id: viewHeader

            isVertical: false
            width: parent.width; height: 40
            canBeMinimized: false; animationSpeed: 400
            ctrlFont: Gui.Fonts.sfyFont
            selectionEnabled: false

            Item {
                height: parent.height; width: parent.width/2
                anchors.horizontalCenter: parent.horizontalCenter

                Gui.StandardText {
                    text: "Web Remote"
                    color: "white"
                    font.pixelSize: parent.height*3/4
                }
            }

            Column {
                height: parent.height; width: 2*height
                anchors.right: parent.right
                spacing: 2

                Item {
                    width: parent.width; height: (parent.height-parent.spacing)/2

                    Gui.FontIcon {
                        id: icon
                        lib: Gui.Fonts.faSolid; icon: Gui.FontAwesomeSolid.Icon.Profile
                        color: "white"
                        size: parent.height*0.8
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                    }
                }
                Item {
                    width: parent.width; height: (parent.height-parent.spacing)/2

                    Gui.StandardText {
                        verticalAlignment: Text.AlignTop
                        text: "toto"
                        color: "white"
                        font.pixelSize: parent.height*3/4
                    }
                }
            }
        }
        Column {
            width: parent.width; height: parent.height - viewHeader.height

            Item {
                id: ddCtnr

                width: parent.width; height: 80
                z: 2

                Gui.Dropdown {
                    id: wrDropdown

                    width: parent.width/2
                    height: parent.height/2
                    anchors.centerIn: parent
                    readOnly: true
                    ctrlFont: Gui.Fonts.sfyFont
                    currentIndex: 4
                    onElementSelected: {
                        text = model.get(index).name
                        positionWidget.positionPCent = model.get(index).position
                    }
                }
            }
            Item {
                width: parent.width; height: parent.height - ddCtnr.height
                z: 1

                Gui.AdvancedPositionWidget {
                    id: positionWidget

                    height: Math.min(parent.width*0.8, parent.height*0.8); width: height
                    anchors.centerIn: parent
                    markSize: 60
                }
            }
        }
    }
}
