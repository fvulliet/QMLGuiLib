import QtQuick 2.9
import GuiLib 1.0


Page {
    id: iconsView

    property string _trContext: "LanguageView"

    anchors.fill: parent

    Layout_Standard {
        anchors.fill: parent
        title: QT_TR_NOOP("LANGUAGE"); trContext: _trContext
        iconLib: Fonts.sfyIco; iconId: SfyIco.Icon.Earth
        showNav: false

        scope: Item {
        }
        payload: Item {
            anchors.fill: parent

            ListView {
                id: list

                property int itemHeight

                width: parent.width*0.75; height: parent.height*0.75
                anchors.centerIn: parent
                orientation: Qt.Vertical
                interactive: false
                currentIndex: TranslationManagement.usedLang
                onCurrentIndexChanged: {
                    TranslationManagement.usedLang = model.get(currentIndex).langId
                }

                Component.onCompleted: itemHeight = list.height / count

                model: ListModel {
                    ListElement { name: "English"; langId: TranslationManagement.LNG_ENGLISH}
                    ListElement { name: "German"; langId: TranslationManagement.LNG_GERMAN}
                    ListElement { name: "French"; langId: TranslationManagement.LNG_FRENCH}
                }

                delegate: Item {
                    width: ListView.view.width; height: ListView.view.itemHeight

                    RadioButton {
                        width: parent.width; height: 30
                        text: name
                        anchors {
                            left: parent.left; leftMargin: parent.width/2
                            verticalCenter: parent.verticalCenter
                        }
                        checked: parent.ListView.view.currentIndex === langId ? true : false
                        onClicked: parent.ListView.view.currentIndex = index
                    }
                }
            }
        }
    }
}
