import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property color bkgdColor
    property bool _limited: false
    property alias innerIcon: content.contentIcon
    property int tick: 0
    property bool withSustain: _limited
    property int maxSustainDelay: 2000
    property real size

    QtObject {
        id: statesEnum
        readonly property string idle: "IDLE"
        readonly property string inProgress: "IN_PROGRESS"
        readonly property string sustain: "SUSTAIN"
    }

    // private properties
    property int _resolution: 25
    property int _limit
    property int _sustainDelay
    property int _maxAnimDuration: 1000
    property int _thickness: height/10
    property int _duration

    // signals
    signal ended()
    signal started()
    signal idle()

    // functions
    function start(d) {
        state = statesEnum.idle
        if (d) {
            _duration = d
            _limited = true
        }
        else {
            _duration = 0
            _limited = false
        }
        tick = 0
        state = statesEnum.inProgress
        progressTimer.start()

        _limit = _duration / _resolution
        _sustainDelay = (_duration / 5 < maxSustainDelay) ?
                    maxSustainDelay/_resolution : _limit/5
    }

    function end() {
        progressTimer.stop()
        state = statesEnum.idle
        idle()
    }

    function stop() {
        if (_limited) {
            end()
        } else {
            if (state === statesEnum.inProgress) {
                if (withSustain)
                    state = statesEnum.sustain
                else
                    end()
            }
        }
    }

    // Item's properties
    width: size % 2 == 0 ? size : size -1; height: width
    state: statesEnum.idle
    states: [
        State {
            name: statesEnum.inProgress
            PropertyChanges { target: canvas; opacity: 1 }
            PropertyChanges { target: progressRing; opacity: 1 }
        },
        State {
            name: statesEnum.sustain
            PropertyChanges { target: over; opacity: 1 }
        }
    ]
    transitions: Transition {
        NumberAnimation {
            property: "opacity"
            easing.type: Easing.InOutQuad
            duration: {
                if ((_duration > 0) && (_duration < _maxAnimDuration))
                    return _duration
                else
                    return _maxAnimDuration
            }
        }
    }

    onTickChanged: canvas.requestPaint()

    // inner components
    Rectangle {
        id: progressRing

        width: parent.width; height: parent.height
        anchors.centerIn: parent; anchors.alignWhenCentered: false
        radius: height / 2
        visible: opacity > 0
        opacity: 0
        color: "transparent"
        border.color: Qt.lighter(Colors.themeMainColor, 1.75)
        border.width: _thickness
    }

    Canvas {
        id: canvas

        function drawSpinner() {
            var ctx = canvas.getContext("2d");
            ctx.reset();
            ctx.clearRect(0, 0, root.width, root.height);
            ctx.strokeStyle = Colors.themeMainColor
            ctx.lineWidth = _thickness

            ctx.translate(width/2, height/2);
            ctx.rotate(internal.rotate);

            var radius = width/2 - ctx.lineWidth / 2
            if (radius >= 0) {
                ctx.arc(0, 0, radius, internal.arcStartPoint, internal.arcEndPoint, false);
                ctx.stroke();
            }
        }

        width: parent.width; height: parent.height
        anchors.centerIn: parent; anchors.alignWhenCentered: false
        renderStrategy: Canvas.Threaded
        antialiasing: true
        opacity: 0
        visible: opacity > 0

        onPaint: drawSpinner()

        QtObject {
            id: internal

            property real arcEndPoint: 0
            property real arcStartPoint: 0
            property real rotate: 0

            onArcEndPointChanged: canvas.requestPaint()
            onArcStartPointChanged: canvas.requestPaint()
            onRotateChanged: canvas.requestPaint()
        }

        NumberAnimation {
            running: state === statesEnum.inProgress
            loops: Animation.Infinite
            target: internal
            property: "rotate"
            from: 0; to: 2*Math.PI
            easing.type: Easing.Linear
            duration: _limited ? _duration : 2500
        }

        SequentialAnimation {
            id: arcAnim

            running: state === statesEnum.inProgress
            loops: Animation.Infinite

            ParallelAnimation {
                NumberAnimation {
                    target: internal
                    property: "arcStartPoint"
                    from: -Math.PI/2; to: 3 * Math.PI/2
                    easing.type: Easing.InOutQuad
                    duration: _limited ? _duration : 2500
                }
                NumberAnimation {
                    target: internal
                    property: "arcEndPoint"
                    from: -Math.PI/2; to: 7 * Math.PI/2
                    easing.type: Easing.InOutQuad
                    duration: _limited ? _duration : 2500
                }
            }
            ParallelAnimation {
                NumberAnimation {
                    target: internal
                    property: "arcStartPoint"
                    from: -Math.PI/2; to: 7 * Math.PI/2
                    easing.type: Easing.InOutQuad
                    duration: _limited ? _duration : 2500
                }
                NumberAnimation {
                    target: internal
                    property: "arcEndPoint"
                    from: -Math.PI/2; to: 3 * Math.PI/2
                    easing.type: Easing.InOutQuad
                    duration: _limited ? _duration : 2500
                }
            }
        }
    }

    Rectangle {
        id: content

        property Item contentIcon

        width: contentIcon === null ? 0 : parent.width - 2*_thickness
        height: parent.height - 2*_thickness
        visible: width > 0
        anchors {
            centerIn: parent; alignWhenCentered: false
        }
        radius: height / 2
        color: bkgdColor

        onContentIconChanged: {
            if (contentIcon) {
                contentIcon.parent = content
                contentIcon.anchors.centerIn = content
            }
        }
    }

    Rectangle {
        id: over

        anchors {
            fill: parent
            centerIn: parent
            alignWhenCentered: false
        }
        color: Colors.themeMainColor
        radius: height / 2
        opacity: 0
        visible: opacity > 0

        FontIcon {
            id: containedItem
            lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.Ok
            color: Colors.skinFrameFGD
            size: parent.height / 2
            anchors.centerIn: parent
        }
    }

    Timer {
        id: progressTimer

        interval: _resolution
        repeat: true
        onTriggered: {
            tick++
            if (_limited) {
                if (tick > _limit) {
                    if (tick > (_limit + _sustainDelay)) {
                        end()
                    } else {
                        if (withSustain)
                            state = statesEnum.sustain
                        else
                            end()
                    }
                }
            } else {
                if (state === statesEnum.sustain) {
                    if (tick > (maxSustainDelay/_resolution)) {
                        end()
                    }
                }
            }
        }
        onRunningChanged: {
            if (running)
                started()
            else
                ended()
        }
    }
}
