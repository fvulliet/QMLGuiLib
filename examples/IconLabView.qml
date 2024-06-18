import QtQuick 2.9
import GuiLib 1.0 as Gui

Item {
    id: root

    property string _trContext: "IconLabView"

    DemoHeader {
        id: header
        width: parent.width; height: parent.height / 15
        anchors.top: parent.top
        title: QT_TR_NOOP("ICONS LAB"); trContext: _trContext
    }

    Column {
        anchors {
            top: header.bottom; bottom: parent.bottom
        }
        width: parent.width

        Row {
            width: parent.width; height: parent.height/2

            Item {
                height: parent.height; width: parent.width/2

                Gui.MultiColorFontIcon {
                    lib: Gui.Fonts.sfyIco; icon: Gui.SfyIco.Icon.BuildingSolid
                    colorH: Gui.Colors.themeMainColor
                    colorL: Gui.Colors.skinMenuBGD
                    size: parent.height*0.9
                    anchors.centerIn: parent
                }
            }
            Rectangle {
                color: "black"
                height: parent.height; width: parent.width/2

                Gui.MultiColorFontIcon {
                    lib: Gui.Fonts.sfyIco; icon: Gui.SfyIco.Icon.BuildingSolid
                    colorH: Gui.Colors.themeMainColor
                    colorL: Gui.Colors.skinMenuBGD
                    size: parent.height*0.9
                    anchors.centerIn: parent
                }
            }
        }
        Row {
            width: parent.width; height: parent.height/2

            Item {
                height: parent.height; width: parent.width/2

                Gui.MultiColorFontIcon {
                    lib: Gui.Fonts.sfyIco; icon: Gui.SfyIco.Icon.BuildingSolid
                    colorH: Gui.Colors.themeMainColor
                    colorL: Gui.Colors.skinMenuBGD
                    size: parent.height*0.9
                    anchors.centerIn: parent
                    ratioHL: 0.25
                }
            }
            Item {
                height: parent.height; width: parent.width/2

                Gui.MultiColorFontIcon {
                    lib: Gui.Fonts.sfyIco; icon: Gui.SfyIco.Icon.BuildingSolid
                    colorH: Gui.Colors.themeMainColor
                    colorL: Gui.Colors.skinMenuBGD
                    size: parent.height*0.9
                    anchors.centerIn: parent
                    ratioHL: 0.75
                }
            }
        }
    }
}

