import QtQuick 2.9
import GuiLib 1.0


Item {
    id: root
    property string _trContext: "ControlsView2"

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
                    //: controls deal with usual widgets
                    title: QT_TR_NOOP("CONTROLS 1"); trContext: _trContext
                }
                Item {
                    width: parent.width; height: parent.height - header.height
                    Column {
                        property int _nbItems: 3
                        anchors.fill: parent

                        Item {
                            height: parent.height / parent._nbItems; width: parent.width

                            Item {
                                id: rbItem
                                width: parent.width / 2; height: parent.height

                                Item {
                                    id: rbTitle
                                    width: parent.width; height: parent.height/10
                                    anchors.margins: Utils.bound(parent.height/10,10,50)
                                    TrText {
                                        anchors.centerIn: parent
                                        font { family: Fonts.sfyFont; bold: true; pixelSize: 18;
                                            capitalization: Font.AllUppercase; underline: true }
                                        color: Colors.skinFrameTXT
                                        content: QT_TR_NOOP("RADIO BUTTONS"); context: _trContext
                                    }
                                }
                                RadioButton {
                                    id: rbtn1
                                    width: parent.width; height: parent.height/15
                                    text: QT_TR_NOOP("Disabled"); trContext: _trContext
                                    anchors { top: rbTitle.bottom
                                        left: parent.left; leftMargin: parent.width/10
                                        right: parent.right; rightMargin: parent.width/10
                                    }
                                    checked: globalSettings.rb1
                                    onCheckedChanged: globalSettings.rb1 = checked
                                    onClicked: checked = !checked
                                    enabled: false
                                }
                                RadioButton {
                                    id: rbtn2
                                    width: parent.width; height: 2*rbtn1.height
                                    text: QT_TR_NOOP("Button2 with long text"); trContext: _trContext
                                    anchors {
                                        top: rbtn1.bottom; topMargin: Style.stdMargin
                                        left: parent.left; leftMargin: parent.width/10
                                        right: parent.right; rightMargin: parent.width/10
                                    }
                                    checked: globalSettings.rb2
                                    onCheckedChanged: globalSettings.rb2 = checked
                                    onClicked: checked = !checked
                                }
                                RadioButton {
                                    id: rbtn3
                                    width: parent.width; height: 3*rbtn1.height
                                    //: this should not be longer than 10 characters
                                    text: QT_TR_NOOP("Button3"); trContext: _trContext
                                    anchors {
                                        top: rbtn2.bottom; topMargin: Style.stdMargin
                                        left: parent.left; leftMargin: parent.width/10
                                        right: parent.right; rightMargin: parent.width/10
                                    }
                                    checked: globalSettings.rb3
                                    onCheckedChanged: globalSettings.rb3 = checked
                                    onClicked: checked = !checked
                                }
                                RadioButton {
                                    id: rbtn4
                                    width: parent.width; height: 4*rbtn1.height
                                    text: QT_TR_NOOP("Button with very long text, therefore fitted"); trContext: _trContext
                                    anchors {
                                        top: rbtn3.bottom; topMargin: Style.stdMargin
                                        left: parent.left; leftMargin: parent.width/10
                                        right: parent.right; rightMargin: parent.width/10
                                    }
                                    checked: globalSettings.rb4
                                    onCheckedChanged: globalSettings.rb4 = checked
                                    onClicked: checked = !checked
                                }
                            }
                            Item {
                                id: cbItem
                                width: parent.width / 2; height: parent.height
                                anchors.right: parent.right

                                Item {
                                    id: cbTitle
                                    width: parent.width; height: parent.height/10
                                    anchors { margins: parent.width/20 }
                                    TrText {
                                        id: cbTxt
                                        anchors.centerIn: parent
                                        font { family: Fonts.sfyFont; bold: true; pixelSize: 18;
                                            capitalization: Font.AllUppercase; underline: true }
                                        color: Colors.skinFrameTXT
                                        content: QT_TR_NOOP("CHECKBOXES"); context: _trContext
                                    }
                                }
                                CheckBox {
                                    id: cb1
                                    height: parent.height/10
                                    text: QT_TR_NOOP("Disabled"); trContext: _trContext
                                    anchors {
                                        top: cbTitle.bottom
                                        left: parent.left; leftMargin: parent.width/10
                                        right: parent.right; rightMargin: parent.width/10
                                    }
                                    checked: globalSettings.cb1
                                    onCheckedChanged: globalSettings.cb1 = checked
                                    onClicked: checked = !checked
                                    enabled: false
                                }
                                CheckBox {
                                    id: cb2
                                    height: 2*cb1.height
                                    text: QT_TR_NOOP("Checkbox2 with long text"); trContext: _trContext
                                    anchors {
                                        top: cb1.bottom; topMargin: Style.stdMargin
                                        left: parent.left; leftMargin: parent.width/10
                                        right: parent.right; rightMargin: parent.width/10
                                    }
                                    checked: globalSettings.cb2
                                    onCheckedChanged: globalSettings.cb2 = checked
                                    onClicked: checked = !checked
                                }
                                CheckBox {
                                    id: cb3
                                    height: 3*cb1.height
                                    text: QT_TR_NOOP("Checkbox3"); trContext: _trContext
                                    anchors {
                                        top: cb2.bottom; topMargin: Style.stdMargin
                                        left: parent.left; leftMargin: parent.width/10
                                        right: parent.right; rightMargin: parent.width/10
                                    }
                                    checked: globalSettings.cb3
                                    onCheckedChanged: globalSettings.cb3 = checked
                                    onClicked: checked = !checked
                                }
                            }
                        }
                        Item {
                            id: swItem
                            height: parent.height / parent._nbItems; width: parent.width

                            Item {
                                id: swTitle
                                width: parent.width; height: parent.height/10
                                anchors.margins: Utils.bound(parent.height/10,10,50)
                                TrText {
                                    anchors.centerIn: parent
                                    font { family: Fonts.sfyFont; bold: true; pixelSize: 18;
                                        capitalization: Font.AllUppercase; underline: true }
                                    color: Colors.skinFrameTXT
                                    content: QT_TR_NOOP("SWITCHES"); context: _trContext
                                }
                            }
                            Row {
                                id: switches
                                width: parent.width*0.8
                                height: parent.height - swTitle.height
                                anchors.top: swTitle.bottom
                                anchors.horizontalCenter: parent.horizontalCenter

                                Item {
                                    height: parent.height; width: parent.width / 4

                                    Switch {
                                        id: sw1
                                        height: parent.height/8; width: parent.width
                                        label: QT_TR_NOOP("Disabled"); trContext: _trContext
                                        anchors.centerIn: parent
                                        checked: globalSettings.sw1
                                        onCheckedChanged: globalSettings.sw1 = checked
                                        onClicked: {
                                            if (checked <= 0)
                                                checked = 1
                                            else
                                                checked = 0
                                        }
                                        enabled: false
                                    }
                                }
                                Item {
                                    height: parent.height; width: parent.width / 4

                                    Switch {
                                        id: sw2

                                        slide: true
                                        height: 1.5*sw1.height; width: parent.width
                                        label: QT_TR_NOOP("Slide with long text"); trContext: _trContext
                                        anchors.centerIn: parent
                                        checked: globalSettings.sw2
                                        onCheckedChanged: globalSettings.sw2 = checked
                                        onClicked: {
                                            if (checked <= 0)
                                                checked = 1
                                            else
                                                checked = 0
                                        }
                                    }
                                }
                                Item {
                                    height: parent.height; width: parent.width / 4

                                    Switch {
                                        id: sw3
                                        height: sw2.height; width: parent.width / 3
                                        label: QT_TR_NOOP("Normal"); trContext: _trContext
                                        anchors.centerIn: parent
                                        checked: globalSettings.sw3
                                        onCheckedChanged: globalSettings.sw3 = checked
                                        onClicked: {
                                            if (checked <= 0)
                                                checked = 1
                                            else
                                                checked = 0
                                        }
                                        labelOnRight: false
                                    }
                                }
                                Item {
                                    height: parent.height; width: parent.width / 4

                                    Switch {
                                        id: sw4
                                        height: sw2.height; width: parent.width / 3
                                        label: QT_TR_NOOP("Undef"); trContext: _trContext
                                        anchors.centerIn: parent
                                        checked: -1
                                        onCheckedChanged: globalSettings.sw4 = checked
                                        onClicked: {
                                            if (checked <= 0)
                                                checked = 1
                                            else
                                                checked = 0
                                        }
                                    }
                                }
                            }
                        }
                        Item {
                            id: btnItem
                            height: parent.height / parent._nbItems; width: parent.width

                            Item {
                                id: btnTitle
                                width: parent.width; height: parent.height/10
                                anchors.margins: Utils.bound(parent.height/10,10,50)
                                TrText {
                                    anchors.centerIn: parent
                                    font { family: Fonts.sfyFont; bold: true; pixelSize: 18;
                                        capitalization: Font.AllUppercase; underline: true }
                                    color: Colors.skinFrameTXT
                                    content: QT_TR_NOOP("BUTTONS"); context: _trContext
                                }
                            }
                            Item {
                                id: buttons
                                width: parent.width; height: parent.height - btnTitle.height
                                anchors.top: btnTitle.bottom

                                Row {
                                    property int _nbItems: 6
                                    anchors.fill: parent

                                    Item {
                                        height: parent.height; width: buttons.width / parent._nbItems

                                        Button {
                                            height: parent.height/4; width: parent.width*0.8
                                            anchors.centerIn: parent
                                            isFlat: true
                                            text: QT_TR_NOOP("FLAT"); trContext: _trContext
                                        }
                                    }
                                    Item {
                                        height: parent.height; width: buttons.width / parent._nbItems

                                        Button {
                                            height: parent.height/4; width: parent.width*0.8
                                            anchors.centerIn: parent
                                            isFlat: true
                                            enabled: false
                                            text: QT_TR_NOOP("DISABLED"); trContext: _trContext
                                        }
                                    }
                                    Item {
                                        height: parent.height; width: buttons.width / parent._nbItems

                                        Button {
                                            height: parent.height/4; width: parent.width*0.8
                                            anchors.centerIn: parent
                                            isFlat: false
                                            text: QT_TR_NOOP("NORMAL WITH LONG TEXT"); trContext: _trContext
                                        }
                                    }
                                    Item {
                                        height: parent.height; width: buttons.width / parent._nbItems

                                        Button {
                                            height: parent.height/4; width: parent.width*0.8
                                            anchors.centerIn: parent
                                            isFlat: false
                                            enabled: false
                                            text: QT_TR_NOOP("DISABLED"); trContext: _trContext
                                        }
                                    }
                                    Item {
                                        height: parent.height; width: buttons.width / parent._nbItems

                                        PressedIcon {
                                            width: height; height: parent.height/4
                                            anchors.centerIn: parent
                                            lib: Fonts.faSolid
                                            icon: FontAwesomeSolid.Icon.PlusSign
                                            color: Colors.skinFrameTXT
                                        }
                                    }
                                    Item {
                                        height: parent.height; width: buttons.width / parent._nbItems

                                        IconButton {
                                            width: height; height: parent.height/4
                                            anchors.centerIn: parent
                                            borderColor: Colors.skinFrameTXT
                                            borderWidth: 1
                                            lib: Fonts.faSolid
                                            icon: FontAwesomeSolid.Icon.ThumbsUp
                                            iconColor: Colors.themeMainColor
                                            ctnrColor: "white"
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
}
