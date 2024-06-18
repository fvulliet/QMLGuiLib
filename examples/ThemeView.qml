import QtQuick 2.9
import GuiLib 1.0


Page {
    id: iconsView

    property string _trContext: "ThemeView"

    anchors.fill: parent

    TBIconsModel {
        id: myTBiconsModel
    }

    Layout_Standard {
        anchors.fill: parent
        title: QT_TR_NOOP("THEME"); trContext: _trContext
        iconLib: Fonts.faSolid; iconId: FontAwesomeSolid.Icon.Tint
        showNav: false

        scope: Item {}
        payload: Item {
            id: gridCtn
            anchors.fill: parent
            clip: true
        }
    }
}
