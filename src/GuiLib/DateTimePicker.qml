import QtQuick 2.9
import GuiLib 1.0 as Gui

Rectangle {
    id: root

    // public properties
    property int maxRadioBtnHeight: 40
    property date currentDateTime: new Date() // now
    property int borderWidth: 3
    property bool hasCronScheduler: false
    property bool isPeriod: false
    property bool withYears: true
    property bool switch1224: true
    property bool mechanicalBehavior

    property int currentHour: 0
    property int currentMinute: 0
    readonly property int _fullRange: 24*60

    // Rectangle's properties
    color: "transparent"
    border {
        color: Gui.Colors.skinMenuBGD
        width: borderWidth
    }
    radius: borderWidth

    // inner components
    Column {
        anchors {
            fill: parent; margins: borderWidth
        }

        Gui.Tabs {
            id: tabsList

            width: parent.width; height: root.height/10
            maxIconSize: height*3/4
            model: ListModel {
                Component.onCompleted: {
                    append({ name: QT_TR_NOOP("date"), trContext: "DateTimePicker",
                               isVisible: true, hasText: false, hasIcon: true,
                               iconLib: Gui.Fonts.sfyIco, iconId: Gui.SfyIco.Icon.Calendar })
                    append({ name: QT_TR_NOOP("time"), trContext: "DateTimePicker",
                               isVisible: true, hasText: false, hasIcon: true,
                               iconLib: Gui.Fonts.sfyIco, iconId: Gui.SfyIco.Icon.Clock })
                }
            }
            onCurrentIndexChanged: {
                switch (currentIndex) {
                case 1:
                    if (isPeriod)
                        loader.sourceComponent = periodComp
                    else
                        loader.sourceComponent = clockComp
                    break
                default:
                    if (hasCronScheduler)
                        loader.sourceComponent = dateSchedulerComp
                    else
                        loader.sourceComponent = calendarComp
                    break
                }
            }
        }
        Loader {
            id: loader

            height: parent.height - tabsList.height
            width: parent.width
            sourceComponent: {
                if (hasCronScheduler)
                    loader.sourceComponent = dateSchedulerComp
                else
                    loader.sourceComponent = calendarComp
            }
        }
    }

    Component {
        id: calendarComp

        Gui.Calendar {
            id: calendar

            withYears: root.withYears

            Component.onCompleted: {
                currentDate = currentDateTime
                currentHour = currentDate.getHours()
                currentMinute = currentDate.getMinutes()
                selectedDay = currentDate.getUTCDate()
                currentMonth = currentDate.getUTCMonth()
                currentYear = currentDate.getUTCFullYear()
            }

            onDateChanged: {
                var localDate = new Date(currentDateTime)
                localDate.setDate(newDate.getDate())
                localDate.setMonth(newDate.getMonth())
                localDate.setYear(newDate.getFullYear())
                currentDateTime = localDate
            }
        }
    }

    Component {
        id: periodComp

        TimeRangeScheduler {
            mechanicalBehavior: true
        }
    }

    Component {
        id: dateSchedulerComp

        DateScheduler {
        }
    }

    Component {
        id: clockComp

        Gui.Clock {
            id: clock

            maxRadioBtnHeight: root.maxRadioBtnHeight
            hourGui: (currentHour >= 12) ? currentHour - 12 : currentHour
            hour24: currentHour
            minute: _currentMinute
            isPm: (currentHour >= 12) ? true : false
            amPm1224BottomLayout: false
            switch1224: root.switch1224
            mechanicalBehavior: root.mechanicalBehavior

            onNewTime24: {
                var localDate = new Date(currentDateTime)
                localDate.setHours(h)
                localDate.setMinutes(m)
                currentDateTime = localDate
            }
        }
    }
}
