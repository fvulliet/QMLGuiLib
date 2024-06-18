import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    property color widgetColor: Colors.themeMainColor
    property bool enabled: true
    property int maxGuideHeight: 40
    property int maxGuideWidth: 40
    property real widgetValue: 0.5
    property bool isHorizontal: true

    property int _currentX: guide.x + guide.width*widgetValue - magnifierCtnr.width/2
    property int _currentY: guide.y + guide.height*widgetValue - magnifierCtnr.height/2
    property int _border: 2
    property real _ratio: 0.5 + 0.5*widgetValue

    function reset() {
        setValue(0.5)
    }

    function setValue(value) {
        widgetValue = value
        moveIcon()
    }

    function moveIcon() {
        _currentX = guide.x + guide.width*widgetValue - magnifierCtnr.width/2
        _currentY = guide.y + guide.height*widgetValue - magnifierCtnr.height/2
    }

    Rectangle {
        id: guide

        height: isHorizontal ? Math.min(maxGuideHeight, parent.height/4) : parent.height - (parent.width - width) - 2*_border
        width: isHorizontal ? parent.width - (parent.height - height) - 2*_border : Math.min(maxGuideWidth, parent.width/4)
        anchors.centerIn: parent
        color: widgetColor
        radius: isHorizontal ? height/2 : width/2
    }

    Rectangle {
        id: magnifierCtnr

        height: isHorizontal ? parent.height*_ratio : parent.width*_ratio; width: height
        anchors.verticalCenter: isHorizontal ? parent.verticalCenter : undefined
        anchors.horizontalCenter: isHorizontal ? undefined : parent.horizontalCenter
        color: "white"
        border {
            color: widgetColor; width: _border
        }
        radius: isHorizontal ? height/2 : width/2
        x: isHorizontal ? Utils.bound(guide.x - width/2 + _currentX, guide.x - width/2, guide.x - width/2 + guide.width) : 0
        y: isHorizontal ? 0 : Utils.bound(guide.y - height/2 + _currentY, guide.y - height/2, guide.y - height/2 + guide.height)

        FontIcon {
            lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.Search
            color: Colors.themeMainColor
            size: isHorizontal ? parent.height/2 : parent.width/2
            anchors.centerIn: parent
        }

        MouseArea {
            id: mouseArea

            enabled: root.enabled
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onPositionChanged: {
                if (enabled && pressed) {
                    if (isHorizontal) {
                        _currentX = magnifierCtnr.x + mouse.x - magnifierCtnr.width/2
                        _ratio = Utils.bound(0.5 + 0.5*_currentX/guide.width, 0.5, 1)
                        widgetValue = Utils.bound(_currentX/guide.width, 0, 1)
                    } else {
                        _currentY = magnifierCtnr.y + mouse.y - magnifierCtnr.height/2
                        _ratio = Utils.bound(0.5 + 0.5*_currentY/guide.height, 0.5, 1)
                        widgetValue = Utils.bound(_currentY/guide.height, 0, 1)
                    }
                }
            }
        }
    }
}
