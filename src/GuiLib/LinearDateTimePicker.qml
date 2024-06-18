import QtQuick 2.9
import GuiLib 1.0

Rectangle {
    id: root

    // public properties
    property bool horizontal: true
    property int spacing: Style.stdMargin
    property int borderWidth: 3
    property alias withYears: datePicker.withYears
    property alias switch1224: timePicker.switch1224
    property int maxPickerHeight: -1 // -1 means no limitation
    property bool enabled: true

    property alias currentHour: timePicker.currentHour
    property alias currentMinute: timePicker.currentMinute
    property alias currentDay: datePicker.currentDay
    property alias currentMonth: datePicker.currentMonth
    property alias currentYear: datePicker.currentYear

    property date currentDateTime: new Date() // now

    // Rectangle's properties
    color: "transparent"
    border {
        color: enabled ? Colors.skinMenuBGD : Colors.disabled(Colors.skinMenuBGD)
        width: borderWidth
    }
    radius: borderWidth

    function updateTime(h, m)  {
        var localDate = new Date(currentDateTime)
        localDate.setHours(h)
        localDate.setMinutes(m)
        currentDateTime = localDate
    }

    Item {
        anchors {
            fill: parent; margins: Style.borderMargin
        }

        LinearDatePicker {
            id: datePicker

            width: horizontal ? (parent.width - spacing)/2 : parent.width
            height: horizontal ? parent.height : (parent.height - spacing)/2
            maxPickerHeight: root.maxPickerHeight > 0 ? root.maxPickerHeight : height
            enabled: root.enabled
            onCurrentDayChanged: {
                var localDate = new Date(currentDateTime)
                localDate.setDate(currentDay)
                currentDateTime = localDate
            }
            onCurrentMonthChanged: {
                var localDate = new Date(currentDateTime)
                localDate.setMonth(currentMonth)
                currentDateTime = localDate
            }
            onCurrentYearChanged: {
                var localDate = new Date(currentDateTime)
                localDate.setYear(currentYear)
                currentDateTime = localDate
            }
        }

        LinearTimePicker {
            id: timePicker

            width: horizontal ? (parent.width - spacing)/2 : parent.width
            height: horizontal ? parent.height : (parent.height - spacing)/2
            anchors {
                left: horizontal ? datePicker.right : parent.left
                leftMargin: horizontal ? root.spacing : 0
                top: horizontal ? parent.top : datePicker.bottom
                topMargin: horizontal ? 0 : root.spacing
            }
            enabled: root.enabled
            maxPickerHeight: root.maxPickerHeight > 0 ? root.maxPickerHeight : height
            onCurrentHourChanged: updateTime(currentHour, currentMinute)
            onCurrentMinuteChanged: updateTime(currentHour, currentMinute)
        }
    }
}
