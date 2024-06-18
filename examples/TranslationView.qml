import QtQuick 2.9
import GuiLib 1.0


Page {
    id: root

    property string _trContext: "TranslationView"
    anchors.fill: parent

    Layout_Standard {
        anchors.fill: parent
        title: QT_TR_NOOP("translation"); trContext: _trContext
        iconLib: Fonts.faSolid; iconId: FontAwesomeSolid.Icon.Language
        showNav: false

        scope: Item {
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
                            left: parent.left; leftMargin: parent.width/4
                            verticalCenter: parent.verticalCenter
                        }
                        checked: parent.ListView.view.currentIndex === langId ? true : false
                        onClicked: parent.ListView.view.currentIndex = index
                    }
                }
            }
        }
        payload: Item {
            anchors.fill: parent

            Column {
                property int _nbItems: 6
                property int _itemHeight: height / _nbItems

                anchors.fill: parent

                Item {
                    width: parent.width; height: parent._itemHeight

                    Column {
                        anchors.fill: parent
                        property int _lineHeight: height/4
                        Item {
                            width: parent.width; height: parent._lineHeight
                            Text {
                                anchors.centerIn: parent
                                font { family: Fonts.sfyFont; pixelSize: 14
                                    bold: true; capitalization: Font.AllUppercase }
                                color: Colors.skinFrameTXT
                                text: "capital"
                            }
                        }
                        Item {
                            width: parent.width; height: parent._lineHeight
                            Text {
                                anchors.centerIn: parent
                                font { family: Fonts.sfyFont; pixelSize: 14; italic: true }
                                color: Colors.skinFrameTXT
                                text: "here whatever the translator writes, the text is rendered with capital letters"
                            }
                        }
                        Item {
                            width: parent.width; height: parent._lineHeight
                            TrText {
                                anchors.left: parent.left; anchors.leftMargin: parent.width/5
                                anchors.verticalCenter: parent.verticalCenter
                                font { family: Fonts.sfyFont; pixelSize: 16;
                                    capitalization: Font.AllUppercase }
                                color: Colors.skinFrameTXT
                                //: somehow rendered with capital letters
                                content: QT_TR_NOOP("SAVE"); context: _trContext
                            }
                        }
                        Item {
                            width: parent.width; height: parent._lineHeight
                            TrText {
                                anchors.left: parent.left; anchors.leftMargin: parent.width/5
                                anchors.verticalCenter: parent.verticalCenter
                                font { family: Fonts.sfyFont; pixelSize: 16;
                                    capitalization: Font.AllUppercase }
                                color: Colors.skinFrameTXT
                                //: somehow rendered with capital letters
                                content: QT_TR_NOOP("save"); context: _trContext
                            }
                        }
                    }
                }
                Item {
                    width: parent.width; height: parent._itemHeight
                    Column {
                        anchors.fill: parent
                        property int _lineHeight: height/5
                        Item {
                            width: parent.width; height: parent._lineHeight
                            Text {
                                anchors.centerIn: parent
                                font { family: Fonts.sfyFont; pixelSize: 14
                                    bold: true; capitalization: Font.AllUppercase }
                                color: Colors.skinFrameTXT
                                text: "plural"
                            }
                        }
                        Item {
                            width: parent.width; height: parent._lineHeight
                            Text {
                                anchors.centerIn: parent
                                font { family: Fonts.sfyFont; pixelSize: 14; italic: true }
                                color: Colors.skinFrameTXT
                                text: "plural management depends on the language"
                            }
                        }
                        Item {
                            id: elt1
                            width: parent.width; height: parent._lineHeight
                            property int pluralCount: 1
                            Item {
                                width: parent.width/5; height: parent.height
                                Column {
                                    anchors.fill: parent
                                    Item {
                                        height: parent.height/2; width: parent.width
                                        FontIcon {
                                            lib: Fonts.faSolid;
                                            icon: FontAwesomeSolid.Icon.PlusSign
                                            color: Colors.skinFrameTXT
                                            size: parent.height
                                            anchors.centerIn: parent
                                        }
                                        MouseArea {
                                            anchors.fill: parent
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: {
                                                if (elt1.pluralCount < 5)
                                                    elt1.pluralCount += 1
                                            }
                                        }
                                    }
                                    Item {
                                        height: parent.height/2; width: parent.width
                                        FontIcon {
                                            lib: Fonts.faSolid;
                                            icon: FontAwesomeSolid.Icon.MinusSign
                                            color: Colors.skinFrameTXT
                                            size: parent.height
                                            anchors.centerIn: parent
                                        }
                                        MouseArea {
                                            anchors.fill: parent
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: {
                                                if (elt1.pluralCount > 0)
                                                    elt1.pluralCount -= 1
                                            }
                                        }
                                    }
                                }
                            }
                            Text {
                                anchors.left: parent.left; anchors.leftMargin: parent.width/5
                                anchors.verticalCenter: parent.verticalCenter
                                font { family: Fonts.sfyFont; pixelSize: 16 }
                                color: Colors.skinFrameTXT
                                text: qsTr("%n function(s) selected", "plural", elt1.pluralCount) + TranslationManagement.emptyString
                            }
                        }
                        Item {
                            id: elt2
                            property int pluralCount: 1
                            width: parent.width; height: parent._lineHeight
                            Item {
                                width: parent.width/5; height: parent.height
                                Column {
                                    anchors.fill: parent
                                    Item {
                                        height: parent.height/2; width: parent.width
                                        FontIcon {
                                            lib: Fonts.faSolid;
                                            icon: FontAwesomeSolid.Icon.PlusSign
                                            color: Colors.skinFrameTXT
                                            size: parent.height
                                            anchors.centerIn: parent
                                        }
                                        MouseArea {
                                            anchors.fill: parent
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: {
                                                if (elt2.pluralCount < 5)
                                                    elt2.pluralCount += 1
                                            }
                                        }
                                    }
                                    Item {
                                        height: parent.height/2; width: parent.width
                                        FontIcon {
                                            lib: Fonts.faSolid;
                                            icon: FontAwesomeSolid.Icon.MinusSign
                                            color: Colors.skinFrameTXT
                                            size: parent.height
                                            anchors.centerIn: parent
                                        }
                                        MouseArea {
                                            anchors.fill: parent
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: {
                                                if (elt2.pluralCount > 0)
                                                    elt2.pluralCount -= 1
                                            }
                                        }
                                    }
                                }
                            }
                            Text {
                                anchors.left: parent.left; anchors.leftMargin: parent.width/5
                                anchors.verticalCenter: parent.verticalCenter
                                font { family: Fonts.sfyFont; pixelSize: 16 }
                                color: Colors.skinFrameTXT
                                text: qsTr("%n motor(s) selected", "plural", elt2.pluralCount) + TranslationManagement.emptyString
                            }
                        }
                        Item {
                            width: parent.width; height: parent._lineHeight
                            TrText {
                                anchors.left: parent.left; anchors.leftMargin: parent.width/5
                                anchors.verticalCenter: parent.verticalCenter
                                font { family: Fonts.sfyFont; pixelSize: 16 }
                                color: Colors.skinFrameTXT
                                context: _trContext
                                plural: 42
                                content: QT_TR_NOOP("%n group(s) selected", "", 42)
                            }
                        }
                    }
                }
                Item {
                    width: parent.width; height: parent._itemHeight
                    Column {
                        anchors.fill: parent
                        property int _lineHeight: height/4
                        Item {
                            width: parent.width; height: parent._lineHeight
                            Text {
                                anchors.centerIn: parent
                                font { family: Fonts.sfyFont; pixelSize: 14
                                    bold: true; capitalization: Font.AllUppercase }
                                color: Colors.skinFrameTXT
                                text: "gender"
                            }
                        }
                        Item {
                            width: parent.width; height: parent._lineHeight
                            Text {
                                anchors.centerIn: parent
                                font { family: Fonts.sfyFont; pixelSize: 14; italic: true }
                                color: Colors.skinFrameTXT
                                text: "gender can lead to different translations"
                            }
                        }
                        Item {
                            width: parent.width; height: parent._lineHeight
                            TrText {
                                anchors.left: parent.left; anchors.leftMargin: parent.width/5
                                anchors.verticalCenter: parent.verticalCenter
                                font { family: Fonts.sfyFont; pixelSize: 16 }
                                color: Colors.skinFrameTXT
                                context: _trContext
                                disambiguation: "deals with function"
                                content: QT_TRANSLATE_NOOP("TranslationView", "local", "deals with function")
                            }
                        }
                        Item {
                            width: parent.width; height: parent._lineHeight
                            TrText {
                                anchors.left: parent.left; anchors.leftMargin: parent.width/5
                                anchors.verticalCenter: parent.verticalCenter
                                font { family: Fonts.sfyFont; pixelSize: 16 }
                                color: Colors.skinFrameTXT
                                context: _trContext
                                disambiguation: "deals with sensor"
                                content: QT_TRANSLATE_NOOP("TranslationView", "local", "deals with sensor")
                            }
                        }
                    }
                }
                Item {
                    width: parent.width; height: parent._itemHeight
                    Column {
                        anchors.fill: parent
                        property int _lineHeight: height/5
                        Item {
                            width: parent.width; height: parent._lineHeight
                            Text {
                                anchors.centerIn: parent
                                font { family: Fonts.sfyFont; pixelSize: 14
                                    bold: true; capitalization: Font.AllUppercase }
                                color: Colors.skinFrameTXT
                                text: "context"
                            }
                        }
                        Item {
                            width: parent.width; height: parent._lineHeight
                            Text {
                                anchors.centerIn: parent
                                font { family: Fonts.sfyFont; pixelSize: 14; italic: true }
                                color: Colors.skinFrameTXT
                                text: "the same word can have different translations according to the context"
                            }
                        }
                        Item {
                            width: parent.width; height: parent._lineHeight
                            TrText {
                                anchors {
                                    left: parent.left; leftMargin: parent.width/5
                                    verticalCenter: parent.verticalCenter
                                }
                                font { family: Fonts.sfyFont; pixelSize: 16 }
                                color: Colors.skinFrameTXT
                                context: _trContext
                                disambiguation: "deals with action"
                                content: QT_TR_NOOP("start", "deals with action")
                            }
                        }
                        Item {
                            width: parent.width; height: parent._lineHeight
                            TrText {
                                anchors {
                                    left: parent.left; leftMargin: parent.width/5
                                    verticalCenter: parent.verticalCenter
                                }
                                font { family: Fonts.sfyFont; pixelSize: 16 }
                                color: Colors.skinFrameTXT
                                context: _trContext
                                disambiguation: "deals with scenario"
                                //: This is a comment for the translator.
                                content: QT_TR_NOOP("start", "deals with scenario")
                            }
                        }
                        Item {
                            width: parent.width; height: parent._lineHeight
                            TrText {
                                anchors {
                                    left: parent.left; leftMargin: parent.width/5
                                    verticalCenter: parent.verticalCenter
                                }
                                font { family: Fonts.sfyFont; pixelSize: 16 }
                                color: Colors.skinFrameTXT
                                context: _trContext
                                disambiguation: "deals with process"
                                //~ another comment
                                content: QT_TR_NOOP("start", "deals with process")
                            }
                        }
                    }
                }
                Item {
                    width: parent.width; height: parent._itemHeight
                    Column {
                        anchors.fill: parent
                        property int _lineHeight: height/4
                        Item {
                            width: parent.width; height: parent._lineHeight
                            Text {
                                anchors.centerIn: parent
                                font { family: Fonts.sfyFont; pixelSize: 14
                                    bold: true; capitalization: Font.AllUppercase }
                                color: Colors.skinFrameTXT
                                text: "direct translation"
                            }
                        }
                        Item {
                            width: parent.width; height: parent._lineHeight
                            Text {
                                anchors.centerIn: parent
                                font { family: Fonts.sfyFont; pixelSize: 14; italic: true }
                                color: Colors.skinFrameTXT
                                text: "using qsTranslate or qsTr"
                            }
                        }
                        Item {
                            width: parent.width; height: parent._lineHeight
                            Text {
                                anchors.left: parent.left; anchors.leftMargin: parent.width/5
                                anchors.verticalCenter: parent.verticalCenter
                                font { family: Fonts.sfyFont; pixelSize: 16 }
                                color: Colors.skinFrameTXT
                                text: qsTranslate("TranslationView", "direct translation with qsTranslate", "disambiguation") + TranslationManagement.emptyString
                            }
                        }
                        Item {
                            width: parent.width; height: parent._lineHeight
                            Text {
                                anchors.left: parent.left; anchors.leftMargin: parent.width/5
                                anchors.verticalCenter: parent.verticalCenter
                                font { family: Fonts.sfyFont; pixelSize: 16 }
                                color: Colors.skinFrameTXT
                                text: qsTr("direct translation with qsTr", "disambiguation") + TranslationManagement.emptyString
                            }
                        }
                    }
                }
                Item {
                    width: parent.width; height: parent._itemHeight
                    Button {
                        height: 40; width: 150
                        anchors.centerIn: parent
                        isFlat: false
                        text: QT_TR_NOOP("NORMAL"); trContext: _trContext
                    }
                }
            }
        }
    }
}
