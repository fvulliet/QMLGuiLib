import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    property string _trContext: "PopupView"

    signal showPopupMessage(int type, string msg, var btns)

    DemoHeader {
        id: header

        width: parent.width; height: parent.height / 15
        anchors.top: parent.top
        title: QT_TR_NOOP("POPUP"); trContext: _trContext
    }

    Column {
        anchors {
            top: header.bottom; topMargin: Style.stdMargin
            bottom: parent.bottom; bottomMargin: Style.stdMargin
        }
        width: parent.width

        Item {
            width: parent.width; height: parent.height/5

            Button {
                height: 40; width: parent.width / 4
                text: QT_TR_NOOP("INFO"); trContext: _trContext
                anchors.centerIn: parent
                onClicked: {
                    var btns = ["Ok"]
                    showPopupMessage(0, "this is an information popup", btns)
                }
            }
        }
        Item {
            width: parent.width; height: parent.height/5

            Button {
                height: 40; width: parent.width / 4
                text: QT_TR_NOOP("WARNING"); trContext: _trContext
                anchors.centerIn: parent
                onClicked: {
                    var btns = ["Ok"]
                    showPopupMessage(1, "this is a warning popup", btns)
                }
            }
        }
        Item {
            width: parent.width; height: parent.height/5

            Button {
                height: 40; width: parent.width / 4
                text: QT_TR_NOOP("ERROR"); trContext: _trContext
                anchors.centerIn: parent
                onClicked: {
                    var btns = ["Ok"]
                    showPopupMessage(2, "this is an error popup", btns)
                }
            }
        }
        Item {
            width: parent.width; height: parent.height/5

            Button {
                height: 40; width: parent.width / 4
                text: QT_TR_NOOP("2 BUTTONS"); trContext: _trContext
                anchors.centerIn: parent
                onClicked: {
                    var btns = ["Ok", "Cancel"]
                    showPopupMessage(0, "this is a OK/CANCEL popup", btns)
                }
            }
        }
        Item {
            width: parent.width; height: parent.height/5

            Button {
                height: 40; width: parent.width / 4
                text: QT_TR_NOOP("3 BUTTONS"); trContext: _trContext
                anchors.centerIn: parent
                onClicked: {
                    var btns = ["Ok", "Cancel", "Discard"]
                    showPopupMessage(0, "this is SAVE/DISCARD/CANCEL popup", btns)
                }
            }
        }
    }
}

