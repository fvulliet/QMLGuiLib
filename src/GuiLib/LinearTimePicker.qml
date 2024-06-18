import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property bool prefer24: true
    property bool isPm: false
    property int maxPickerHeight: height
    property int currentHour
    property alias currentMinute: minutePicker.currentValue
    property bool switch1224: true
    property bool enabled: true

    // private properties
    property real _ratio: 1.5
    property bool _ready: false

    signal newTimeMode(bool pref24)

    // functions

    function setPickerHour() {
        if (!prefer24 && hourPicker.currentValue > 12) {
            hourPicker.currentValue -=12
            isPm = true
        }
        if (prefer24 && isPm && hourPicker.currentValue < 12)
            hourPicker.currentValue +=12

        if (!prefer24 && hourPicker.currentValue === 0)
            hourPicker.currentValue = 12
        if (prefer24 && !isPm && hourPicker.currentValue === 12)
            hourPicker.currentValue = 0
    }

    function setHour(h) {
        currentHour = h

        if (prefer24)
        {
            if (isPm)
            {
                if (h  <= 11)
                    currentHour = h + 12
                else if (h === 12)
                    currentHour = 0
                else
                    currentHour = h
            }
            else
                currentHour = h
        }
        else
        {
            if (isPm)
            {
                if (h >= 12)
                    currentHour = 12
                else
                    currentHour = h + 12
            }
            else
            {
                if (h === 12)
                    currentHour = 0
                else
                    currentHour = h
            }
        }
    }

    // inner components
    Row {
        width: parent.width > _ratio*parent.height ? _ratio*parent.height : parent.width
        height: parent.width > _ratio*parent.height ? parent.height : parent.width/_ratio
        anchors.centerIn: parent

        Item {
            height: parent.height; width: switch1224 ? parent.width*2/9 : 0
            visible: width > 0

            Column {
                height: Math.min(maxPickerHeight, parent.height)
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter

                Item {
                    width: parent.width; height: (parent.height-parent.spacing)/2

                    FontIcon {
                        lib: Fonts.sfyIco; icon: SfyIco.Icon.Clock
                        color: root.enabled ? Colors.skinFrameTXT : Colors.disabled(Colors.skinFrameTXT)
                        size: parent.height/2
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            bottom: parent.bottom
                        }
                        opacity: clockMouseArea.pressed ? 0.2 : 1

                        MouseArea {
                            id: clockMouseArea

                            enabled: root.enabled
                            anchors.fill: parent
                            onClicked: {
                                prefer24 = !prefer24
                                newTimeMode(prefer24)
                                setPickerHour()
                            }
                        }
                    }
                }
                Item {
                    width: parent.width; height: (parent.height-parent.spacing)/2

                    StandardText {
                        color: enabled ? Colors.skinFrameTXT : Colors.disabled(Colors.skinFrameTXT)
                        font.pixelSize:  parent.height/3
                        text: prefer24 ? "24" : "12"
                        verticalAlignment: Text.AlignTop
                    }
                }
            }
        }
        PickerElement {
            id: hourPicker

            height: Math.min(maxPickerHeight, parent.height)
            width: switch1224 ? parent.width*2/9 : parent.width*2/5
            anchors.verticalCenter: parent.verticalCenter
            minValue: prefer24 ? 0 : 1
            maxValue: prefer24 ? 23 : 12
            padding: true
            enabled: root.enabled
            currentValue: currentHour
            onCurrentValueChanged: setHour(currentValue)
        }
        Item {
            height: parent.height
            width: switch1224 ? parent.width/9 : parent.width/5
            anchors.verticalCenter: parent.verticalCenter

            StandardText {
                color: enabled ? Colors.skinFrameTXT : Colors.disabled(Colors.skinFrameTXT)
                font.pixelSize:  parent.height / 4
                text: ":"
            }
        }
        PickerElement {
            id: minutePicker

            height: Math.min(maxPickerHeight, parent.height)
            width: switch1224 ? parent.width*2/9 : parent.width*2/5
            anchors.verticalCenter: parent.verticalCenter
            minValue: 0
            maxValue: 59
            padding: true
            enabled: root.enabled
        }
        Item {
            height: parent.height; width: switch1224 ? parent.width*2/9 : 0
            visible: width > 0

            Item {
                height: Math.min(maxPickerHeight, parent.height)
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter

                StandardText {
                    color: enabled ? Colors.skinFrameTXT : Colors.disabled(Colors.skinFrameTXT)
                    font.pixelSize:  parent.height / 4
                    text: prefer24 ? "" : isPm ? "pm" : "am"
                }

                MouseArea {
                    enabled: root.enabled
                    anchors.fill: parent
                    onClicked: {
                        isPm = !isPm
                        setPickerHour()
                        // changing am/pm has has an impact on hour display
                        setHour(hourPicker.currentValue)
                    }
                }
            }
        }
    }
}
