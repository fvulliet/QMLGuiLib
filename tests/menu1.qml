import QtQuick 2.2

Rectangle {
    property alias text: myText.text

    anchors.fill: parent
    color: 'red'
    Text {
        id: myText
        anchors.centerIn: parent
        text: "menu1"
        color: "white"
    }
}
