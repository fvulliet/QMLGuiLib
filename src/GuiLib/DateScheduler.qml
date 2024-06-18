import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    property int selectedMonths
    property int selectedWeekDays
    property int selectedMonthDays
    property bool hasMonths: true
    property bool hasWeekDays: true
    property bool hasMonthDays: true
    property int maxItemHeight: 40
    property bool isColumn: false
    property bool multipleDates: true
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

    Component.onCompleted: {
        if (multipleDates) {
            weekDaysModel.append({ "name": qsTr("All"), idx: 7 })
            monthsModel.append({ "name": qsTr("All"), "idx": 12})
            monthDaysModel.append({ "name": qsTr("All"), "idx": 31})
        }
    }

    Item {
        anchors.fill: parent

        Item {
            id: monthsItem

            width: isColumn ? hasMonths && _nbItems > 0 ? parent.width/_nbItems : 0 :parent.width
            height: isColumn ? parent.height : hasMonths && _nbItems > 0 ? parent.height/_nbItems : 0
            visible: isColumn ? width > 0 : height > 0

            ListView {
                anchors {
                    fill: parent; margins: 5
                }
                model: monthsModel
                orientation: isColumn ? ListView.Vertical : ListView.Horizontal
                interactive: false
                delegate: Loader {
                    id: monthsDel

                    sourceComponent: itemDelegate
                    height: isColumn ? ListView.view.height/ListView.view.count : ListView.view.height
                    width: isColumn ? ListView.view.width : ListView.view.width/ListView.view.count

                    onStatusChanged: {
                        if (status === Loader.Ready) {
                            item.name = name
                            item.idx = idx
                        }
                    }

                    Binding {
                        target: item
                        property: "selected"
                        value: multipleDates ? (selectedMonths & (1<<item.idx)) > 0 : selectedMonths === item.idx
                    }

                    Connections {
                        target: item
                        function onClicked(index) {
                            if (multipleDates) {
                                if ((selectedMonths & (1<<index)) > 0) {
                                    if (index === monthsDel.ListView.view.count-1)
                                        selectedMonths = 0
                                    else {
                                        selectedMonths &= ~(1<<index)
                                        selectedMonths &= ~(1<<(monthsDel.ListView.view.count-1))
                                    }
                                } else {
                                    if (index === monthsDel.ListView.view.count-1)
                                        selectedMonths = Math.pow(2, monthsDel.ListView.view.count)-1
                                    else
                                        selectedMonths |= 1<<index
                                }
                            } else {
                                selectedMonths = 1<<index
                            }
                        }
                    }
                }
            }
        }
        Item {
            id: weekDaysItem

            width: isColumn ? hasWeekDays && _nbItems > 0 ? parent.width/_nbItems : 0 : parent.width
            height: isColumn ? parent.height : hasWeekDays && _nbItems > 0 ? parent.height/_nbItems : 0
            visible: isColumn ? width > 0 : height > 0
            anchors {
                top: isColumn ? parent.top : monthsItem.bottom
                left: isColumn ? monthsItem.right : parent.left
            }

            ListView {
                anchors {
                    fill: parent; margins: 5
                }
                model: weekDaysModel
                orientation: isColumn ? ListView.Vertical : ListView.Horizontal
                interactive: false
                delegate: Loader {
                    id: weekDaysDel

                    sourceComponent: itemDelegate
                    height: isColumn ? ListView.view.height/ListView.view.count : ListView.view.height
                    width: isColumn ? ListView.view.width : ListView.view.width/ListView.view.count

                    onStatusChanged: {
                        if (status === Loader.Ready) {
                            item.name = name
                            item.idx = idx
                        }
                    }

                    Binding {
                        target: item
                        property: "selected"
                        value: multipleDates ? (selectedWeekDays & (1<<item.idx)) > 0 : selectedWeekDays === (item.idx+1)
                    }

                    Connections {
                        target: item
                        function onClicked(index) {
                            if (multipleDates) {
                                if ((selectedWeekDays & (1<<index)) > 0) {
                                    // day is already selected
                                    if (index === weekDaysDel.ListView.view.count-1)
                                        // "all days"
                                        selectedWeekDays = 0
                                    else {
                                        // normal day
                                        selectedWeekDays &= ~(1<<index)
                                        selectedWeekDays &= ~(1<<(weekDaysDel.ListView.view.count-1))
                                    }
                                } else {
                                    // day is not already selected
                                    if (index === weekDaysDel.ListView.view.count-1)
                                        // "all days"
                                        selectedWeekDays = Math.pow(2, weekDaysDel.ListView.view.count)-1
                                    else
                                        // normal day
                                        selectedWeekDays |= 1<<index
                                }
                            } else {
                                selectedWeekDays = index+1 // monday is '1'
                            }
                        }
                    }
                }
            }
        }
        Item {
            id: monthDaysItem

            width: isColumn ? hasMonthDays && _nbItems > 0 ? parent.width/_nbItems : 0 : parent.width
            height: isColumn ? parent.height : hasMonthDays && _nbItems > 0 ? parent.height/_nbItems : 0
            visible: isColumn ? width > 0 : height > 0
            anchors {
                top: isColumn ? parent.top : weekDaysItem.bottom
                left: isColumn ? weekDaysItem.right : parent.left
            }

            ListView {
                anchors {
                    fill: parent; margins: 5
                }
                model: monthDaysModel
                orientation: isColumn ? ListView.Vertical : ListView.Horizontal
                interactive: false
                delegate: Loader {
                    id: monthDaysDel

                    sourceComponent: itemDelegate
                    height: isColumn ? ListView.view.height/ListView.view.count : ListView.view.height
                    width: isColumn ? ListView.view.width : ListView.view.width/ListView.view.count

                    onStatusChanged: {
                        if (status === Loader.Ready) {
                            item.name = name
                            item.idx = idx
                        }
                    }

                    Binding {
                        target: item
                        property: "selected"
                        value: multipleDates ? (selectedMonthDays & (1<<item.idx)) > 0 : selectedMonthDays === item.idx
                    }

                    Connections {
                        target: item
                        function onClicked(index) {
                            if (multipleDates) {
                                if ((selectedMonthDays & (1<<index)) > 0) {
                                    if (index === monthDaysDel.ListView.view.count-1)
                                        selectedMonthDays = 0
                                    else {
                                        selectedMonthDays &= ~(1<<index)
                                        selectedMonthDays &= ~(1<<(monthDaysDel.ListView.view.count-1))
                                    }
                                } else {
                                    if (index === monthDaysDel.ListView.view.count-1)
                                        selectedMonthDays = Math.pow(2, monthDaysDel.ListView.view.count)-1
                                    else
                                        selectedMonthDays |= 1<<index
                                }
                            } else {
                                selectedMonthDays = 1<<index
                            }
                        }
                    }
                }
            }
        }
    }

    Component {
        id: itemDelegate

        Item {
            id: theItem

            property bool selected
            property string name
            property int idx

            signal clicked(int index)

            Rectangle {
                width: isColumn ? parent.width/2 : parent.width*0.9
                height: Math.min(maxItemHeight, parent.height*0.9)
                color: selected ? root.enabled ? Colors.themeMainColor : Colors.disabled(Colors.themeMainColor) : "transparent"
                anchors.centerIn: parent
                border {
                    color: root.enabled ? Colors.themeMainColor : Colors.disabled(Colors.themeMainColor); width: 1
                }
                radius: 3

                StandardText {
                    font.pixelSize: Math.min(parent.height/1.5, 18)
                    color: root.enabled ? Colors.skinFrameTXT : Colors.disabled(Colors.skinFrameTXT)
                    text: name
                }

                MouseArea {
                    enabled: root.enabled
                    anchors.fill: parent
                    onClicked: theItem.clicked(idx)
                }
            }
        }
    }

    ListModel {
        id: monthDaysModel

        ListElement { name: qsTr("1"); idx: 0 }
        ListElement { name: qsTr("2"); idx: 1 }
        ListElement { name: qsTr("3"); idx: 2 }
        ListElement { name: qsTr("4"); idx: 3 }
        ListElement { name: qsTr("5"); idx: 4 }
        ListElement { name: qsTr("6"); idx: 5 }
        ListElement { name: qsTr("7"); idx: 6 }
        ListElement { name: qsTr("8"); idx: 7 }
        ListElement { name: qsTr("9"); idx: 8 }
        ListElement { name: qsTr("10"); idx: 9 }
        ListElement { name: qsTr("11"); idx: 10 }
        ListElement { name: qsTr("12"); idx: 11 }
        ListElement { name: qsTr("13"); idx: 12 }
        ListElement { name: qsTr("14"); idx: 13 }
        ListElement { name: qsTr("15"); idx: 14 }
        ListElement { name: qsTr("16"); idx: 15 }
        ListElement { name: qsTr("17"); idx: 16 }
        ListElement { name: qsTr("18"); idx: 17 }
        ListElement { name: qsTr("19"); idx: 18 }
        ListElement { name: qsTr("20"); idx: 19 }
        ListElement { name: qsTr("21"); idx: 20 }
        ListElement { name: qsTr("22"); idx: 21 }
        ListElement { name: qsTr("23"); idx: 22 }
        ListElement { name: qsTr("24"); idx: 23 }
        ListElement { name: qsTr("25"); idx: 24 }
        ListElement { name: qsTr("26"); idx: 25 }
        ListElement { name: qsTr("27"); idx: 26 }
        ListElement { name: qsTr("28"); idx: 27 }
        ListElement { name: qsTr("29"); idx: 28 }
        ListElement { name: qsTr("30"); idx: 29 }
        ListElement { name: qsTr("31"); idx: 30 }
    }

    ListModel {
        id: monthsModel

        ListElement { name: qsTr("Jan"); idx: 0 }
        ListElement { name: qsTr("Feb"); idx: 1 }
        ListElement { name: qsTr("Mar"); idx: 2 }
        ListElement { name: qsTr("Apr"); idx: 3 }
        ListElement { name: qsTr("May"); idx: 4 }
        ListElement { name: qsTr("Jun"); idx: 5 }
        ListElement { name: qsTr("Jul"); idx: 6 }
        ListElement { name: qsTr("Aug"); idx: 7 }
        ListElement { name: qsTr("Sep"); idx: 8 }
        ListElement { name: qsTr("Oct"); idx: 9 }
        ListElement { name: qsTr("Nov"); idx: 10 }
        ListElement { name: qsTr("Dec"); idx: 11 }
    }

    ListModel {
        id: weekDaysModel
        ListElement { name: qsTr("Mon"); idx: 0 }
        ListElement { name: qsTr("Tue"); idx: 1 }
        ListElement { name: qsTr("Wed"); idx: 2 }
        ListElement { name: qsTr("Thu"); idx: 3 }
        ListElement { name: qsTr("Fri"); idx: 4 }
        ListElement { name: qsTr("Sat"); idx: 5 }
        ListElement { name: qsTr("Sun"); idx: 6 }
    }
}
