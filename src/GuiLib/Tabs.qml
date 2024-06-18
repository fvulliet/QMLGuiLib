import QtQuick 2.9
import GuiLib 1.0

Rectangle {
    id: root

    // public properties
    property int maxTextSize: 20
    property int maxIconSize
    property color txtColor: withBackground && dark ? Colors.skinFrameBGD : Colors.skinFrameTXT
    property color iconColor: withBackground && dark ? Colors.skinFrameBGD : Colors.skinFrameTXT
    property bool widgetEnabled: true
    property string ctrlFont: Fonts.sfyFont
    property int highlightHeight: 2
    property bool withBackground: false
    property bool dark: false
    property alias model: list.model
    property alias currentIndex: list.currentIndex

    // private properties
    property int _justCount: count
    property int _currentSize: Utils.limitMax(height/2, maxTextSize)
    property bool _hasIcons

    // signals
    signal selected(int index)

    color: withBackground ? dark ? Colors.skinFrameTXT : Colors.skinFrameBGD : "transparent"

    ListView {
        id: list

        function justify() {
            _justCount = count
            for (var i=0; i<count; ++i) {
                if (!model.get(i).isVisible) {
                    _justCount--
                }
            }
            if (_justCount <= 0)
                _justCount = count
        }

        anchors.fill: parent
        currentIndex: 0
        highlightFollowsCurrentItem: false
        orientation: ListView.Horizontal
        interactive: false
        delegate: Item {
            id: del

            property alias contentWidth: tabTxt.contentWidth
            property bool isCurrentItem: ListView.isCurrentItem

            height: ListView.view.height
            z: -1
            width: {
                if (isVisible)
                    return (ListView.view.width / _justCount) - (_justCount-1) * list.spacing
                else
                    return 0
            }
            visible: isVisible

            onVisibleChanged: list.justify()

            Column {
                anchors.fill: parent

                Item {
                    id: iconField

                    width: parent.width
                    height: {
                        if (hasIcon) {
                            if (hasText)
                                return (parent.height - highlightHeight)/2
                            else
                                return parent.height - highlightHeight
                        } else
                            return 0
                    }
                    visible: height > 0

                    FontIcon {
                        id: tabIcon

                        anchors.centerIn: parent
                        icon: iconId
                        lib: iconLib
                        size: maxIconSize > 0 ? maxIconSize : parent.height
                        color: iconColor
                    }
                }
                Item {
                    id: textField

                    width: parent.width
                    height: {
                        if (hasText) {
                            if (hasIcon)
                                return (parent.height - highlightHeight)/2
                            else
                                return parent.height - highlightHeight
                        } else
                            return 0
                    }
                    visible: height > 0

                    TrText {
                        id: tabTxt

                        font {
                            family: root.ctrlFont
                            bold: del.isCurrentItem
                            pixelSize: _currentSize
                        }
                        color: txtColor
                        anchors.centerIn: parent
                        content: name; context: trContext
                        minimumPixelSize: 5
                        fontSizeMode: Text.Fit
                    }
                }
                Item {
                    id: highlightArea

                    width: parent.width
                    height: highlightHeight
                }
            }

            MouseArea {
                enabled: widgetEnabled
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    parent.ListView.view.currentIndex = index;
                    selected(index)
                }
            }
        }
        highlight: Rectangle {
            visible: list.currentIndex >= 0
            width: {
                if (!visible || ListView.view === null)
                    return 0

                return ListView.view.currentItem ? ListView.view.currentItem.contentWidth : 0
            }
            height: highlightHeight
            color: Colors.themeMainColor
            z: 1
            x: {
                if (!visible || ListView.view === null)
                    return 0

                return ListView.view.currentItem ? ListView.view.currentItem.x + ((ListView.view.currentItem.width - width)/2) : 0
            }
            Behavior on x { NumberAnimation { easing.type: Easing.InOutQuad } }
            y: {
                if (!visible || ListView.view === null)
                    return 0

                return _hasIcons ? root.y + root.height - highlightHeight :
                                   _currentSize + (root.height - _currentSize) / 2

    //            if (hasText) {
    //                if (hasIcon) {
    //                    // text + icon
    //                    return root.y + root.height - highlightHeight
    //                } else {
    //                    // text only
    //                    return _currentSize + (ListView.view.height - _currentSize) / 2
    //                }
    //            } else if (hasIcon) {
    //                // icon only
    //                return root.y + root.height - highlightHeight
    //            } else
    //                return 0
            }
        }

        onCountChanged: {
            _hasIcons = false
            for (var i=0; i<count; ++i) {
                if (list.model.get(i).hasIcon) {
                    _hasIcons = true
                    break
                }
            }
            justify()
        }
    }
}

