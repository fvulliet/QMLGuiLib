import QtQuick 2.9
import GuiLib 1.0

Rectangle {
    id: root

    // public properties
    property int currentValue: -1
    property int maxValue
    property bool showValue: false

    // private properties
    property int _borderSize: 2

    // Rectangle's properties
    border.width: _borderSize; border.color: Colors.themeMainColor
    state: "IDLE"
    states: [
        State {
            name: "IN_PROGRESS"
            when: currentValue >= 0 && currentValue < maxValue
        },
        State {
            name: "SUSTAIN"
            when: currentValue >= maxValue

            PropertyChanges { target: over; opacity: 1 }
        }
    ]
    transitions: Transition {
        NumberAnimation { properties: "opacity";
            easing.type: Easing.InOutQuad
            duration: 1000
        }
    }

    // inner components
    Rectangle {
        id: innerRectangle

        anchors {
            top: parent.top; topMargin: _borderSize
            bottom: parent.bottom; bottomMargin: _borderSize
            left: parent.left; leftMargin: _borderSize
        }
        width: currentValue >= 0 ?
                   (root.width * currentValue/maxValue)-_borderSize : 0
        Behavior on width { NumberAnimation { duration: 100 } }
        visible: width > 0
        color: {
            if (currentValue < 0 || currentValue >= maxValue)
                return Colors.themeMainColor
            else
                return Qt.lighter(Colors.themeMainColor, 1.66 - 0.66*(currentValue / maxValue))
        }

        StandardText {
            color: Colors.skinButtonTXT
            font {
                pixelSize: parent.height / 3;
                capitalization: Font.AllUppercase
            }
            text: currentValue
            visible: !over.visible
        }
    }

    Item {
        id: over

        anchors.fill: root
        opacity: 0
        visible: opacity > 0

        FontIcon {
            lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.Ok
            color: Colors.skinFrameFGD
            size: parent.height
            anchors.centerIn: parent
        }
    }

    Timer {
        id: sustainTimer

        interval: 2000
        repeat: false
        running: state === "SUSTAIN"
        onTriggered: state === "IDLE"
    }
}
