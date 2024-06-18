import QtQuick 2.9
import GuiLib 1.0


Page {
    id: root

    anchors.fill: parent

    property bool completed: false
    property ListModel items: ListModel {}

    Component.onCompleted: {
        items.append({ iconLib: "FontAwesome", iconId: "\uf221", text: "AAAAA" });
        items.append({ iconLib: "FontAwesome", iconId: "\uf222", text: "BBBBB" });
        items.append({ iconLib: "FontAwesome", iconId: "\uf223", text: "CCCCC" });
        items.append({ iconLib: "FontAwesome", iconId: "\uf224", text: "DDDDD" });
        items.append({ iconLib: "FontAwesome", iconId: "\uf225", text: "EEEEE" });
        items.append({ iconLib: "FontAwesome", iconId: "\uf226", text: "FFFFF" });
        items.append({ iconLib: "FontAwesome", iconId: "\uf227", text: "GGGGG" });
        completed = true
    }

    onCompletedChanged: {
        if (completed)
            menu.model = items
    }

    GridMenu {
        id: menu
        showNav: true
        anchors.fill: parent
    }
}
