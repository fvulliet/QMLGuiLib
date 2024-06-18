import QtQuick 2.0
import GuiLib 1.0

Rectangle {
    // public properties
    property string controlName
    property int controlValue: 0
    property bool commaUsed: false
    property bool plusMinusUsed: false
    property int doubleFixPos: 1
    property int minimum: 0
    property int maximum: 1000
    property int fieldNumber: -1
    property bool firstTime: true
    property int nbRows: 4
    property int nbCols: 4
    property string maxStr: maximum

    // signals
    signal okPressed(var value, var fieldNumber)
    signal cancelPressed()

    // functions
    function setValue(text) {
        if (text > maximum)
            text = maximum
        if (text < minimum)
            text = minimum
        okPressed(text, fieldNumber)
    }

    // Rectangle's properties
    color: "#99696969"

    // inner components
    MouseArea {
        // block lower mouse events
        anchors.fill: parent
    }

    Rectangle {
        anchors.fill: parent
        border {
            width: 5; color: Colors.skinMenuBGD
        }
        color: Colors.skinFrameBGD

        Rectangle {
            anchors {
                fill: parent; margins: 2*parent.border.width
            }
            color: Colors.skinFrameFGD

            Column {
                height: parent.height * 0.95; width: parent.width * 0.95
                anchors.centerIn: parent

                Item {
                    width: parent.width; height: parent.height/4

                    Text {
                        color: Colors.skinFrameTXT
                        font {
                            family: Fonts.sfyFont
                            pixelSize: parent.height * 2/3
                        }
                        anchors.centerIn: parent
                        text: controlName
                    }
                }
                Rectangle {
                    width: parent.width; height: parent.height/2
                    color: Colors.themeMainColor
                    radius: 5
                    clip: true

                    TextInput {
                        id: textValue

                        anchors {
                            fill: parent; margins: 2
                        }
                        focus: true
                        horizontalAlignment: TextInput.AlignHCenter
                        verticalAlignment: TextInput.AlignVCenter
                        font {
                            pixelSize: {
                                if (contentWidth > width)
                                    return (width / contentWidth) * parent.height * 2/3
                                return parent.height * 2/3
                            }
                            family: Fonts.sfyFont
                        }
                        text: controlValue
                        cursorPosition: 0
                        cursorVisible: true
                        selectByMouse: true
                        color: !textValue.acceptableInput ? "red" : Colors.skinMenuBGD
                        selectionColor: Colors.skinFrameTXT
                        selectedTextColor: Colors.themeMainColor
                        inputMethodHints: Qt.ImhPreferNumbers
                        validator: numberValidator
                        inputMask: ""
                        onAccepted: setValue(text)
                        Keys.onEnterPressed: setValue(text)

                        IntValidator {
                            id: numberValidator

                            top: maximum; bottom: minimum
                        }
                    }
                }
                Row {
                    width: parent.width; height: parent.height/4
                    anchors.right: parent.right
                    spacing:10

                    Item {
                        height: parent.height; width: (parent.width - parent.spacing)/2

                        Button {
                            anchors.centerIn: parent
                            width: parent.width*0.75; height: Utils.limitMax(parent.height, 40)
                            text: qsTr("Cancel")
                            isFlat: true
                            onClicked: cancelPressed()
                        }
                    }
                    Item {
                        height: parent.height; width: (parent.width - parent.spacing)/2

                        Button {
                            anchors.centerIn: parent
                            width: parent.width*0.75; height: Utils.limitMax(parent.height, 40)
                            text: qsTr("OK")
                            isFlat: true
                            onClicked: setValue(textValue.text)
                        }
                    }
                }
            }
        }
    }
}
