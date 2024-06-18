import QtQuick 2.9
import GuiLib 1.0

Rectangle {
    id: root

    // public properties
    property bool withViewer
    property bool viewerOnTop: true
    property real viewerRatio: 5/100
    property int currentPanelIndex: -1
    property bool showTips: false
    property ListModel menus: ListModel {}
    property bool blinking :false
    property real navRatio: 1/15
    property alias loading: loader.loading
    property alias currentPanel: loader.currentItem

    // private properties
    property bool _isLeft: false
    property string _currentTip: ""

    // signals
    signal panelLoaded()

    // functions
    function clearCarousel() {
        menus.clear()
    }

    function insert(index, item, tip) {
        menus.insert(index, { component: item, tip: tip })
    }

    function append(item, tip) {
        menus.append({ component: item, tip: tip })
    }

    function previous() {
        _isLeft = true
        if (currentPanelIndex > 0)
            currentPanelIndex--
        else
            currentPanelIndex = menus.count-1
    }

    function next() {
        _isLeft = false
        if (currentPanelIndex < menus.count-1)
            currentPanelIndex++
        else
            currentPanelIndex = 0
    }

    // Rectangle properties
    clip: nextNav.visible

    onCurrentPanelIndexChanged: {
        if (currentPanelIndex < 0 || currentPanelIndex >= menus.count) {
            loader.source = ""
            return
        }

        menusViewer.currentIndex = currentPanelIndex
        loader.source = menus.get(currentPanelIndex).component
    }

    // inner components
    Item {
        id: viewer

        anchors.top: viewerOnTop ? parent.top : undefined
        anchors.bottom: viewerOnTop ? undefined : parent.bottom
        width: parent.width
        height: withViewer ? parent.height*viewerRatio : 0
        visible: (height > 0) && (menus.count > 1)

        ListView {
            id: menusViewer

            property int itemWidth: height

            width: count*itemWidth + (count-1)*spacing; height: parent.height/3
            anchors.centerIn: parent
            orientation: Qt.Horizontal
            model: menus.count
            spacing: 10
            highlightFollowsCurrentItem: false
            delegate: Item {
                property int indexOfThisDelegate: index

                width: ListView.view.itemWidth
                height: ListView.view.height

                FontIcon {
                    color: Colors.skinFrameTXT
                    anchors.centerIn: parent
                    size: parent.width
                    lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.CircleThin
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: currentPanelIndex = index
                    hoverEnabled: true
                    onEntered: closingTimer.start()
                    onExited: {
                        _currentTip = ""
                        closingTimer.stop()
                    }
                }

                Timer {
                    id: closingTimer
                    interval: 250
                    onTriggered: {
                        if (showTips && (menus.count > 0))
                            _currentTip = menus.get(parent.indexOfThisDelegate).tip
                    }
                }
            }
            highlight: Item {
                width: ListView.view ? ListView.view.itemWidth : 0
                height: ListView.view ? ListView.view.height : 0
                x: menusViewer.currentItem ? menusViewer.currentItem.x : 0

                FontIcon {
                    color: Colors.skinFrameTXT
                    anchors.centerIn: parent
                    size: parent.width
                    lib: Fonts.faSolid; icon: FontAwesomeSolid.Icon.Circle
                }
            }
        }

        Item {
            width: menusViewer.width
            anchors {
                bottom: menusViewer.top; top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
            opacity: _currentTip !== "" ? 1 : 0
            Behavior on opacity { NumberAnimation {} }
            visible: opacity > 0

            StandardText {
                font {
                    pixelSize: parent.height*2/3
                    italic: true
                }
                text: _currentTip
            }
        }
    }

    CarouselNav {
        id: prevNav

        isLeft: true
        width: menus.count >= 2 ? Math.min(50, parent.width*navRatio) : 0
        visible: width > 0
        blinking: root.blinking
        onPressed: previous()
    }

    CarouselNav {
        id: nextNav

        isLeft: false
        width: menus.count >= 2 ? Math.min(50, parent.width*navRatio) : 0
        visible: width > 0
        blinking: root.blinking
        onPressed: next()
    }

    PageLoader {
        id: loader

        reversedSlide: _isLeft
        animationType: 1
        clip: true
        anchors {
            top: viewerOnTop ? viewer.bottom : parent.top
            bottom: viewerOnTop ? parent.bottom : viewer.top
            left: prevNav.right; right: nextNav.left
        }

        onPageLoaded: animationType = 2
    }
}
