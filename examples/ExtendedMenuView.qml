import QtQuick 2.9
import GuiLib 1.0


Page {
    property string _trContext: "ExtendedMenuView"

    anchors.fill: parent

    Layout_Standard {
        anchors.fill: parent
        title: QT_TR_NOOP("EXTENDED MENU"); trContext: _trContext
        iconLib: Fonts.faSolid
        iconId: FontAwesomeSolid.Icon.Signout
        showNav: false

        scope: Extensible {
            id: myBottomleft

            isHorizontal: false
            anchors.fill: parent
            scaleFactor: 0.5
            onExtend: extended = true
            onCollapse: extended = false
            extended: false
            mainItem: Item {
                anchors.fill: parent

                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 50
                    border.color: Colors.themeMainColor

                    Text {
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: Colors.skinButtonTXT
                        font { family: Fonts.sfyFont; pixelSize: 18 }
                    }
                }
            }
            extendedItem: Rectangle {
                color: "transparent"
                anchors.fill: parent
                Column {
                    height: 60; width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 5
                    CheckBox {
                        anchors {
                            left: parent.left; leftMargin: Style.stdMargin
                        }
                        height: parent.height/3
                        text: QT_TR_NOOP("checkbox1"); trContext: _trContext
                        onClicked: checked = !checked
                    }
                    CheckBox {
                        anchors {
                            left: parent.left; leftMargin: Style.stdMargin
                        }
                        height: parent.height/3
                        text: QT_TR_NOOP("checkbox2"); trContext: _trContext
                        onClicked: checked = !checked
                    }
                    CheckBox {
                        anchors {
                            left: parent.left; leftMargin: Style.stdMargin
                        }
                        height: parent.height/3
                        text: QT_TR_NOOP("checkbox3"); trContext: _trContext
                        onClicked: checked = !checked
                    }
                }
            }
        }
        payload: Extensible {
            id: myRightItem

            anchors.fill: parent
            scaleFactor: 0.5
            onExtend: extended = true
            onCollapse: extended = false
            extended: false
            splitColor: Colors.skinFrameFGD
            clip: true
            mainItem: Item {
                anchors.fill: parent

                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 50
                    border.color: Colors.themeMainColor

                    Text {
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: Colors.skinButtonTXT
                        font { family: Fonts.sfyFont; pixelSize: 18 }
                    }
                }
            }
            extendedItem: Rectangle {
                color: "transparent"
                anchors.fill: parent
                PageLoader {
                    source: Qt.resolvedUrl("ExtendedMenu.qml")
                    height: parent.height
                    anchors { left: parent.left; right: parent.right }
                }
            }
        }
    }
}
