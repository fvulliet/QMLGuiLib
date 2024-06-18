import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    property int maxPickerHeight: height
    property bool withYears: true
    property alias currentDay: dayPicker.currentValue
    property alias currentMonth: monthPicker.currentValue
    property alias currentYear: yearPicker.currentValue
    property bool enabled: true

    // private properties
    property int _ratio: 2

    QtObject {
        id: months
        readonly property int jan: 0
        readonly property int feb: 1
        readonly property int mar: 2
        readonly property int apr: 3
        readonly property int may: 4
        readonly property int jun: 5
        readonly property int jul: 6
        readonly property int aug: 7
        readonly property int sep: 8
        readonly property int oct: 9
        readonly property int nov: 10
        readonly property int dec: 11
    }

    // inner components
    Row {
        width: parent.width > _ratio*parent.height ? _ratio*parent.height : parent.width
        height: parent.width > _ratio*parent.height ? parent.height : parent.width/_ratio
        anchors.centerIn: parent

        PickerElement {
            id: dayPicker

            height: Math.min(maxPickerHeight, parent.height)
            width: withYears ? parent.width/6 : 2*parent.width/6
            anchors.verticalCenter: parent.verticalCenter
            currentValue: 1
            minValue: 1
            maxValue: 31
            enabled: root.enabled
        }
        PickerElement {
            id: monthPicker

            height: Math.min(maxPickerHeight, parent.height)
            width: withYears ? 3*parent.width/6 : 4*parent.width/6
            anchors.verticalCenter: parent.verticalCenter
            currentValue: months.jan
            minValue: months.jan
            maxValue: months.dec
            enabled: root.enabled
            values: [
                qsTr("january"), qsTr("february"), qsTr("march"),
                qsTr("april"), qsTr("may"), qsTr("june"),
                qsTr("july"), qsTr("august"), qsTr("september"),
                qsTr("october"), qsTr("november"), qsTr("december")
            ]
            onCurrentValueChanged: {
                switch (currentValue) {
                case months.feb:
                    dayPicker.maxValue = 29
                    break
                case months.apr:
                case months.jun:
                case months.sept:
                case months.nov:
                    dayPicker.maxValue = 30
                    break
                default:
                    dayPicker.maxValue = 31
                }
                if (dayPicker.currentValue > dayPicker.maxValue)
                    dayPicker.currentValue = dayPicker.maxValue
            }
        }
        PickerElement {
            id: yearPicker

            height: Math.min(maxPickerHeight, parent.height)
            width: withYears ? 2*parent.width/6 : 0
            visible: width > 0
            anchors.verticalCenter: parent.verticalCenter
            currentValue: 2019
            minValue: 2000
            maxValue: 2099
            enabled: root.enabled
        }
    }
}
