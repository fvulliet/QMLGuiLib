import QtQuick 2.9
import GuiLib 1.0


Page {
    id: root

    anchors.fill: parent

    property bool completed: false
    property ListModel items: ListModel {}

    Component.onCompleted: {
        items.append({ iconLib: Fonts.faSolid,
                         iconId: FontAwesomeSolid.Icon.AlignLeft, text: "LEFT" });
        items.append({ iconLib: "FontAwesome",
                         iconId: "\uf037", text: "CENTER" });
        items.append({ iconLib: Fonts.faSolid,
                         iconId: FontAwesomeSolid.Icon.AlignRight, text: "RIGHT" });
        completed = true
    }

    onCompletedChanged: {
        if (completed)
            menu.model = items
    }

    GridMenu {
        id: menu
        anchors.fill: parent
    }
}
