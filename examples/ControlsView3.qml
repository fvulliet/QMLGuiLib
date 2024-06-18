import QtQuick
import GuiLib 1.0

FocusScope {
    id: controlsView3

    property int _gapFromTitle: 30
    property string _trContext: "ControlsView3"

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
                title: QT_TR_NOOP("CONTROLS 2"); trContext: _trContext
            }
            Column {
                width: parent.width; height: parent.height - header.height

                Item {
                    id: ddTitle

                    width: parent.width; height: 50

                    TrText {
                        anchors.centerIn: parent
                        font { family: Fonts.sfyFont; bold: true; pixelSize: 18;
                            capitalization: Font.AllUppercase; underline: true }
                        color: Colors.skinFrameTXT
                        content: QT_TR_NOOP("DROPDOWN"); context: _trContext
                    }
                }
                Column {
                    width: parent.width; height: parent.height - ddTitle.height

                    Item {
                        id: dd1Ctnr

                        height: parent.height/4; width: parent.width/2
                        anchors.horizontalCenter: parent.horizontalCenter

                        Dropdown {
                            id: dd1

                            height: 60; width: parent.width
                            anchors.centerIn: parent
                            model: myModel
                            validator: RegularExpressionValidator { }
                            readOnly: false
                            maxVisibleItems: 4
                            notFocusedColor: Colors.skinFrameTXT
                            focusedColor: Colors.themeMainColor
                            currentIndex: globalSettings.dd1
                            onCurrentIndexChanged: globalSettings.dd1 = currentIndex
                            onElementSelected: globalSettings.dd1 = index
                            onStateChanged: {
                                if (state !== "HIDDEN")
                                    dd1Ctnr.z = 3
                                else
                                    dd1Ctnr.z = 1
                            }
                        }
                    }
                    Item {
                        id: dd2Ctnr

                        height: parent.height/4; width: parent.width/2
                        anchors.horizontalCenter: parent.horizontalCenter

                        Dropdown {
                            id: dd2

                            height: 40; width: parent.width
                            anchors.centerIn: parent
                            model: myModel
                            readOnly: true
                            notFocusedColor: "blue"
                            focusedColor: "pink"
                            currentIndex: globalSettings.dd2
                            onCurrentIndexChanged: globalSettings.dd2 = currentIndex
                            onElementSelected: globalSettings.dd2 = index
                            onStateChanged: {
                                if (state !== "HIDDEN")
                                    dd2Ctnr.z = 3
                                else
                                    dd2Ctnr.z = 1
                            }
                            unrollShift: 3
                        }
                    }
                    Item {
                        id: dd3Ctnr

                        height: parent.height/4; width: parent.width/2
                        anchors.horizontalCenter: parent.horizontalCenter

                        Dropdown {
                            id: dd3

                            height: 20; width: parent.width
                            anchors.centerIn: parent
                            model: myModel
                            readOnly: true
                            currentIndex: globalSettings.dd3
                            onCurrentIndexChanged: globalSettings.dd3 = currentIndex
                            onElementSelected: globalSettings.dd3 = index
                            onStateChanged: {
                                if (state !== "HIDDEN")
                                    dd3Ctnr.z = 3
                                else
                                    dd3Ctnr.z = 1
                            }
                            unrollShift: -1
                        }
                    }
                    Item {
                        id: cboxCtnr

                        height: parent.height/4; width: parent.width/2
                        anchors.horizontalCenter: parent.horizontalCenter

                        ComboBox {
                            height: 20; width: parent.width
                            items: ["Item 1", "Item 2", "Item 3"]
                        }
                    }
                }
            }

        }
    }

    ListModel {
        id: myModel
        Component.onCompleted: {
            for (var i=0 ; i<10; ++i) {
                if (i%2 === 0)
                    append({ name: QT_TR_NOOP("abcdefghijklmnopqrstuvwxyz") + i.toString(), trContext: _trContext })
                else
                    append({ name: QT_TR_NOOP("item") + i.toString(), trContext: _trContext })
            }
        }
    }
}
