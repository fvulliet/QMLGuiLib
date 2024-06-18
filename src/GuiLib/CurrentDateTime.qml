import QtQuick 2.0
import Qt5Compat.GraphicalEffects 1.0
import GuiLib 1.0

Item {
    id: root

    property color textColor: Colors.skinMenuTXT
    property int textSize: 16
    property bool minimized: false

    Behavior on opacity { NumberAnimation {} }

    function upateDateTime() {
        clockText.text = minimized ? Qt.formatDateTime(new Date(), "hh:mm")
                                   : Qt.formatDateTime(new Date(), "hh:mm:ss")
        dateText.text = minimized ? Qt.formatDateTime(new Date(), "dd.MM\nyyyy")
                                  : Qt.formatDateTime(new Date(), "ddd dd MMM yyyy")
    }

    onMinimizedChanged: upateDateTime()
    Component.onCompleted: upateDateTime()

    Column {
        anchors.fill: parent

        Item {
            width: parent.width; height: parent.height/2

            StandardText {
                id: clockText
                color: textColor
                font {
                    pixelSize: textSize
                    bold: true
                }

            }
        }
        Item {
            width: parent.width; height: parent.height/2

            StandardText {
                id: dateText
                color: textColor
                font.pixelSize: textSize / Style.goldenNumber
            }
        }
    }

    Timer {
        interval: minimized ? 60000 : 1000
        repeat: true
        running: true
        onTriggered: upateDateTime()
    }
}
