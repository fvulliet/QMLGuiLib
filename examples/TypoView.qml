import QtQuick 2.9
import GuiLib 1.0


Item {
    id: typoView

    property string _trContext: "TypoView"
    //: no translation needed for this sentence
    //~ Context this is latin !
    property string _lorem: QT_TR_NOOP("Lorem ipsum dolor sit amet, consectetur adipisicing elit, " +
                            "sed do eiusmod tempor incididunt ut labore et dolore magna " +
                            "aliqua.")
    //: will be somehow rendered with capital letters
    property string _startTxt: QT_TR_NOOP("start")
    property string _chbxTxt: QT_TR_NOOP("Checkbox")

    DemoHeader {
        id: header
        width: parent.width; height: parent.height / 15
        anchors.top: parent.top
        //: this text will be somehow rendered with capital letters
        title: QT_TR_NOOP("TYPOGRAPHY"); trContext: _trContext
    }

    Column {
        id: clmn
        property int nbItems: 3

        anchors.top: header.bottom; anchors.topMargin: Style.stdMargin
        anchors.bottom: parent.bottom
        width: parent.width
        spacing: 10

        Rectangle {
            border.width: 1; border.color: Colors.skinFrameTXT
            height: clmn.height/clmn.nbItems; width: parent.width
            color: Colors.skinFrameFGD
            Item {
                id: textSection
                height: 50; width: parent.width
                Column {
                    anchors.fill: parent; spacing: 2
                    TrText {
                        anchors.horizontalCenter: parent.horizontalCenter
                        font { family: Fonts.sfyFont; pixelSize: 18;
                            weight: Font.Bold }
                        color: Colors.skinFrameTXT
                        //: do not translate "DEJA-VU"
                        content: QT_TR_NOOP("This text in DEJA-VU font")
                        context: _trContext
                    }
                    TrText {
                        anchors.horizontalCenter: parent.horizontalCenter
                        font { family: Fonts.sfyFont; pixelSize: 16 }
                        color: Colors.skinFrameTXT
                        content: QT_TR_NOOP("default font ; free licence ; good international potential")
                        context: _trContext
                    }
                    TrText {
                        anchors.left: parent.left; anchors.leftMargin: 2
                        anchors.right: parent.right
                        font { family: Fonts.sfyFont; pixelSize: 14 }
                        color: Colors.skinFrameTXT
                        elide: Text.ElideRight
                        content: _lorem
                        context: _trContext
                    }
                }
            }
            Row {
                anchors.top: textSection.bottom; anchors.bottom: parent.bottom
                width: parent.width
                Item {
                    width: parent.width / 2; height: parent.height
                    Button {
                        anchors.centerIn: parent
                        height: 40; width: 150
                        text: _startTxt; trContext: _trContext
                    }
                }
                Item {
                    width: parent.width / 2; height: parent.height
                    CheckBox {
                        height: 30
                        anchors.left: parent.left; anchors.leftMargin: 30
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: checked = !checked
                        text: _chbxTxt; trContext: _trContext
                    }
                }
            }
        }

        Rectangle {
            border.width: 1; border.color: Colors.skinFrameTXT
            height: clmn.height/clmn.nbItems; width: parent.width
            color: Colors.skinFrameFGD
            Item {
                id: textSection2
                height: 50; width: parent.width
                Column {
                    anchors.fill: parent; spacing: 2
                    TrText {
                        anchors.horizontalCenter: parent.horizontalCenter
                        font { family: Fonts.sfyFontOpenSans; pixelSize: 18;
                            weight: Font.Bold }
                        color: Colors.skinFrameTXT
                        //: do not translate "OPEN-SANS"
                        content: QT_TR_NOOP("This text in OPEN-SANS font")
                        context: _trContext
                    }
                    TrText {
                        anchors.horizontalCenter: parent.horizontalCenter
                        font { family: Fonts.sfyFontOpenSans; pixelSize: 16 }
                        color: Colors.skinFrameTXT
                        //: do not translate "apache"
                        content: QT_TR_NOOP("apache licence ; bigger international potential")
                        context: _trContext
                    }
                    TrText {
                        anchors.left: parent.left; anchors.leftMargin: 2
                        anchors.right: parent.right
                        font { family: Fonts.sfyFontOpenSans; pixelSize: 14 }
                        color: Colors.skinFrameTXT
                        content: _lorem
                        context: _trContext
                    }
                }
            }
            Row {
                anchors.top: textSection2.bottom; anchors.bottom: parent.bottom
                width: parent.width

                Item {
                    width: parent.width / 2; height: parent.height
                    Button {
                        anchors.centerIn: parent
                        height: 40; width: 150
                        ctrlFont: Fonts.sfyFontOpenSans
                        text: _startTxt; trContext: _trContext
                    }
                }
                Item {
                    width: parent.width / 2; height: parent.height
                    CheckBox {
                        height: 30
                        anchors.left: parent.left; anchors.leftMargin: 30
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: checked = !checked
                        ctrlFont: Fonts.sfyFontOpenSans
                        text: _chbxTxt; trContext: _trContext
                    }
                }
            }
        }

        Rectangle {
            border.width: 1; border.color: Colors.skinFrameTXT
            height: clmn.height/clmn.nbItems; width: parent.width
            color: Colors.skinFrameFGD
            Item {
                id: textSection3
                height: 50; width: parent.width
                Column {
                    anchors.fill: parent; spacing: 2
                    TrText {
                        anchors.horizontalCenter: parent.horizontalCenter
                        font { family: Fonts.sfyFontDinReg; pixelSize: 18;
                            weight: Font.Bold }
                        color: Colors.skinFrameTXT
                        //: do not translate "DIN"
                        content: QT_TR_NOOP("This text in DIN font"); context: _trContext
                    }
                    TrText {
                        anchors.horizontalCenter: parent.horizontalCenter
                        font { family: Fonts.sfyFontDinReg; pixelSize: 16 }
                        color: Colors.skinFrameTXT
                        //: do not translate "Somfy"
                        content: QT_TR_NOOP("Somfy communication font"); context: _trContext
                    }
                    TrText {
                        anchors.left: parent.left; anchors.leftMargin: 2
                        anchors.right: parent.right
                        font { family: Fonts.sfyFontDinReg; pixelSize: 14 }
                        color: Colors.skinFrameTXT
                        content: _lorem
                        context: _trContext
                    }
                }
            }
            Row {
                anchors.top: textSection3.bottom; anchors.bottom: parent.bottom
                width: parent.width

                Item {
                    width: parent.width / 2; height: parent.height
                    Button {
                        anchors.centerIn: parent
                        height: 40; width: 150
                        ctrlFont: Fonts.sfyFontDinReg
                        text: _startTxt; trContext: _trContext
                    }
                }
                Item {
                    width: parent.width / 2; height: parent.height
                    CheckBox {
                        height: 30
                        anchors.left: parent.left; anchors.leftMargin: 30
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: checked = !checked
                        ctrlFont: Fonts.sfyFontDinReg
                        text: _chbxTxt; trContext: _trContext
                    }
                }
            }
        }
    }
}
