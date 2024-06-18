import QtQuick
import GuiLib 1.0

Item {
    id: root

    // public properties
    property bool enabled: true
    property int hourGui: 6
    property int hour24: 6
    property int minute: 0
    property color bkgd: Colors.skinFrameFGD
    property alias clockTime: hourMinute.text
    property int maxRadioBtnHeight: 40
    property bool prefer24: true
    property bool isPm: true
    property bool amPm1224BottomLayout: true
    property bool mechanicalBehavior: false
    property bool switch1224: true

    // private properties
    readonly property real _toDeg: 180/Math.PI
    readonly property real _toRad: Math.PI/180
    readonly property int _marksBorder: 2
    property real _hourAngle
    property real _minuteAngle
    property bool _txtInputDisplayed: false

    // signals
    signal newTime24(int h, int m)
    signal newTimeMode(bool pref24)

    // functions
    function initializeGui() {
        if (hour24 < 12)
            isPm = false
        else
            isPm = true
        _hourAngle = hourGui*30
        _minuteAngle = minute*6
    }

    function _setTimeFromGui(h, m) {
        if (prefer24)
        {
            if (isPm)
            {
                if (h <= 11)
                    hour24 = h + 12
                else if (h === 12)
                {
                    hour = 0
                    hour24 = 0
                }
                else
                    hour24 = h
            }
            else
                hour24 = h
        }
        else
        {
            if (isPm)
            {
                if (h >= 12)
                {   // keep 12 pm on clock
                    hourGui = 12
                    hour24 = 12
                }
                else
                    hour24 = h + 12
            }
            else
            {
                if (h === 12)
                    hour24 = 0
                else
                    hour24 = h
            }
        }

        newTime24(hour24, m)
    }

    function _pad(number) {
        return (number < 10 ? '0' : '') + number
    }

    function toggleAmPm()
    {
        isPm = !isPm
        _setTimeFromGui(hourGui, minute)
    }

    function _toggle2412() {
        prefer24 = !prefer24
        _manageMidday()
        newTimeMode(prefer24)
    }

    function _manageMidday() {
        if (!prefer24 && hourGui === 0)
            hourGui = 12
        if (prefer24 && !isPm && hourGui === 12)
            hourGui = 0
        _setTimeFromGui(hourGui, minute)
    }

    function _updateFromText() {
        var h = txtInput.text.split(':')[0]
        var m = txtInput.text.split(':')[1]

        hourGui = parseInt(h) % 12
        minute = parseInt(m)

        if (prefer24 && parseInt(h) < 12) {
            isPm = false
        } else if (parseInt(h) > 12) {
            prefer24 = true
            _manageMidday()
            newTimeMode(prefer24)

            isPm = true
        }

        _setTimeFromGui(hourGui, minute)
        initializeGui()
    }

    function _formattedHour(h, m) {
        var formatted = h
        if ((isPm && prefer24 && (h < 12)) ||
                (!prefer24 && h === 0))
            formatted = h + 12
        return _pad(formatted) + ":" + _pad(m)
    }

    // Item's properties
    states: State {
        when: _txtInputDisplayed
        PropertyChanges {
            target: manualInput
            opacity: 0.9
        }
    }
    transitions: Transition {
        NumberAnimation {
            property: "opacity"
        }
    }

    Component.onCompleted: initializeGui()

    // inner components
    Rectangle {
        id: ringCtnr

        property real stroke: Utils.bound(Math.min(parent.width, parent.height)/12, 5, 40)

        width: Math.min(parent.width, parent.height) - 2*0.25*stroke - 2*_marksBorder
        height: width
        radius: width > 0 ? width/2 : 0
        anchors.centerIn: parent
        border {
            color: root.enabled ? Colors.themeMainColor : Colors.disabled(Colors.themeMainColor)
            width: stroke
        }
        color: "transparent"

        MouseArea {
            anchors.fill: parent
            onClicked: _txtInputDisplayed = false
        }

        PathView {
            id: hoursPathView

            anchors.fill: parent
            model: 12

            delegate: Rectangle {
                id: del

                property bool isCardinal: modelData%3 === 0

                height: ringCtnr.stroke * (isCardinal ? 1.5 : 1)
                width: height
                radius: width/2
                color: ringCtnr.border.color
                border {
                    color: bkgd
                    width: isCardinal ? _marksBorder : 0
                }

                Item {
                    width: 2 * Math.sqrt(Math.pow((parent.radius - parent.border.width),2)/2)
                    height: width
                    anchors.centerIn: parent

                    StandardText {
                        text: {
                            if (modelData === 0)
                                return 12
                            return modelData
                        }
                        color: root.enabled ? Colors.skinFrameTXT : Colors.disabled(Colors.skinFrameTXT)
                        font {
                            family: Fonts.sfyFont
                            bold: del.isCardinal
                            pixelSize: del.isCardinal ? parent.height/1.5 : parent.height/2
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        hourGui = modelData
                        minute = 0
                        _manageMidday()
                        initializeGui()
                    }
                }
            }

            interactive: false

            path: Path {
                startX: hoursPathView.width / 2
                startY: hoursPathView.y + ringCtnr.stroke/2

                PathArc {
                    x: hoursPathView.width / 2
                    y: hoursPathView.height - ringCtnr.stroke/2
                    radiusX: hoursPathView.width / 2 - ringCtnr.stroke/2
                    radiusY: hoursPathView.width / 2 - ringCtnr.stroke/2
                    useLargeArc: false
                }

                PathArc {
                    x: hoursPathView.width / 2
                    y: hoursPathView.y + ringCtnr.stroke/2
                    radiusX: hoursPathView.width / 2 - ringCtnr.stroke/2
                    radiusY: hoursPathView.width / 2 - ringCtnr.stroke/2
                    useLargeArc: false
                }
            }
        }

        Rectangle {
            id: hourCursor

            height: ringCtnr.stroke/1.6
            width: ringCtnr.radius - 2.25*ringCtnr.stroke + _marksBorder
            radius: width/2
            anchors.verticalCenter: parent.verticalCenter
            x: ringCtnr.radius
            color: root.enabled ? Colors.skinFrameTXT : Colors.disabled(Colors.skinFrameTXT)
            transformOrigin: Item.Left
            rotation: _hourAngle - 90
        }

        Rectangle {
            id: minuteCursor

            height: ringCtnr.stroke/2.4
            width: ringCtnr.radius - 1.25*ringCtnr.stroke + _marksBorder
            radius: width/2
            anchors.verticalCenter: parent.verticalCenter
            x: ringCtnr.radius
            color: root.enabled ? Colors.skinFrameTXT : Colors.disabled(Colors.skinFrameTXT)
            transformOrigin: Item.Left
            rotation: _minuteAngle - 90
        }

        Rectangle {
            id: hourMark

            width: parent.stroke; height: width; radius: width/2
            x: ringCtnr.radius + (hourCursor.width - 1.5*radius) * Math.sin(_hourAngle * _toRad) - radius
            y: ringCtnr.radius + (hourCursor.width - 1.5*radius) * -Math.cos(_hourAngle * _toRad) - radius
            color: "white"
            border {
                color: hourCursor.color
                width: 2
            }

            MouseArea {
                enabled: root.enabled
                anchors.centerIn: parent
                cursorShape: Qt.PointingHandCursor
                width: parent.width; height: parent.height

                onPositionChanged: {
                    if (enabled && pressed) {
                        var currentX = hourMark.x + mouse.x - ringCtnr.width/2
                        var currentY = hourMark.y + mouse.y - ringCtnr.height/2
                        var a = Qt.vector2d(Math.round(Math.tan(_toRad)), -1).normalized()
                        var b = Qt.vector2d(currentX, currentY).normalized()

                        _hourAngle = (360+(Math.atan2(b.y, b.x) - Math.atan2(a.y, a.x))*_toDeg)%360
                        hourGui = _hourAngle*12/360
                        if (mechanicalBehavior) {
                            _minuteAngle = (_hourAngle*12/360 - hourGui) *360
                            minute = _minuteAngle/6
                        }
                        _manageMidday()
                    }
                }
                onReleased: {
                    if (!mechanicalBehavior)
                        _hourAngle = Math.floor(_hourAngle/30) * 30 + 15
                    _setTimeFromGui(hourGui, minute)
                }
            }
        }

        Rectangle {
            id: minuteMark

            width: parent.stroke; height: width; radius: width/2
            x: ringCtnr.radius + (minuteCursor.width - 1.5*radius) * Math.sin(_minuteAngle * _toRad) - radius
            y: ringCtnr.radius + (minuteCursor.width - 1.5*radius) * -Math.cos(_minuteAngle * _toRad) - radius
            color: "white"
            border {
                color: minuteCursor.color
                width: 2
            }

            MouseArea {
                enabled: root.enabled
                anchors.centerIn: parent
                cursorShape: Qt.PointingHandCursor
                width: parent.width; height: parent.height

                onPositionChanged: {
                    if (enabled && pressed) {
                        var currentX = minuteMark.x + mouse.x - ringCtnr.width/2
                        var currentY = minuteMark.y + mouse.y - ringCtnr.height/2
                        var a = Qt.vector2d(Math.tan(_toRad), -1).normalized()
                        var b = Qt.vector2d(currentX, currentY).normalized()

                        _minuteAngle = (360+(Math.atan2(b.y, b.x) - Math.atan2(a.y, a.x)) * _toDeg) % 360
                        minute = _minuteAngle/6
                        if (mechanicalBehavior)
                            _hourAngle = Math.floor(_hourAngle/30) * 30 + 30*(_minuteAngle/360)
                        _setTimeFromGui(hourGui, minute)
                    }
                }
                onReleased: _setTimeFromGui(hourGui, minute)
            }
        }

        Rectangle {
            id: center

            height: ringCtnr.radius/1.5; width: height
            radius: width/2
            anchors.centerIn: parent
            color: bkgd
            border {
                color: minuteCursor.color
                width: 2
            }

            Item {
                id: quadrature

                width: parent.width
                height: width
                anchors.centerIn: parent

                StandardText {
                    id: hourMinute

                    anchors.margins: 5
                    font.pixelSize: 0.66*parent.height
                    text: _formattedHour(hourGui, minute)
                }
            }

            MouseArea {
                enabled: root.enabled
                anchors.fill: parent
                onClicked: {
                    _txtInputDisplayed = true
                }
            }
        }

        Rectangle {
            id: manualInput

            width: 2 * Math.sqrt(Math.pow((ringCtnr.radius-ringCtnr.stroke),2)/2)
            height: width
            anchors.centerIn: ringCtnr
            color: bkgd
            border {
                color: center.border.color
                width: center.border.width
            }
            visible: opacity > 0
            opacity: 0

            Item {
                width: parent.width; height: width/2
                anchors.verticalCenter: parent.verticalCenter

                TextInput {
                    id: txtInput

                    anchors.fill: parent
                    horizontalAlignment: TextInput.AlignHCenter
                    verticalAlignment: TextInput.AlignVCenter
                    color: Colors.skinFrameTXT
                    selectionColor: color
                    selectedTextColor: Colors.skinFrameFGD
                    selectByMouse: true
                    font {
                        pixelSize: height*2/3
                        family: Fonts.sfyFont
                    }
                    validator: RegularExpressionValidator {
                        regularExpression: prefer24 ? /^(.{0}|([0-9]|0[1-9]|1[0-9]|2[0-3])):[0-5][0-9]$/ :
                                           /^(.{0}|([0-9]|0[1-9]|1[0-2])):[0-5][0-9]$/
                    }
                    text: _formattedHour(hourGui, minute)
                    onAccepted: {
                        if (text.startsWith(':'))
                            text = "00" + text
                        _txtInputDisplayed = false
                        _updateFromText()
                    }
                }
            }
        }

        Column {
            height: ringCtnr.radius*(1 - Math.sin(45*_toRad)); width: height
            anchors.bottom: parent.bottom
            visible: amPm1224BottomLayout

            Item {
                width: parent.width; height: parent.height/2

                RadioButton {
                    id: amRadioBtn

                    width: parent.width; height: Math.min(0.8*parent.height, maxRadioBtnHeight)
                    text: "AM"
                    gap: height/2
                    reversed: true
                    anchors.bottom: parent.bottom
                    checked: !isPm
                    enabled: root.enabled
                    onClicked: toggleAmPm()
                }
            }

            Item {
                width: parent.width; height: parent.height/2

                RadioButton {
                    id: pmRadioBtn

                    width: parent.width; height: Math.min(0.8*parent.height, maxRadioBtnHeight)
                    text: "PM"
                    anchors.bottom: parent.bottom
                    gap: height/2
                    reversed: true
                    checked: isPm
                    enabled: root.enabled
                    onClicked: toggleAmPm()
                }
            }
        }

        Column {
            height: ringCtnr.radius*(1 - Math.sin(45*_toRad)); width: height
            anchors {
                bottom: parent.bottom
                right: parent.right
            }
            visible: switch1224 && amPm1224BottomLayout

            Item {
                width: parent.width; height: parent.height/2

                RadioButton {
                    id: timeMode12Btn

                    width: parent.width; height: Math.min(0.8*parent.height, maxRadioBtnHeight)
                    text: "12"
                    gap: height/2
                    anchors.bottom: parent.bottom
                    checked: !prefer24
                    enabled: root.enabled
                    onClicked: _toggle2412()
                }
            }

            Item {
                width: parent.width; height: parent.height/2

                RadioButton {
                    id: timeMode24Btn

                    width: parent.width; height: Math.min(0.8*parent.height, maxRadioBtnHeight)
                    text: "24"
                    anchors.bottom: parent.bottom
                    gap: height/2
                    checked: prefer24
                    enabled: root.enabled
                    onClicked: _toggle2412()
                }
            }
        }

        Item {
            visible: !amPm1224BottomLayout
            width: parent.width/2  * (1 - Math.cos(Math.PI/4)); height: width

            Text {
                anchors.fill: parent
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignLeft
                font {
                    family: Fonts.sfyFont
                    pixelSize: parent.height
                    underline: !isPm
                }
                color: !isPm ? root.enabled ? Colors.themeMainColor : Colors.disabled(Colors.themeMainColor) : Colors.skinFrameTXT
                fontSizeMode: Text.Fit
                minimumPixelSize: 3
                text: "am"

                MouseArea {
                    enabled: root.enabled
                    anchors.fill: parent
                    onClicked: toggleAmPm()
                }
            }
        }

        Item {
            visible: !amPm1224BottomLayout
            width: parent.width/2  * (1 - Math.cos(Math.PI/4)); height: width
            anchors.right: parent.right

            Text {
                anchors.fill: parent
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignRight
                font {
                    family: Fonts.sfyFont
                    pixelSize: parent.height
                    underline: isPm
                }
                color: isPm ? root.enabled ? Colors.themeMainColor : Colors.disabled(Colors.themeMainColor) : Colors.skinFrameTXT
                fontSizeMode: Text.Fit
                minimumPixelSize: 3
                text: "pm"
            }

            MouseArea {
                enabled: root.enabled
                anchors.fill: parent
                onClicked: toggleAmPm()
            }
        }

        Item {
            visible: !amPm1224BottomLayout && switch1224
            width: parent.width/2  * (1 - Math.cos(Math.PI/4)); height: width
            anchors.bottom: parent.bottom

            Text {
                anchors.fill: parent
                verticalAlignment: Text.AlignBottom
                horizontalAlignment: Text.AlignLeft
                font {
                    family: Fonts.sfyFont
                    pixelSize: parent.height
                    underline: !prefer24
                }
                color: !prefer24 ? root.enabled ? Colors.themeMainColor : Colors.disabled(Colors.themeMainColor) : Colors.skinFrameTXT
                fontSizeMode: Text.Fit
                minimumPixelSize: 3
                text: "12"
            }

            MouseArea {
                enabled: root.enabled
                anchors.fill: parent
                onClicked: _toggle2412()
            }
        }

        Item {
            visible: !amPm1224BottomLayout && switch1224
            width: parent.width/2  * (1 - Math.cos(Math.PI/4)); height: width
            anchors {
                bottom: parent.bottom
                right: parent.right
            }

            Text {
                anchors.fill: parent
                verticalAlignment: Text.AlignBottom
                horizontalAlignment: Text.AlignRight
                font {
                    family: Fonts.sfyFont
                    pixelSize: parent.height
                    underline: prefer24
                }
                color: prefer24 ? root.enabled ? Colors.themeMainColor : Colors.disabled(Colors.themeMainColor) : Colors.skinFrameTXT
                fontSizeMode: Text.Fit
                minimumPixelSize: 3
                text: "24"
            }

            MouseArea {
                enabled: root.enabled
                anchors.fill: parent
                onClicked: _toggle2412()
            }
        }
    }
}

