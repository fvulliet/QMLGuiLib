import QtQuick 2.2

Rectangle {
    property alias text: myText.text

    anchors.fill: parent
    color: 'blue'
    Text {
        id: myText
        anchors.centerIn: parent
        text: "menu2"
        color: "white"
    }
}
