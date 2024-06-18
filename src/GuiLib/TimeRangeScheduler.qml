import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    property bool toggleAllowed: false
    property int startHour
    property int startMinute
    property int endHour
    property int endMinute
    property bool useClock: true
    property bool prefer24: true
    property bool amPm1224BottomLayout: false
    property bool switch1224: true
    property bool multipleTimers: true
    property int maxRadioBtnHeight
    property bool enabled: true
    property bool mechanicalBehavior

    property bool _isLandscape: width > height

    signal newTimeMode(bool pref24)
    signal newStartHour(int value)
    signal newStartMinute(int value)
    signal newEndHour(int value)
    signal newEndMinute(int value)

    function updateDisplay() {
        rangeStartClock.initializeGui()
        rangeEndClock.initializeGui()
    }

    Column {
        anchors {
            fill: parent; margins: Style.stdMargin/2
        }

        Item {
            width: parent.width; height: multipleTimers ? parent.height*3/4 : parent.height

            Rectangle {
                id: start

                width: _isLandscape ? multipleTimers ? (parent.width-spacing.width)/2 : parent.width : parent.width
                height: _isLandscape ? parent.height : multipleTimers ? (parent.height-spacing.height)/2 : parent.height
                color: "transparent"
                border {
                    width: multipleTimers ? 1 : 0; color: Colors.skinFrameBGD
                }
                radius: Style.borderRadius

                Column {
                    anchors.fill: parent

                    Item {
                        id: rangeStartHeader

                        height: multipleTimers ? parent.height/4 : 0
                        width: parent.width
                        visible: height > 0

                        StandardText {
                            font.pixelSize: Math.min(20, parent.height/2)
                            text: "start"
                        }
                    }
                    Item {
                        id: rangeStartCtnr

                        height: multipleTimers ? parent.height*3/4 : parent.height
                        width: parent.width

                        Clock {
                            id: rangeStartClock

                            height: multipleTimers ? parent.height * 0.9 : parent.height
                            width: useClock ? parent.width : 0
                            visible: width > 0
                            anchors.centerIn: parent
                            prefer24: root.prefer24
                            amPm1224BottomLayout: root.amPm1224BottomLayout
                            switch1224: root.switch1224
                            maxRadioBtnHeight: root.maxRadioBtnHeight
                            hour24: startHour
                            hourGui: (startHour >= 12) ? startHour - 12 : startHour
                            minute: startMinute
                            enabled: root.enabled
                            mechanicalBehavior: root.mechanicalBehavior

                            onNewTimeMode: root.newTimeMode(pref24)
                            onNewTime24: {
                                newStartHour(h)
                                newStartMinute(m)
                            }
                        }

                        LinearTimePicker {
                            id: rangeStartPicker

                            height: parent.height; width: useClock ? 0 : parent.width
                            visible: width > 0
                            anchors.centerIn: parent
                            switch1224: root.switch1224
                            currentHour: startHour
                            currentMinute: startMinute
                            enabled: root.enabled

                            onCurrentHourChanged: newStartHour(currentHour)
                            onCurrentMinuteChanged: newStartMinute(currentMinute)
                            onNewTimeMode: root.newTimeMode(pref24)
                        }
                    }
                }
            }

            Item {
                id: spacing

                width: _isLandscape ? multipleTimers ? 2*Style.stdMargin : 0 : parent.width
                height: _isLandscape ? parent.height : multipleTimers ? 2*Style.stdMargin : 0
                visible: _isLandscape ? width > 0 : height > 0
                anchors {
                    top: _isLandscape ? parent.top : start.bottom
                    left: _isLandscape ? start.right : parent.left
                }

                FontIcon {
                    id: arrow

                    size: _isLandscape ? parent.width*0.9 : parent.height*0.9
                    anchors.centerIn: parent
                    lib: Fonts.faSolid
                    icon: _isLandscape ? FontAwesomeSolid.Icon.ArrowRight : FontAwesomeSolid.Icon.ArrowDown
                    color: root.enabled ? Colors.skinFrameTXT : Colors.disabled(Colors.skinFrameTXT)
                }
            }

            Rectangle {
                id: end

                width: _isLandscape ? multipleTimers ? (parent.width-spacing.width)/2 : 0 : parent.width
                height: _isLandscape ? parent.height : multipleTimers ? (parent.height-spacing.height)/2 : 0
                visible: _isLandscape ? width > 0 : height > 0
                anchors {
                    top: _isLandscape ? parent.top : spacing.bottom
                    left: _isLandscape ? spacing.right : parent.left
                }
                color: "transparent"
                border {
                    width: multipleTimers ? 1 : 0; color: Colors.skinFrameBGD
                }
                radius: Style.borderRadius

                Column {
                    anchors.fill: parent

                    Item {
                        id: rangeEndHeader

                        height: multipleTimers ? parent.height/4 : 0
                        width: parent.width
                        visible: height > 0

                        StandardText {
                            font.pixelSize: Math.min(20, parent.height/2)
                            text: "end"
                        }
                    }
                    Item {
                        id: rangeEndCtnr

                        height: multipleTimers ? parent.height*3/4 : parent.height
                        width: parent.width

                        Clock {
                            id: rangeEndClock

                            height: multipleTimers ? parent.height * 0.9 : parent.height
                            width: useClock ? parent.width : 0
                            visible: width > 0
                            anchors.centerIn: parent
                            prefer24: root.prefer24
                            amPm1224BottomLayout: root.amPm1224BottomLayout
                            switch1224: root.switch1224
                            maxRadioBtnHeight: root.maxRadioBtnHeight
                            hour24: endHour
                            hourGui: (endHour >= 12) ? endHour - 12 : endHour
                            minute: endMinute
                            enabled: root.enabled
                            mechanicalBehavior: root.mechanicalBehavior

                            onNewTimeMode: root.newTimeMode(pref24)
                            onNewTime24: {
                                newEndHour(h)
                                newEndMinute(m)
                            }
                        }

                        LinearTimePicker {
                            id: rangeEndPicker

                            height: parent.height; width: useClock ? 0 : parent.width
                            visible: width > 0
                            anchors.centerIn: parent
                            switch1224: root.switch1224
                            currentHour: endHour
                            currentMinute: endMinute
                            enabled: root.enabled

                            onCurrentHourChanged: newEndHour(currentHour)
                            onCurrentMinuteChanged: newEndMinute(currentMinute)
                            onNewTimeMode: root.newTimeMode(pref24)
                        }
                    }
                }
            }
        }
        Item {
            id: periodCtnr

            width: parent.width; height: multipleTimers ? (parent.height-parent.spacing)/4 : 0
            visible: height > 0

            Item {
                width: parent.width; height: parent.height/2
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    id: range

                    property int rangeStart: useClock ? rangeStartClock.hour24*60 + rangeStartClock.minute
                                                      : rangeStartPicker.currentHour*60 + rangeStartPicker.currentMinute
                    property int rangeEnd: useClock ? rangeEndClock.hour24*60 + rangeEndClock.minute
                                                    : rangeEndPicker.currentHour*60 + rangeEndPicker.currentMinute

                    height: parent.height
                    width: parent.width * (rangeEnd - rangeStart)/_fullRange
                    x: parent.width * rangeStart/_fullRange
                    anchors.bottom: parent.bottom
                    color: root.enabled ? Colors.themeMainColor : Colors.disabled(Colors.themeMainColor)
                }

                ListView {
                    id: hours

                    width: parent.width; height: parent.height
                    model: 24
                    orientation: ListView.Horizontal
                    interactive: false
                    delegate: Item {
                        width: hours.width/24; height: ListView.view.height

                        Item {
                            width: parent.width; height: parent.height*0.9
                            anchors.bottom: parent.bottom

                            StandardText {
                                font.pixelSize: Math.min(parent.height/3, 10)
                                color: root.enabled ? Colors.skinFrameTXT : Colors.disabled(Colors.skinFrameTXT)
                                text: modelData
                            }
                        }

                        Rectangle {
                            height: parent.height; width: 1
                            color: Colors.skinFrameFGD
                        }
                    }
                }
            }
        }
    }
}

