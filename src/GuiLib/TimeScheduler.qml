import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    property bool multipleTimers: false
    property bool useClock: true
    property int maxRadioBtnHeight
    property bool prefer24: true
    property bool amPm1224BottomLayout: false
    property bool switch1224: true
    property alias mechanicalBehavior: clock.mechanicalBehavior

    property bool _isLandscape: width > height
    property int _pickersCount: 0
    property int _currentPicker: 0
    readonly property int _maxPickers: 3

    property var currentTime: {
        "hour": 8,
        "minute": 0
    }

    signal timeUpdated(date newDate, int index)
    signal newTimeMode(bool pref24)

    function setWidget() {
        pickersCtnr.children[0].hourGui = (currentTime.hour >= 12) ? currentTime.hour - 12 : currentTime.hour
        pickersCtnr.children[0].hour = currentTime.hour
        pickersCtnr.children[0].minute = currentTime.minute
        pickersCtnr.children[0].isPm = currentTime.hour >= 12
        if (useClock)
            pickersCtnr.children[0].initializeGui()
    }

    function addPicker() {
        if (_pickersCount >= _maxPickers)
            return
        if (useClock)
            clockPickerCmp.createObject(pickersCtnr, { "idx": _pickersCount })
        else
            linearPickerCmp.createObject(pickersCtnr, { "idx": _pickersCount })
        _pickersCount++
    }

    function removePicker() {
        pickersCtnr.children[_pickersCount-1].destroy()
        _pickersCount--
    }

    function updateTime(h, m) {
        if (currentTime.length <= 0)
            return
        currentTime.hour = h
        currentTime.minute = m
        var dateTime = new Date() // now, useless anyway (we use time only)
        dateTime.setHours(h)
        dateTime.setMinutes(m)
        root.timeUpdated(dateTime, 0)
    }

    Component.onCompleted: addPicker() // at least 1 timePicker

    Row {
        id: pickersCtnr

        anchors {
            fill: parent; margins: Style.stdMargin/2
        }
        spacing: Style.stdMargin/2
    }

    Item {
        id: removeTimerCtnr

        height: parent.height/8; width: _pickersCount <= 1 ? 0 : height
        visible: width > 0
        anchors.right: addTimerCtnr.left

        FontIcon {
            anchors.centerIn: parent
            color: Colors.skinFrameTXT
            lib: Fonts.faSolid
            icon: FontAwesomeSolid.Icon.MinusSign
            size: parent.height*0.9
        }

        MouseArea {
            anchors.fill: parent
            onClicked: removePicker()
        }
    }

    Item {
        id: addTimerCtnr

        height: parent.height/8; width: multipleTimers ? height : 0
        visible: width > 0
        anchors.right: parent.right

        FontIcon {
            anchors.centerIn: parent
            color: Colors.skinFrameTXT
            lib: Fonts.faSolid
            icon: FontAwesomeSolid.Icon.PlusSign
            size: parent.height*0.9
        }

        MouseArea {
            anchors.fill: parent
            onClicked: addPicker()
        }
    }

    Component {
        id: linearPickerCmp

        Rectangle {
            property int idx: 0
            property int hour
            property int hour24
            property int minute
            property bool isPm: false // dummy

            color: "transparent"
            border {
                width: _pickersCount > 1 ? 1 : 0; color: Colors.skinFrameBGD
            }
            radius: Style.borderRadius
            height: parent.height; width: (pickersCtnr.width-(_pickersCount-1)*pickersCtnr.spacing)/_pickersCount

            LinearTimePicker {
                id: ltPicker

                anchors.fill: parent
                switch1224: root.switch1224
                onCurrentHourChanged: root.updateTime(currentHour, currentMinute)
                onCurrentMinuteChanged: root.updateTime(currentHour, currentMinute)
            }
        }
    }

    Component {
        id: clockPickerCmp

        Rectangle {
            property int idx: 0
            property alias hour24: clock.hour24
            property alias hourGui: clock.hourGui
            property alias minute: clock.minute
            property alias isPm: clock.isPm

            function initializeGui() {
                clock.initializeGui()
            }

            color: "transparent"
            border {
                width: _pickersCount > 1 ? 1 : 0; color: Colors.skinFrameBGD
            }
            radius: Style.borderRadius
            height: parent.height; width: (pickersCtnr.width-(_pickersCount-1)*pickersCtnr.spacing)/_pickersCount

            Clock {
                id: clock

                width: Math.min(parent.width, parent.height); height: width
                anchors.centerIn: parent
                maxRadioBtnHeight: root.maxRadioBtnHeight
                amPm1224BottomLayout: root.amPm1224BottomLayout
                prefer24: root.prefer24
                switch1224: root.switch1224

                onNewTime24: root.updateTime(h, m)
                onNewTimeMode: root.newTimeMode(pref24)
            }
        }
    }
}

