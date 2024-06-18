import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    property int ratio: 2
    property alias selectedMonths: dateScheduler.selectedMonths
    property alias selectedWeekDays: dateScheduler.selectedWeekDays
    property alias selectedMonthDays: dateScheduler.selectedMonthDays
    property alias hasMonths: dateScheduler.hasMonths
    property alias hasWeekDays: dateScheduler.hasWeekDays
    property alias hasMonthDays: dateScheduler.hasMonthDays
    property bool isColumn: true
    property bool isPeriod: false
    property alias startHour: timeRangeScheduler.startHour
    property alias startMinute: timeRangeScheduler.startMinute
    property alias endHour: timeRangeScheduler.endHour
    property alias endMinute: timeRangeScheduler.endMinute
    property alias maxRadioBtnHeight: timeRangeScheduler.maxRadioBtnHeight
    property alias useClock: timeRangeScheduler.useClock
    property alias prefer24: timeRangeScheduler.prefer24
    property alias amPm1224BottomLayout: timeRangeScheduler.amPm1224BottomLayout
    property alias switch1224: timeRangeScheduler.switch1224
    property alias multipleDates: dateScheduler.multipleDates
    property bool enabled: true

    readonly property int _fullRange: 24*60
    property int _nbItems: {
        var ret = 0
        if (hasMonths)
            ret++
        if (hasWeekDays)
            ret++
        if (hasMonthDays)
            ret++
        return ret
    }

    signal newTimeMode(bool pref24)
    signal newStartHour(int value)
    signal newStartMinute(int value)
    signal newEndHour(int value)
    signal newEndMinute(int value)

    function updateGui() {
        if (useClock)
            timeRangeScheduler.updateDisplay()
    }

    Rectangle {
        id: mainFrame

        anchors.fill: parent
        color: "transparent"
        border {
            color: root.enabled ? Colors.skinFrameTXT : Colors.disabled(Colors.skinFrameTXT)
            width: 1
        }

        Item { // if 'isColumn===true' => Row
            id: timeCtnr

            width: isColumn ? parent.width : (parent.width-separator.width)/Style.goldenNumber
            height: isColumn ? (parent.height-separator.height)/Style.goldenNumber : parent.height

            Rectangle {
                id: timeTitle

                height: isColumn ? parent.height : parent.height/12
                width: isColumn ? parent.width/12 : parent.width
                color: mainFrame.border.color

                FontIcon {
                    lib: Fonts.sfyIco; icon: SfyIco.Icon.Clock
                    color: Colors.skinFrameBGD
                    size: Math.min(parent.width*0.8, parent.height*0.8)
                    anchors.centerIn: parent
                }
            }

            TimeRangeScheduler {
                id: timeRangeScheduler

                height: isColumn ? parent.height : parent.height - timeTitle.height
                width: isColumn ? parent.width - timeTitle.width : parent.width
                anchors {
                    top: isColumn ? parent.top : timeTitle.bottom
                    left: isColumn ? timeTitle.right : parent.left
                }
                multipleTimers: isPeriod
                enabled: root.enabled
                mechanicalBehavior: true

                onNewStartHour: root.newStartHour(value)
                onNewStartMinute: root.newStartMinute(value)
                onNewEndHour: root.newEndHour(value)
                onNewEndMinute: root.newEndMinute(value)
                onNewTimeMode: root.newTimeMode(pref24)
            }
        }

        Rectangle {
            id: separator

            width: isColumn ? parent.width : 1; height: isColumn ? 1 : parent.height
            color: root.enabled ? Colors.skinFrameTXT : Colors.disabled(Colors.skinFrameTXT)
            anchors {
                top: isColumn ? timeCtnr.bottom : parent.top
                left: isColumn ? parent.left : timeCtnr.right
            }
        }

        Item { // if 'isColumn===true' => Row
            id: dateCtnr

            width: isColumn ? parent.width : (parent.width-separator.width)*(1-1/Style.goldenNumber)
            height: isColumn ? (parent.height-separator.height)*(1-1/Style.goldenNumber) : parent.height
            anchors {
                top: isColumn ? separator.bottom : parent.top
                left: isColumn ? parent.left : separator.right
            }

            Rectangle {
                id: calendarTitle

                height: isColumn ? parent.height : parent.height/12
                width: isColumn ? parent.width/12 : parent.width
                color: mainFrame.border.color

                FontIcon {
                    lib: Fonts.sfyIco; icon: SfyIco.Icon.Calendar
                    color: Colors.skinFrameBGD
                    size: Math.min(parent.width*0.8, parent.height*0.8)
                    anchors.centerIn: parent
                }
            }

            DateScheduler {
                id: dateScheduler

                width: root.isColumn ? parent.width - calendarTitle.width : parent.width
                height: root.isColumn ? parent.height : parent.height - calendarTitle.height
                isColumn: !root.isColumn
                anchors {
                    top: root.isColumn ? parent.top : calendarTitle.bottom
                    left: root.isColumn ? calendarTitle.right : parent.left
                }
                enabled: root.enabled
            }
        }
    }
}

