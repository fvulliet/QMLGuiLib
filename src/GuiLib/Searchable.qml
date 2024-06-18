import QtQuick 2.2
import GuiLib 1.0 as Gui
import ConnectOS 1.0

Row {
    id: root

    property bool showFilterChoice: false
    property var filterList: []
    property int currentFilter: -1

    signal setFilter(string text)

    Item {
        id: filterArrows

        height: parent.height
        width: showFilterChoice ? 1.5*height : 0
        visible: width > 0

        StandardText {
            text: filterList.length > 0 ? filterList[currentFilter].text : ""
            minimumPixelSize: 3
        }

        Item {
            width: parent.width; height: parent.height/2

            FontIcon {
                anchors.horizontalCenter: parent.horizontalCenter
                lib: Fonts.sfyIco; icon: SfyIco.Icon.FatRightArrow
                color: Colors.skinMenuBGD
                size: parent.height/2
                rotation: -90
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (currentFilter < (filterList.length-1))
                        currentFilter++
                    else
                        currentFilter = 0
                }
            }
        }

        Item {
            width: parent.width; height: parent.height/2
            anchors.bottom: parent.bottom

            FontIcon {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                }
                lib: Fonts.sfyIco; icon: SfyIco.Icon.FatRightArrow
                color: Colors.skinMenuBGD
                size: parent.height/2
                rotation: 90
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (currentFilter > 0)
                        currentFilter--
                    else
                        currentFilter = filterList.length-1
                }
            }
        }
    }

    Item {
        id: filterCtnr

        height: parent.height
        width: parent.width - filterArrows.width

        Rectangle {
            height: parent.height-2*Style.borderMargin; width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            border {
                color: Colors.skinFrameTXT; width: 2
            }
            radius: 5

            Row {
                anchors {
                    fill: parent; margins: 3
                }

                Item {
                    height: parent.height
                    width: parent.width - searchIcon.width

                    TextInput {
                        anchors {
                            fill: parent; margins: 2
                        }
                        font {
                            family: Fonts.sfyFont
                            pixelSize: Math.min(20, parent.height * 2/3)
                        }
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        cursorPosition: 0
                        color: Colors.skinFrameTXT
                        selectionColor: Colors.skinFrameTXT
                        selectedTextColor: Colors.themeMainColor
                        clip: true
                        onTextChanged: setFilter(text)
                    }
                }
                Item {
                    id: searchIcon

                    height: parent.height; width: height

                    FontIcon {
                        anchors.centerIn: parent
                        lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.Search
                        color: Colors.skinMenuBGD
                        size: parent.height * 0.5
                    }
                }
            }
        }
    }
}
