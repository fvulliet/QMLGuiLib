import QtQuick 2.9
import GuiLib 1.0


Page {
    id: root

    property string _trContext: "MainMenuConfigView"

    Rectangle {
        color: Colors.skinFrameFGD
        anchors.fill: parent

        Button {
            height: 40; width: parent.width / 4
            text: "Add Entry"; trContext: _trContext
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top; topMargin: 200
            }
            onClicked: {
                mainMenu.model.append({ name: "dummy " + mainMenu.model.count.toString(),
                                          lib: Fonts.faSolid,
                                          img: FontAwesomeSolid.Icon.Twitter })
            }
        }
        Button {
            height: 40; width: parent.width / 4
            text: "Remove Entry"; trContext: _trContext
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom; bottomMargin: 200
            }
            onClicked: {
                var lastIndex = mainMenu.model.count - 1
                var str = mainMenu.model.get(lastIndex).name
                if (str.substring(0,5) === "dummy")
                    mainMenu.model.remove(lastIndex)
            }
        }
    }
}
