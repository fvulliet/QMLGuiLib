import QtQuick 2.9
import GuiLib 1.0 as Gui

Gui.Page {
    id: iconsView

    anchors.fill: parent

    Gui.Layout_Standard {
        anchors.fill: parent
        title: QT_TR_NOOP("TABS"); trContext: "TBIconsView"
        iconLib: Gui.Fonts.faSolid; iconId: Gui.FontAwesomeSolid.Icon.Underline
        showNav: false

        scope: Item {
        }
        payload: Item {
            anchors.fill: parent

            Column {
                anchors.fill: parent

                Item {
                    width: parent.width; height: parent.height/4

                    Column {
                        anchors.fill: parent

                        Gui.Tabs {
                            id: tabsList1

                            width: parent.width; height: 40
                            ctrlFont: Gui.Fonts.sfyFont
                            model: ListModel {
                                Component.onCompleted: {
                                    append({ name: QT_TR_NOOP("tab 1"), trContext: _trContext,
                                               isVisible: true, hasText: false, hasIcon: true,
                                               iconLib: Gui.Fonts.sfyIco, iconId: Gui.SfyIco.Icon.Sun3 })
                                    append({ name: QT_TR_NOOP("tab 2"), trContext: _trContext,
                                               isVisible: true, hasText: false, hasIcon: true,
                                               iconLib: Gui.Fonts.sfyIco, iconId: Gui.SfyIco.Icon.WindSensor })
                                    append({ name: QT_TR_NOOP("tab 3"), trContext: _trContext,
                                               isVisible: true, hasText: false, hasIcon: true,
                                               iconLib: Gui.Fonts.sfyIco, iconId: Gui.SfyIco.Icon.Temp })
                                }
                            }
                            onSelected: {
                                switch (index) {
                                case 1:
                                    myText1.text = "ICON ONLY => tab 2 contents"
                                    break
                                case 2:
                                    myText1.text = "ICON ONLY => tab 3 contents"
                                    break
                                default:
                                    myText1.text = "ICON ONLY => tab 1 contents"
                                    break
                                }
                            }
                        }
                        Item {
                            width: parent.width; height: parent.height - 40

                            Text {
                                id: myText1

                                anchors.centerIn: parent
                                font {
                                    family: Gui.Fonts.sfyFont; bold: true; pixelSize: 14
                                }
                                color: Gui.Colors.skinFrameTXT
                            }
                        }
                    }
                }
                Item {
                    width: parent.width; height: parent.height/4

                    Column {
                        anchors.fill: parent

                        Gui.Tabs {
                            id: tabsList2

                            withBackground: true
                            width: parent.width; height: 40
                            ctrlFont: Gui.Fonts.sfyFont
                            model: ListModel {
                                Component.onCompleted: {
                                    append({ name: QT_TR_NOOP("tab A"), trContext: _trContext,
                                               isVisible: true, hasText: true, hasIcon: false,
                                               iconLib: "", iconId: "" })
                                    append({ name: QT_TR_NOOP("tab B"), trContext: _trContext,
                                               isVisible: true, hasText: true, hasIcon: false,
                                               iconLib: "", iconId: "" })
                                    append({ name: QT_TR_NOOP("tab C"), trContext: _trContext,
                                               isVisible: true, hasText: true, hasIcon: false,
                                               iconLib: "", iconId: "" })
                                }
                            }
                            onSelected: {
                                switch (index) {
                                case 1:
                                    myText2.text = "TEXT ONLY => tab B contents"
                                    break
                                case 2:
                                    myText2.text = "TEXT ONLY => tab C contents"
                                    break
                                default:
                                    myText2.text = "TEXT ONLY => tab A contents"
                                    break
                                }
                            }
                        }
                        Item {
                            width: parent.width; height: parent.height - 40

                            Text {
                                id: myText2

                                anchors.centerIn: parent
                                font {
                                    family: Gui.Fonts.sfyFont; bold: true; pixelSize: 14
                                }
                                color: Gui.Colors.skinFrameTXT
                            }
                        }
                    }
                }
                Item {
                    width: parent.width; height: parent.height/4

                    Column {
                        anchors.fill: parent

                        Gui.Tabs {
                            id: tabsList3

                            dark: true
                            width: parent.width; height: 40
                            ctrlFont: Gui.Fonts.sfyFont
                            model: ListModel {
                                Component.onCompleted: {
                                    append({ name: QT_TR_NOOP("Aaa"), trContext: _trContext,
                                               isVisible: true, hasText: true, hasIcon: true,
                                               iconLib: Gui.Fonts.sfyIco, iconId: Gui.SfyIco.Icon.Sun3 })
                                    append({ name: QT_TR_NOOP("Bbb"), trContext: _trContext,
                                               isVisible: true, hasText: true, hasIcon: true,
                                               iconLib: Gui.Fonts.sfyIco, iconId: Gui.SfyIco.Icon.WindSensor })
                                    append({ name: QT_TR_NOOP("Ccc"), trContext: _trContext,
                                               isVisible: true, hasText: true, hasIcon: true,
                                               iconLib: Gui.Fonts.sfyIco, iconId: Gui.SfyIco.Icon.Temp })
                                }
                            }
                            onSelected: {
                                switch (index) {
                                case 1:
                                    myText3.text = "TEXT + ICON => Bbb  contents"
                                    break
                                case 2:
                                    myText3.text = "TEXT + ICON => Ccc contents"
                                    break
                                default:
                                    myText3.text = "TEXT + ICON => Aaa contents"
                                    break
                                }
                            }
                        }
                        Item {
                            width: parent.width; height: parent.height - 40

                            Text {
                                id: myText3

                                anchors.centerIn: parent
                                font {
                                    family: Gui.Fonts.sfyFont; bold: true; pixelSize: 14
                                }
                                color: Gui.Colors.skinFrameTXT
                            }
                        }
                    }
                }
                Item {
                    width: parent.width; height: parent.height/4

                    Column {
                        anchors.fill: parent

                        Gui.Tabs {
                            id: tabsList4

                            withBackground: true
                            dark: true
                            width: parent.width; height: 40
                            ctrlFont: Gui.Fonts.sfyFont
                            model: ListModel {
                                Component.onCompleted: {
                                    append({ name: QT_TR_NOOP("111"), trContext: _trContext,
                                               isVisible: true, hasText: true, hasIcon: false,
                                               iconLib: "", iconId: "" })
                                    append({ name: QT_TR_NOOP("222"), trContext: _trContext,
                                               isVisible: true, hasText: false, hasIcon: true,
                                               iconLib: Gui.Fonts.sfyIco, iconId: Gui.SfyIco.Icon.WindSensor })
                                    append({ name: QT_TR_NOOP("333"), trContext: _trContext,
                                               isVisible: true, hasText: true, hasIcon: true,
                                               iconLib: Gui.Fonts.sfyIco, iconId: Gui.SfyIco.Icon.Temp })
                                }
                            }
                            onSelected: {
                                switch (index) {
                                case 1:
                                    myText4.text = "MIX => 222 contents"
                                    break
                                case 2:
                                    myText4.text = "MIX => 333 contents"
                                    break
                                default:
                                    myText4.text = "MIX => 111 contents"
                                    break
                                }
                            }
                        }
                        Item {
                            width: parent.width; height: parent.height - 40

                            Text {
                                id: myText4

                                anchors.centerIn: parent
                                font {
                                    family: Gui.Fonts.sfyFont; bold: true; pixelSize: 14
                                }
                                color: Gui.Colors.skinFrameTXT
                            }
                        }
                    }
                }
            }
        }
    }
}

