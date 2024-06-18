import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property bool isDiscoverInProgress: false
    property int nbItems: 0
    property bool isPossible: false
    property bool enabled
    property color itemColor: Colors.skinMenuBGD
    property alias iconLib: discover.lib
    property alias iconIcon: discover.icon

    // signals
    signal clicked()

    // functions
    function init() {
        if (!enabled)
            return

        if (nbItems === 0)
            blinking.start()
        else
            discover.opacity = 1
    }

    // Item's properties
    width: height

    Component.onCompleted: init()

    // inner components
    Connections {
        target: root
        onIsDiscoverInProgressChanged: {
            if (isDiscoverInProgress) {
                blinking.stop()
                discover.opacity = 0
                active.start()
                count.opacity = 1
            }
            else {
                count.opacity = 0
                active.stop()
            }
        }
    }

    SequentialAnimation {
        id: blinking

        loops: Animation.Infinite

        PropertyAnimation {
            target: discover
            property: "opacity"; from: 1; to: 0
        }
        PauseAnimation {
            duration: 250
        }
        PropertyAnimation {
            target: discover
            property: "opacity"; from: 0; to: 1
        }
        PauseAnimation {
            duration: 1000
        }
    }

    FontIcon {
        id: discover

        anchors.centerIn: parent
        lib: Fonts.sfyIco; icon: SfyIco.Icon.Search
        size: parent.height * 0.95
        color: Qt.lighter(itemColor, isPossible ? 1 : 1.75)
        opacity: 1
        Behavior on opacity { NumberAnimation { easing.type: Easing.InOutQuad } }
        visible: opacity > 0
    }

    ProgressItem {
        id: active

        size: parent.height
        bkgdColor: "transparent"
        withSustain: true

        onIdle: init()
    }

    Item {
        width: 2 * Math.sqrt(Math.pow((parent.width/2),2)/2)
        height: width
        anchors.centerIn: parent

        StandardText {
            id: count

            text: nbItems.toString()
            color: discover.color
            font.pointSize: parent.height
            opacity: 0
            Behavior on opacity { NumberAnimation { easing.type: Easing.InOutQuad } }
            visible: opacity > 0 && nbItems > 0
        }
    }

    MouseArea {
        enabled: isPossible
        anchors.fill: parent
        cursorShape: isPossible ? Qt.PointingHandCursor : Qt.ArrowCursor
        onClicked: root.clicked()
    }
}
