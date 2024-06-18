import QtQuick 2.9
import GuiLib 1.0

MouseArea {
    id: root

    // public properties
    property bool active: false
    property bool centered: false /* center the area even on mouseClicks */
    property bool activeFocusOnPress: false
    property bool hasFocus: false
    property int focusWidth: width
    property int focusX: width / 2 /*<! focus circle center X */
    property int focusY: height / 2 /*<! focus circle center Y */

    // signals
    signal focusAnimationOver()
    signal activeFocusRequest()

    // functions
    function getMaxRadius(x, y) {
        var d1 = Math.max(distance(x, y, 0, 0), distance(x, y, width, height))
        var d2 = Math.max(distance(x, y, width, 0), distance(x, y, 0, height))
        return Math.max(d1,d2)
    }

    function distance(x1, y1, x2, y2) {
        var dx = x2 - x1
        var dy = y2 - y1
        return Math.sqrt( dx * dx + dy * dy )
    }

    // MouseArea's properties
    cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

    function onPressed() {
        if (activeFocusOnPress) {
            if (!centered)
                focusAreaCircle.update(mouse)
            activeFocusRequest()
        }
        clickAreaCircle.update(centered, mouse)
    }

    // inner components
    Rectangle {
        id: clickAreaCircle

        property real circleCenterX
        property real circleCenterY
        property int maxDiam: focusWidth
        property int minDiam: focusWidth * 0.3

        function update(c, m) {
            if (typeof(m) === "undefined")
                c = true

            clickAreaCircle.circleCenterX = c ? Qt.binding(function() { return focusX }) : m.x
            clickAreaCircle.circleCenterY = c ? Qt.binding(function() { return focusY }) : m.y
            clickAreaCircle.maxDiam = c ? Qt.binding(function() { return focusWidth }) : (getMaxRadius(m.x,m.y) * 2)
            clickAreaCircle.state = "VISIBLE"
        }

        color: active ? Colors.themeMainColor : Colors.skinFrameTXT
        Behavior on color { ColorAnimation { duration: 250 } }

        opacity: (pressed || opacityTimer.running) ? 0.25 : 0
        Behavior on opacity { NumberAnimation { duration: opacityTimer.interval } }
        visible: opacity !== 0
        height: minDiam
        width: height
        radius: width / 2
        x: circleCenterX - width / 2
        y: circleCenterY - height / 2

        states: [
            State {
                name: "VISIBLE"
                PropertyChanges {
                    target: clickAreaCircle
                    height: maxDiam
                }
                StateChangeScript {
                    script: opacityTimer.restart()
                }
            },
            State {
                name: "HIDDEN"
                when: !clickAreaCircle.visible && !pressed
            }
        ]
        transitions: [
            Transition {
                to: "VISIBLE"
                ParallelAnimation {
                    NumberAnimation {
                        property: "height"
                        duration: 500
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        ]
    }

    Timer {
        id: opacityTimer

        interval: 250
        onTriggered: focusAnimationOver()
    }

    Rectangle {
        id: focusAreaCircle

        property real circleCenterX
        property real circleCenterY
        property int maxDiam: focusWidth
        property int minDiam: focusWidth * 0.3

        function update(m) {
            if (typeof(m) === "undefined")
                return
            focusAreaCircle.circleCenterX = m.x
            focusAreaCircle.circleCenterY = m.y
            focusAreaCircle.maxDiam = getMaxRadius(m.x, m.y) * 2
        }

        color: active ? Colors.themeMainColor : Colors.skinFrameTXT
        Behavior on color { ColorAnimation { duration: 250 } }

        visible: opacity !== 0
        height: minDiam
        width: height
        radius: width / 2
        x: circleCenterX - width / 2
        y: circleCenterY - height / 2

        states: [
            State {
                name: "VISIBLE"
                when: root.hasFocus

                PropertyChanges {
                    target: focusAreaCircle
                    height: maxDiam
                    opacity: 0.10
                }
            },
            State {
                name: "HIDDEN"
                when: !root.hasFocus

                PropertyChanges {
                    target: focusAreaCircle
                    restoreEntryValues: false
                    circleCenterX: root.focusX
                    circleCenterY: root.focusY
                    maxDiam: root.focusWidth
                    opacity: 0
                }
            }
        ]

        transitions: [
            Transition {
                to: "VISIBLE"
                ParallelAnimation {
                    NumberAnimation {
                        property: "height"
                        duration: 500
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        ]
    }
}
