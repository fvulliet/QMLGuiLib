import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    property int headerHeight: 40
    property string _trContext: "ExtendedMenu"

    Rectangle {
        id: ctnr
        property alias currentTab: tabsList.currentIndex

        anchors.fill: parent
        color: Colors.skinFrameFGD

        ExtendedMenuHeader {
            id: header
            width: parent.width; height: headerHeight
            anchors.top: parent.top
            lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.Signout
            text: QT_TR_NOOP("EXTENDED MENU"); trContext: _trContext
        }

        Tabs {
            id: tabsList
            width: parent.width; height: headerHeight
            anchors.top: header.bottom
            model: extendedMenuModel
        }

        Item {
            width: parent.width
            anchors {
                top: tabsList.bottom; bottom: parent.bottom
            }
            TrText {
                anchors.centerIn: parent
                font { family: Fonts.sfyFont; pointSize: 20 }
                color: Colors.skinFrameTXT
                text: QT_TR_NOOP("TAB CONTENT"); context: _trContext
            }
        }
    }

    ListModel {
        id: extendedMenuModel
        Component.onCompleted: {
            append({ name: QT_TR_NOOP("tab1"), trContext: _trContext, isVisible: true, hasText: true, hasIcon: false, iconLib: "", iconId: "" })
            append({ name: QT_TR_NOOP("tab2"), trContext: _trContext, isVisible: true, hasText: true, hasIcon: false, iconLib: "", iconId: "" })
            append({ name: QT_TR_NOOP("tab3"), trContext: _trContext, isVisible: true, hasText: true, hasIcon: false, iconLib: "", iconId: "" })
        }
    }
}
