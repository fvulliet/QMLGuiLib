import QtQuick 2.9
import GuiLib 1.0 as Gui

Item {
    id: root

    property string _trContext: "IconLabView"

    DemoHeader {
        id: header
        width: parent.width; height: parent.height / 15
        anchors.top: parent.top
        title: QT_TR_NOOP("COLORS"); trContext: _trContext
    }

    Item {
        anchors {
            top: header.bottom; bottom: parent.bottom
        }
        width: parent.width

        ListModel {
            id: colorsModel

            Component.onCompleted: {
                append({ myName: "skinMenuBGD", myColor: Gui.Colors.getStr(Gui.Colors.skinMenuBGD) })
                append({ myName: "skinMenuTXT", myColor: Gui.Colors.getStr(Gui.Colors.skinMenuTXT) })
                append({ myName: "skinHeaderBGD", myColor: Gui.Colors.getStr(Gui.Colors.skinHeaderBGD) })
                append({ myName: "skinHeaderTXT", myColor: Gui.Colors.getStr(Gui.Colors.skinHeaderTXT) })
                append({ myName: "skinFrameBGD", myColor: Gui.Colors.getStr(Gui.Colors.skinFrameBGD) })
                append({ myName: "skinFrameTXT", myColor: Gui.Colors.getStr(Gui.Colors.skinFrameTXT) })
                append({ myName: "skinFrameSelectedTXT", myColor: Gui.Colors.getStr(Gui.Colors.skinFrameSelectedTXT) })
                append({ myName: "skinItemHOV", myColor: Gui.Colors.getStr(Gui.Colors.skinItemHOV) })
                append({ myName: "skinItemFGD", myColor: Gui.Colors.getStr(Gui.Colors.skinItemFGD) })
                append({ myName: "skinButtonTXT", myColor: Gui.Colors.getStr(Gui.Colors.skinButtonTXT) })
                append({ myName: "skinListTXT", myColor: Gui.Colors.getStr(Gui.Colors.skinListTXT) })
                append({ myName: "skinListBGD", myColor: Gui.Colors.getStr(Gui.Colors.skinListBGD) })
                append({ myName: "skinWizardSeparator", myColor: Gui.Colors.getStr(Gui.Colors.skinWizardSeparator) })
                append({ myName: "skinWizardTXT", myColor: Gui.Colors.getStr(Gui.Colors.skinWizardTXT) })
                append({ myName: "skinFrameBoldTXT", myColor: Gui.Colors.getStr(Gui.Colors.skinFrameBoldTXT) })
                append({ myName: "skinTxtInputBGD", myColor: Gui.Colors.getStr(Gui.Colors.skinTxtInputBGD) })
                append({ myName: "skinTxtInputTXT", myColor: Gui.Colors.getStr(Gui.Colors.skinTxtInputTXT) })
            }
        }

        GridView {
            id: colorsList

            anchors {
                fill: parent; margins: Gui.Style.stdMargin
            }
            clip: true
            cellWidth: width/3; cellHeight: 90
            model: colorsModel
            delegate: Item {
                id: del

                width: GridView.view.cellWidth; height: GridView.view.cellHeight

                Rectangle {
                    anchors {
                        fill: parent; margins: 5
                    }
                    border.width: 1

                    Column {
                        anchors {
                            fill: parent; margins: 2
                        }

                        Rectangle {
                            width: parent.width; height: parent.height/2
                            color: myColor
                        }
                        Item {
                            width: parent.width; height: parent.height/2

                            Gui.StandardText {
                                text: myName + " (" + myColor + ")"
                            }
                        }
                    }
                }
            }
        }
    }
}
