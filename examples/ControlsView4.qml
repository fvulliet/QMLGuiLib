import QtQuick
import GuiLib 1.0
import QtQuick.Controls


Item {
    id: controlsView4

    property int _gapFromTitle: 30
    property string _trContext: "ControlsView4"

    FocusScope {
        anchors.fill: parent

        Rectangle {
            id: frame

            anchors.fill: parent
            color: Colors.skinFrameFGD

            MouseArea {
                anchors.fill: parent
                onClicked: parent.focus = true
            }

            Column {
                anchors.fill: parent

                DemoHeader {
                    id: header

                    width: parent.width; height: parent.height / 15
                    title: QT_TR_NOOP("CONTROLS 3"); trContext: _trContext
                }
                Column {
                    width: parent.width; height: parent.height - header.height

                    Item {
                        id: title

                        width: parent.width; height: 50

                        TrText {
                            anchors.centerIn: parent
                            font { family: Fonts.sfyFont; bold: true; pixelSize: 18;
                                capitalization: Font.AllUppercase; underline: true }
                            color: Colors.skinFrameTXT
                            content: QT_TR_NOOP("TEXT INPUT"); context: _trContext
                        }
                    }
                    Row {
                        height: parent.height - title.height
                        anchors {
                            left: parent.left; leftMargin: 20
                            right: parent.right; rightMargin: 20
                        }

                        Column {
                            id: colCtnr

                            property real _itemHeight: height/6

                            height: parent.height; width: parent.width/2

                            Item {
                                width: parent.width; height: colCtnr._itemHeight

                                SfyTextInput {
                                    id: txtinput2

                                    width: parent.width; height: parent.height * 0.75
                                    anchors.centerIn: parent
                                    readOnly: true
                                    notFocusedColor: Colors.skinFrameTXT
                                    focusedColor: Colors.themeMainColor
                                }
                            }
                            Item {
                                width: parent.width; height: colCtnr._itemHeight

                                SfyTextInput {
                                    id: txtinput3

                                    width: parent.width; height: parent.height * 0.5
                                    anchors.centerIn: parent
                                    text: "abcdefghijklmnopqrstuvwxyz"
                                }
                            }
                            Item {
                                width: parent.width; height: colCtnr._itemHeight

                                SfyTextInput {
                                    width: parent.width; height: parent.height * 0.45
                                    anchors.centerIn: parent
                                    placeholderText: "km/h"
                                }
                            }

                            Item {
                                width: parent.width; height: colCtnr._itemHeight

                                SfyTextInput {
                                    width: parent.width; height: parent.height * 0.4
                                    anchors.centerIn: parent
                                    unit:"km/h"
                                    alwaysShowIcon: true
                                }
                            }
                            Item {
                                width: parent.width; height: colCtnr._itemHeight

                                SfyTextInput {
                                    width: parent.width; height: parent.height * 0.35
                                    anchors.centerIn: parent
                                    unit:"km/h"
                                    placeholderText: "speed"
                                }
                            }

                            Item {
                                width: parent.width; height: colCtnr._itemHeight

                                SfyTextInput {
                                    id: txtInputValid

                                    anchors.centerIn: parent
                                    width: parent.width; height: parent.height * 0.4
                                    validator: RegularExpressionValidator {
                                        regularExpression: /[0-9A-F]+/ }
                                    placeholderText: qsTr("numbers only")
                                }
                            }
                        }
                        Column {
                            height: parent.height*0.9; width: parent.width/2
                            anchors.verticalCenter: parent.verticalCenter

                            Column {
                                width: parent.width*3/4; height: parent.height*3/7
                                anchors.horizontalCenter: parent.horizontalCenter

                                Item {
                                    width: parent.width; height: parent.height/4

                                    Text {
                                        anchors.fill: parent
                                        verticalAlignment: Text.AlignVCenter
                                        font {
                                            family: Fonts.sfyFont
                                            pixelSize: 20
                                            bold: true
                                        }
                                        color: Colors.skinFrameTXT
                                        text: "TextEdit"
                                        wrapMode: TextEdit.WordWrap
                                    }
                                }
                                Rectangle {
                                    width: parent.width; height: parent.height*3/4
                                    border.width: 1; border.color: Colors.skinFrameTXT

                                    TextEdit {
                                        anchors.fill: parent; anchors.margins: 10
                                        font {
                                            family: Fonts.sfyFont
                                            pixelSize: 20
                                        }
                                        color: Colors.skinFrameTXT
                                        wrapMode: TextEdit.WordWrap
                                    }
                                }
                            }
                            Item {
                                width: parent.width; height: parent.height*1/7
                            }
                            Column {
                                width: parent.width*3/4; height: parent.height*3/7
                                anchors.horizontalCenter: parent.horizontalCenter

                                Item {
                                    width: parent.width; height: parent.height/4

                                    Text {
                                        anchors.fill: parent
                                        verticalAlignment: Text.AlignVCenter
                                        font {
                                            family: Fonts.sfyFont
                                            pixelSize: 20
                                            bold: true
                                        }
                                        color: Colors.skinFrameTXT
                                        text: "TextArea"
                                        wrapMode: TextEdit.WordWrap
                                    }
                                }
                                Item {
                                    width: parent.width; height: parent.height*3/4

                                    SfyTextArea {
                                        anchors.fill: parent
                                        textColor: Colors.skinFrameTXT
                                        textPixelSize: 20
                                        placeholderText: "placeholder text"
                                        cursorPosition: 0
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
