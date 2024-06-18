import QtQuick 2.9
import GuiLib 1.0


Item {
    id: progressView

    property string _trContext: "ProgressView"

    DemoHeader {
        id: header
        width: parent.width; height: parent.height / 15
        anchors.top: parent.top
        title: QT_TR_NOOP("PROGRESS"); trContext: _trContext
    }

    Column {
        id: itemsCtnr

        height: parent.height * 2/3
        anchors {
            left: parent.left; right: parent.right; top: parent.top
        }

        Row {
            spacing: 1
            height: parent.height*2/3

            Item {
                width: itemsCtnr.width / 5
                height: parent.height

                ProgressItem {
                    id: progItem0

                    size: parent.height/4
                    anchors.centerIn: parent
                    bkgdColor: Colors.skinFrameFGD
                    innerIcon: FontIcon {
                        lib: Fonts.sfyIco; icon: SfyIco.Icon.Search
                        color: Colors.skinFrameTXT
                        size: parent.height
                    }
                }

                Text {
                    anchors {
                        top: progItem0.bottom; topMargin: 30
                        horizontalCenter: parent.horizontalCenter
                    }
                    horizontalAlignment: Text.AlignHCenter
                    color: Colors.skinFrameTXT
                    font { family: Fonts.sfyFont; pixelSize: 12 }
                    text: "0.5 s\nnormal sustain"
                }
            }

            Item {
                width: itemsCtnr.width / 5
                height: parent.height

                ProgressItem {
                    id: progItem1

                    size: parent.height/4
                    anchors.centerIn: parent
                    bkgdColor: Colors.skinFrameFGD
                    innerIcon: FontIcon {
                        lib: Fonts.sfyIco; icon: SfyIco.Icon.Search
                        color: Colors.skinFrameTXT
                        size: parent.height
                    }
                }

                Text {
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        top: progItem1.bottom; topMargin: 30
                    }
                    horizontalAlignment: Text.AlignHCenter
                    color: Colors.skinFrameTXT
                    font { family: Fonts.sfyFont; pixelSize: 12 }
                    text: "2 s\nnormal sustain"
                }
            }

            Item {
                width: itemsCtnr.width / 5
                height: parent.height

                ProgressItem {
                    id: progItem2

                    size: parent.height/4
                    anchors.centerIn: parent
                    bkgdColor: Colors.skinFrameFGD
                    innerIcon: FontIcon {
                        lib: Fonts.sfyIco; icon: SfyIco.Icon.Radar
                        color: Colors.skinFrameTXT
                        size: parent.height
                    }
                    withSustain: false
                }

                Text {
                    anchors {
                        top: progItem2.bottom; topMargin: 30
                        horizontalCenter: parent.horizontalCenter
                    }
                    horizontalAlignment: Text.AlignHCenter
                    color: Colors.skinFrameTXT
                    font { family: Fonts.sfyFont; pixelSize: 12 }
                    text: "5 s\nno sustain"
                }
            }

            Item {
                width: itemsCtnr.width / 5
                height: parent.height

                ProgressItem {
                    id: progItem3

                    size: parent.width
                    anchors.centerIn: parent
                    bkgdColor: Colors.skinFrameFGD
                }

                Text {
                    anchors {
                        top: progItem3.bottom; topMargin: 30
                        horizontalCenter: parent.horizontalCenter
                    }
                    horizontalAlignment: Text.AlignHCenter
                    color: Colors.skinFrameTXT
                    font { family: Fonts.sfyFont; pixelSize: 12 }
                    text: "15 s\nnormal sustain"
                }
            }

            Item {
                width: itemsCtnr.width / 5
                height: parent.height

                ProgressItem {
                    id: progItem4

                    size: parent.height/4
                    anchors.centerIn: parent
                    bkgdColor: Colors.skinFrameFGD
                }

                TrText {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: progItem4.bottom; anchors.topMargin: 30
                    color: Colors.skinFrameTXT
                    font { family: Fonts.sfyFont; pixelSize: 12 }
                    content: QT_TR_NOOP("indeterminate"); context: _trContext
                }
            }
        }
        Row {
            height: parent.height/3; width: parent.width

            Item {
                property int count1: 0
                property int limit1: 50

                width: parent.width/2; height: parent.height

                ProgressBar {
                    height: parent.height/4; width: parent.width*4/5
                    anchors.centerIn: parent
                    currentValue: parent.count1
                    maxValue: parent.limit1
                }
                Timer {
                    id: progressBarTimer1

                    interval: 125
                    repeat: true
                    onTriggered: {
                        if (++parent.count1 > parent.limit1) {
                            parent.count1 = parent.limit1
                            stop()
                        }
                    }
                    onRunningChanged: {
                        if (running)
                            parent.count1 = 0
                    }
                }
            }
            Item {
                property int count2: 0
                property int limit2: 100

                width: parent.width/2; height: parent.height

                ProgressBar {
                    height: parent.height/4; width: parent.width*4/5
                    anchors.centerIn: parent
                    currentValue: parent.count2
                    maxValue: parent.limit2
                    showValue: true
                }
                Timer {
                    id: progressBarTimer2

                    interval: 125
                    repeat: true
                    onTriggered: {
                        if (++parent.count2 > parent.limit2) {
                            parent.count2 = parent.limit2
                            stop()
                        }
                    }
                    onRunningChanged: {
                        if (running)
                            parent.count2 = 0
                    }
                }
            }
        }
    }

    Row {
        height: parent.height * 1/3
        width: parent.width
        anchors.bottom: parent.bottom

        Item {
            height: parent.height; width: parent.width/3

            Button {
                height: 40; width: parent.width / 2
                text: QT_TR_NOOP("start"); trContext: _trContext
                anchors.centerIn: parent
                onClicked: {
                    progItem0.start(500)
                    progItem1.start(2000)
                    progItem2.start(5000)
                    progItem3.start(15000)
                    progItem4.start()
                    progressBarTimer1.start()
                    progressBarTimer2.start()
                    functionStatus.running = true
                }
            }
        }
        Item {
            height: parent.height; width: parent.width/3

            FunctionStatus {
                id: functionStatus

                height: parent.height/2
                anchors.centerIn: parent
                width: height
                running: false
            }
        }
        Item {
            height: parent.height; width: parent.width/3

            Button {
                height: 40; width: parent.width / 2
                text: QT_TR_NOOP("stop"); trContext: _trContext
                anchors.centerIn: parent
                onClicked: {
                    progItem0.stop()
                    progItem1.stop()
                    progItem2.stop()
                    progItem3.stop()
                    progItem4.stop()
                    progressBarTimer1.stop()
                    progressBarTimer2.stop()
                    functionStatus.running = false
                }
            }
        }
    }
}

