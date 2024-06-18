
import QtQuick 2.2
import QtTest 1.0
import GuiLib 1.0
import "."

Rectangle {
    id: root
    width: 1280
    height: 800

    property string currentTheme: "standard"
    property string currentSkin: "bright"

    Rectangle {
        id: themes
        height: parent.height
        width: parent.width * 0.2

        Rectangle {
            id: themesList
            anchors.fill: parent

            ListView {
                id: listView
                property int itemHeight
                anchors.fill: parent
                spacing: 1

                Component.onCompleted: {
                    itemHeight = parent.height / count
                }

                onCurrentIndexChanged: {
                    currentTheme = model.get(currentIndex).name
                    Colors.setThemeName(currentTheme)
                }

                delegate: Component {
                    Rectangle {
                        width: ListView.view.width
                        height: ListView.view.itemHeight
                        color: Colors.skinMenuBGD

                        Rectangle {
                            id: colorCircle
                            height: parent.height / 2
                            width: height
                            radius: height / 2
                            color: col
                            anchors {
                                left: parent.left
                                leftMargin: colorCircle.width / 2
                                verticalCenter: parent.verticalCenter
                            }
                        }
                        Text {
                            id: buttonText
                            anchors {
                                left: parent.horizontalCenter
                                verticalCenter: parent.verticalCenter
                            }
                            text: name
                            font { family: Fonts.sfyFont; pointSize: 12; capitalization: Font.AllUppercase }
                            color: Colors.skinMenuTXT
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                parent.ListView.view.currentIndex = index;
                            }
                        }
                    }
                }
                currentIndex: 0
                boundsBehavior : Flickable.StopAtBounds
                highlightFollowsCurrentItem: false
                model: ListModel {
                    ListElement { name: "standard"; col: "#f8b414" }
                    ListElement { name: "office"; col: "#047caa" }
                    ListElement { name: "education"; col: "#ea7c1d" }
                    ListElement { name: "hospitality"; col: "#44a9b9" }
                    ListElement { name: "healthcare"; col: "#9bcc58" }
                }
            }
        }
    }

    Rectangle {
        id: demo
        height: parent.height
        anchors.left: themes.right
        anchors.right: parent.right
        color: Colors.skinFrameBGD

        FocusScope {
            anchors.fill: parent
            Rectangle {
                id: frame
                anchors.fill: parent
                anchors.margins: 20
                color: Colors.skinFrameFGD

                MouseArea {
                    anchors.fill: parent
                    onClicked: parent.focus = true
                }

                Rectangle {
                    id: header
                    width: parent.width
                    height: parent.height / 10
                    anchors.top: parent.top
                    color: Colors.themeMainColor
                    Item {
                        width: parent.width / 2
                        height: parent.height
                        anchors.left: parent.left
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            color: Colors.skinMenuTXT
                            font { pixelSize: parent.height / 2; capitalization: Font.AllUppercase }
                            text: currentTheme
                        }
                    }
                    Item {
                        width: parent.width / 2
                        height: parent.height
                        anchors.right: parent.right
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            color: Colors.skinMenuTXT
                            font { pixelSize: parent.height / 2; capitalization: Font.AllUppercase }
                            text: currentSkin
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                currentSkin = (currentSkin === "dark") ? "bright" : "dark"
                                Colors.setSkinName(currentSkin)
                            }
                        }
                    }
                }

                Item {
                    id: rbItem
                    width: parent.width / 2
                    anchors {
                        top: header.bottom
                        left: parent.left
                    }

                    Item {
                        id: rbTitle
                        width: parent.width
                        height: 25
                        anchors.top: parent.top
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            font { bold: true; pixelSize: 18; capitalization: Font.AllUppercase }
                            color: Colors.skinFrameTXT
                            text: "RADIO BUTTONS"
                        }
                    }

                    RadioButton {
                        id: rbtn1
                        height: 20
                        text: "BUTTON1"
                        checked: false
                        anchors {
                            top: rbTitle.bottom
                            topMargin: 10
                            left: parent.left
                            leftMargin: 50
                            right: parent.right
                            rightMargin: 50
                        }
                        onClicked: {
                            checked = ! checked
                        }
                    }
                    RadioButton {
                        id: rbtn2
                        height: 40
                        text: "BUTTON2"
                        checked: false
                        anchors {
                            top: rbtn1.bottom
                            topMargin: 10
                            left: parent.left
                            leftMargin: 50
                            right: parent.right
                            rightMargin: 50
                        }
                        onClicked: {
                            checked = ! checked
                        }
                    }
                    RadioButton {
                        id: rbtn3
                        height: 60
                        text: "BUTTON3"
                        checked: false
                        anchors {
                            top: rbtn2.bottom
                            topMargin: 10
                            left: parent.left
                            leftMargin: 50
                            right: parent.right
                            rightMargin: 50
                        }
                        onClicked: {
                            checked = ! checked
                        }
                    }
                }

                Item {
                    id: cbItem
                    width: parent.width / 2
                    height: 200
                    anchors {
                        top: header.bottom
                        left: rbItem.right
                    }

                    Item {
                        id: cbTitle
                        width: parent.width
                        height: 25
                        anchors.top: parent.top
                        Text {
                            id: cbTxt
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            font { bold: true; pixelSize: 18 }
                            color: Colors.skinFrameTXT
                            text: "CHECKBOXES"
                        }
                    }

                    CheckBox {
                        id: cb1
                        height: 20
                        text: "CHECKBOX1"
                        checked: false
                        anchors {
                            top: cbTitle.bottom
                            topMargin: 10
                            left: parent.left
                            leftMargin: 50
                            right: parent.right
                            rightMargin: 50
                        }
                        onClicked: {
                            checked = ! checked
                        }
                    }
                    CheckBox {
                        id: cb2
                        height: 40
                        text: "CHECKBOX2"
                        checked: false
                        anchors {
                            top: cb1.bottom
                            topMargin: 10
                            left: parent.left
                            leftMargin: 50
                            right: parent.right
                            rightMargin: 50
                        }
                        onClicked: {
                            checked = ! checked
                        }
                    }
                    CheckBox {
                        id: cb3
                        height: 60
                        text: "CHECKBOX3"
                        checked: false
                        anchors {
                            top: cb2.bottom
                            topMargin: 10
                            left: parent.left
                            leftMargin: 50
                            right: parent.right
                            rightMargin: 50
                        }
                        onClicked: {
                            checked = ! checked
                        }
                    }
                }

                Item {
                    id: dropdownTitle
                    width: parent.width
                    height: 25
                    anchors.top: cbItem.bottom
                    anchors.topMargin: 30
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font { bold: true; pixelSize: 18 }
                        color: Colors.skinFrameTXT
                        text: "DROPDOWN"
                    }
                }

                Item {
                    id: dd1Label
                    width: 50
                    height: 40
                    anchors {
                        top: dropdownTitle.bottom
                        topMargin: 10
                        left: parent.left
                        leftMargin: width / 2
                    }
                    Text {
                        horizontalAlignment: Text.AlignRight
                        anchors.verticalCenter: parent.verticalCenter
                        font { bold: true; pixelSize: 18 }
                        color: Colors.skinFrameTXT
                        text: "label"
                    }
                }
                Dropdown {
                    id: dd1
                    height: 40; width: parent.width/4
                    anchors {
                        top: dropdownTitle.bottom
                        topMargin: 10
                        left: dd1Label.right
                        leftMargin: 5
                    }
                    z: frame.z + 1
                    model: myModel
                    validator: RegExpValidator { }
                    readOnly: false
                    maxVisibleItems: 4
                }
                Dropdown {
                    id: dd2
                    height: 60; width: parent.width/4
                    anchors {
                        top: dropdownTitle.bottom
                        topMargin: 10
                        left: parent.horizontalCenter
                        leftMargin: width / 2
                    }
                    z: frame.z + 1
                    model: myModel
                    readOnly: true
                }

                Item {
                    id: swTitle
                    width: parent.width
                    height: 25
                    anchors.top: dd2.bottom
                    anchors.topMargin: 30
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font { bold: true; pixelSize: 18 }
                        color: Colors.skinFrameTXT
                        text: "SWITCHES"
                    }
                }

                Switch {
                    id: sw1
                    height: 20
                    width: parent.width / 4
                    label: "SWITCH1"
                    anchors {
                        top: swTitle.bottom
                        topMargin: 10
                        left: parent.left
                        leftMargin: 50
                    }
                    onClicked: {
                        checked = ! checked
                    }
                }
                Switch {
                    id: sw2
                    height: 40
                    width: parent.width / 4
                    label: "SWITCH1"
                    anchors {
                        top: swTitle.bottom
                        topMargin: 10
                        left: sw1.right
                        leftMargin: 50
                    }
                    onClicked: {
                        checked = ! checked
                    }
                }

                Item {
                    id: textInputTitle
                    width: parent.width
                    height: 25
                    anchors.top: sw2.bottom
                    anchors.topMargin: 30
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font { bold: true; pixelSize: 18 }
                        color: Colors.skinFrameTXT
                        text: "TEXT INPUT"
                    }
                }

                TextInput {
                    id: txtinput1
                    width: 240
                    height: 40
                    validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                    anchors {
                        top: textInputTitle.bottom
                        topMargin: 10
                        left: parent.left
                        leftMargin: width / 2
                    }
                }
                Item {
                    id: textInputLabel
                    width: labeltxt.contentWidth
                    height: 60
                    anchors {
                        top: textInputTitle.bottom
                        topMargin: 10
                        left: parent.horizontalCenter
                    }
                    Text {
                        id: labeltxt
                        horizontalAlignment: Text.AlignRight
                        anchors.verticalCenter: parent.verticalCenter
                        font { bold: true; pixelSize: 18 }
                        color: Colors.skinFrameTXT
                        text: "label"
                    }
                }
                TextInput {
                    id: txtinput2
                    width: 360
                    height: 60
                    anchors {
                        top: textInputTitle.bottom
                        topMargin: 10
                        left: textInputLabel.right
                        leftMargin: 10
                    }
                }

                Item {
                    id: btnTitle
                    width: parent.width
                    height: 25
                    anchors.top: txtinput2.bottom
                    anchors.topMargin: 30
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font { bold: true; pixelSize: 18 }
                        color: Colors.skinFrameTXT
                        text: "BUTTONS"
                    }
                }

                Item {
                    id: buttons
                    width: parent.width
                    height: 60
                    anchors.top: btnTitle.bottom

                    Button {
                        id: btn1
                        height: 45
                        width: parent.width / 4
                        isFlat: true
                        text: "BTN1"
                        anchors {
                            verticalCenter: parent.verticalCenter
                            left: parent.left
                            leftMargin: btn1.width / 2
                        }
                    }
                    Button {
                        id: btn2
                        height: 45
                        width: parent.width / 4
                        isFlat: false
                        text: "BTN2"
                        anchors {
                            verticalCenter: parent.verticalCenter
                            left: parent.horizontalCenter
                            leftMargin: btn2.width / 2
                        }
                    }
                }
            }
        }
    }

    TestCase {
        name: "-----ControlsTests-----"
        when: windowShown && true

        function test_themes() {
            var itemHeight = themes.height / 5
            mouseClick(themes, 10, 0*itemHeight + itemHeight/2)
            verify(currentTheme === "standard", "theme should be changed")

            mouseClick(themes, 10, 1*itemHeight + itemHeight/2)
            verify(currentTheme === "office", "theme should be changed")

            mouseClick(themes, 10, 2*itemHeight + itemHeight/2)
            verify(currentTheme === "education", "theme should be changed")

            mouseClick(themes, 10, 3*itemHeight + itemHeight/2)
            verify(currentTheme === "hospitality", "theme should be changed")

            mouseClick(themes, 10, 4*itemHeight + itemHeight/2)
            verify(currentTheme === "healthcare", "theme should be changed")
        }

        function test_focus() {
            keyClick(Qt.Key_Tab)
            verify(rbtn1.focus === true, "control should be focused")

            keyClick(Qt.Key_Tab)
            keyClick(Qt.Key_Tab)
            keyClick(Qt.Key_Tab)
            verify(cb1.focus === true, "control should be focused")

            keyClick(Qt.Key_Tab)
            keyClick(Qt.Key_Tab)
            keyClick(Qt.Key_Tab)
            verify(dd1.focus === true, "control should be focused")

            keyClick(Qt.Key_Tab)
            verify(dd2.focus === true, "control should be focused")

            keyClick(Qt.Key_Tab)
            verify(sw1.focus === true, "control should be focused")

            keyClick(Qt.Key_Tab)
            verify(sw2.focus === true, "control should be focused")

//            keyClick(Qt.Key_Tab)
//            verify(txtinput1.focus === true, "control should be focused")

//            keyClick(Qt.Key_Tab)
//            verify(txtinput2.focus === true, "control should be focused")

//            keyClick(Qt.Key_Tab)
//            verify(btn1.focus === true, "control should be focused")

//            keyClick(Qt.Key_Tab)
//            verify(btn2.focus === true, "control should be focused")

        }

        function test_textInputValidator() {
            mouseClick(txtinput1, 20, 20)
            verify(txtinput1.focus === true, "control should be focused")
            keyClick(Qt.Key_A)
            compare(txtinput1.text.length, 0, "text length should be null")
//            tryCompare(txtinput1, "lineColor", Colors.themeSignalKO, 300, "line should be KO")
//            keyClick(Qt.Key_1)
//            tryCompare(txtinput1, "state", "WRITING", 1000, "text should be written")
//            compare(txtinput1.text.length, 1, "text length should be 1")
//            compare(txtinput1.lineColor, Colors.themeSignalOK, "line should be OK")
        }

        function test_textInputPenNonValidable() {
            tryCompare(txtinput2, "focus", false, 1000, "control should not be focused")
//            tryCompare(txtinput2, "iconOpacity", 0, 1000, "pen should not be displayed")
//            mouseClick(txtinput2, 20, 20)
//            verify(txtinput2.focus === true, "control should be focused")
//            tryCompare(txtinput2, "iconOpacity", 1, 1000, "pen should be displayed")
//            keyClick(Qt.Key_A)
//            verify(txtinput2.text.length > 0, "text length should be 1")
//            tryCompare(txtinput2, "iconOpacity", 1, 1000, "pen still should be displayed")
//            mouseClick(txtinput1, 20, 20)
//            verify(txtinput2.focus === false, "control should not be focused")
//            tryCompare(txtinput2, "iconOpacity", 0, 1000, "pen should not be displayed")
//            keyClick(Qt.Key_Tab)
        }

        function test_textInputPenValidable() {
            verify(txtinput1.focus === false, "control should not be focused")
//            tryCompare(txtinput1, "iconOpacity", 1, 1000, "cross should be displayed")
//            mouseClick(txtinput1, 20, 20)
//            verify(txtinput1.focus === true, "control should be focused")
//            tryCompare(txtinput1, "iconOpacity", 1, 1000, "pen should be displayed")
//            mouseClick(txtinput2, 20, 20)
//            verify(txtinput1.focus === false, "control should not be focused")
//            tryCompare(txtinput1, "iconOpacity", 1, 1000, "cross should be displayed")
//            compare(txtinput1.iconType, FontAwesome.Icon.Remove, "cross should be displayed")
        }

        function test_textInputPlaceholder() {
            mouseClick(txtinput1, 20, 20)
            verify(txtinput1.focus === true, "control should be focused")
//            verify(txtinput1.placeholderReminderHeight === 0, "placeholderreminder should be canceled")
//            keyClick(Qt.Key_1)
//            tryCompare(txtinput1, "placeholderReminderHeight", txtinput1.maxPlaceHolderReminderHeight, 300, "placeholderreminder should be displayed")
//            txtinput1.text = ""
//            tryCompare(txtinput1, "placeholderReminderHeight", 0, 1000, "placeholderreminder should be canceled")
        }

        function test_disabled() {
            verify(rbtn1.checked === false, "radio button should not be checked")
            mouseClick(rbtn1, 5, 5)
            tryCompare(rbtn1, "checked", true, 500, "radio button should be checked")
            rbtn1.enabled = false
            mouseClick(rbtn1, 5, 5)
            tryCompare(rbtn1, "checked", true, 500, "radio button still should be checked")

            verify(cb1.checked === false, "checkbox should not be checked")
            mouseClick(cb1, 5, 5)
            tryCompare(cb1, "checked", true, 500, "checkbox should be checked")
            cb1.enabled = false
            mouseClick(cb1, 5, 5)
            tryCompare(cb1, "checked", true, 500, "checkbox still should be checked")

//            verify(sw1.checked === false, "switch should not be checked")
//            mouseClick(sw1, 5, 5)
//            tryCompare(sw1, "checked", true, 500, "switch should be checked")
//            sw1.enabled = false
//            mouseClick(sw1, 5, 5)
//            tryCompare(sw1, "checked", true, 500, "switch still should be checked")

//            cb1.enabled = true
//            rbtn1.enabled = true
//            sw1.enabled = true
        }
    }

    ListModel {
        id: myModel
        ListElement { name: "Item 1" }
        ListElement { name: "Item 2" }
        ListElement { name: "Item 3" }
        ListElement { name: "Item 4" }
        ListElement { name: "Item 5" }
        ListElement { name: "Item 6" }
        ListElement { name: "Item 7" }
    }
}
