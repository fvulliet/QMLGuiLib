import QtQuick 2.9
import GuiLib 1.0

ListView {
    id: root

    // public properties
    property var mainMenu
    property bool display: false
    property bool displayed: display && _isSubMenu
    property int animDuration: 400
    property int textSize
    property bool isVertical: mainMenu.isVertical
    property string ctrlFont: Fonts.sfyFont
    property bool capitalized: true

    // private properties
    property bool _isSubMenu: {
        if (mainMenu.currentIndex >= 0) {
            var item = mainMenu.model.get(mainMenu.currentIndex)
            if (item && item.subMenuModel)
                return true;
        }
        return false;
    }
    property int _currentItemHook
    property int _maxElementSize: isVertical ? parent.height/10 : parent.width/10
    property int _margin

    // signals
    signal submenuClicked(int idx)

    // functions
    function hookItemY(item) {
        if (item === null)
            return 0
        // mapToItem: maps the point (0, 0), which is in mainMenu.currentItem coordinate system,
        // to root.parent coordinate system, and returns a point or rect matching the mapped coordinate
        var pos = item.mapToItem(root.parent, 0, 0)
        return pos.y + item.height / 2
    }

    function hookItemX(item) {
        if (item === null)
            return 0
        var pos = item.mapToItem(root.parent, 0, 0)
        return pos.x + item.width / 2
    }

    function updateModel() {
        if ((state.search("VISIBLE") >= 0) && (mainMenu.currentIndex >= 0)) {
            var sub = mainMenu.model.get(mainMenu.currentIndex).subMenuModel

            if (typeof(sub) === "undefined")
                return

            /* can't do that in the state PropertyChanges because of the fast-forward mechanism (Qt 5.4 internals) */
            root.model = sub

            // mainMenu.currentItem is the item, in MainMenu, that led to the apparition of the submenu
            if (isVertical) {
                _currentItemHook = hookItemY(mainMenu.currentItem)
                x = mainMenu.x + mainMenu.width - root.width // to animate the apparition of the submenu
            } else {
                _currentItemHook = hookItemX(mainMenu.currentItem)
                y = mainMenu.y + mainMenu.height - root.height // to animate the apparition of the submenu
            }
        }
    }

    // ListView's properties
    orientation: mainMenu.isVertical ? ListView.Vertical : ListView.Horizontal
    currentIndex: -1
    interactive: false
    x: {
        if (isVertical)
            return mainMenu.x + mainMenu.width - width
        else {
            if (_currentItemHook <= (width/2 + mainMenu.appTitleX))
                return mainMenu.appTitleX
            return _currentItemHook - width/2
        }
    }
    y: {
        if (isVertical) {
            if (_currentItemHook <= (height/2 + mainMenu.appTitleY))
                return mainMenu.appTitleY
            return _currentItemHook - height/2
        } else
            return mainMenu.y + mainMenu.height - height
    }

    delegate: Item {
        width: isVertical ?
                   root.width :
                   Utils.bound(root.width / count, _maxElementSize/2,
                               _maxElementSize)
        height: isVertical ?
                    Utils.bound(root.height / count, _maxElementSize/2,
                                _maxElementSize) : root.height
        states: State {
            when: menuMouseControl.containsMouse

            PropertyChanges { target: icon; scale: 1.05 }
        }
        transitions: Transition {
            NumberAnimation {
                property: "scale"; duration: 250
                easing.type: Easing.InOutQuad
            }
        }

        Item {
            id: iconItem

            height: isVertical ? parent.height : _margin
            width: isVertical ? _margin : parent.width
            anchors {
                left: isVertical ? parent.left : undefined; leftMargin: _margin
                top: isVertical ? undefined : parent.top; topMargin: _margin
            }

            FontIcon {
                id: icon

                anchors.centerIn: parent
                lib: model.lib; icon: model.img
                color: Colors.skinMenuBGD
                size: isVertical ? parent.height/3 : parent.height
            }
        }

        Item {
            height: isVertical ? parent.height : 0
            width: isVertical ? 0 : parent.width
            anchors {
                left: isVertical ? iconItem.right : undefined
                leftMargin: isVertical ? 5 : 0
                right: isVertical ? parent.right: undefined
                rightMargin: isVertical ? 5: 0
                top: isVertical ? undefined : iconItem.bottom
                topMargin: isVertical ? 0 : 2
                bottom: isVertical ? undefined : parent.bottom
                bottomMargin: isVertical ? 0 : 2
            }

            TrText {
                anchors {
                    verticalCenter: isVertical ? parent.verticalCenter : undefined
                    horizontalCenter: isVertical ? undefined : parent.horizontalCenter
                }
                color: Colors.skinMenuBGD
                font {
                    family: ctrlFont; bold: true
                    pixelSize: textSize > 0 ? textSize : Math.min(parent.height / 3, 14)
                    capitalization: root.capitalized ? Font.AllUppercase : Font.MixedCase
                }
                content: name; context: trContext
            }
        }

        MouseArea {
            id: menuMouseControl

            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                parent.ListView.view.currentIndex = index
                root.display = false
                root.submenuClicked(index)
            }
            hoverEnabled: true
        }
    }

    states: [
        State {
            name: "HIDDEN"
            when: !toSwitchTrans.running && !displayed
            PropertyChanges {
                target: root
                opacity: 0
            }
        },
        State {
            name: "SWITCH"
        },
        State {
            name: "VISIBLE_V"
            when: !toSwitchTrans.running && displayed && isVertical
            PropertyChanges {
                target: root
                x: mainMenu.x + mainMenu.width
            }
        },
        State {
            name: "VISIBLE_H"
            when: !toSwitchTrans.running && displayed && !isVertical
            PropertyChanges {
                target: root
                y: mainMenu.y + mainMenu.height
            }
        }
    ]
    transitions: [
        Transition {
            to: "*"
            SequentialAnimation {
                ScriptAction { script: updateModel(); }
                PauseAnimation {  duration: animDuration/4 }
                NumberAnimation { target: root; properties: "x, y, opacity";
                    duration: animDuration;
                    easing.type: Easing.OutQuad
                }
            }
        },
        Transition {
            id: toSwitchTrans
            to: "SWITCH"
            NumberAnimation {
                target: root; properties: "x, y"
                duration: animDuration/2;
                easing.type: Easing.OutQuad
            }
        },
        Transition {
            from: "SWITCH"
            SequentialAnimation {
                ScriptAction { script: updateModel(); }
                NumberAnimation {
                    target: root; properties: "x, y"
                    duration: animDuration;
                    easing.type: Easing.OutQuad
                }
            }
        }
    ]

    Component.onCompleted: {
        if (isVertical)
            _margin = mainMenu.width/5
        else
            _margin = mainMenu.height/5
    }

    Connections {
        target: mainMenu
        function onItemClicked() {
            root.display = true
        }
        function onCurrentIndexChanged() {
            if (root.state.search("VISIBLE") >= 0)
                root.state = "SWITCH"
        }
    }
}
