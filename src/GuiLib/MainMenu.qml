import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property bool isVertical: true
    property bool selectionEnabled: true
    property int minimizedSize: 50
    property int textSize
    property int previousIndex
    property bool canBeMinimized: false
    property bool capitalized: true
    property int animationSpeed: 400
    property bool minimized: false
    property string ctrlFont: Fonts.sfyFont
    property alias appTitle: appTitleText.text
    property alias model: menu.model
    property alias appIconIcon: appIcon.icon
    property alias appIconLib: appIcon.lib
    property alias version: version.text
    property alias elevated: elev.opacity
    property alias customItem: custom.customItem
    property alias menuListView: menu
    property alias currentIndex: menu.currentIndex
    property alias currentItem: menu.currentItem
    property alias rootScale: menu.iconScale
    property alias appTitleY: appTitle.y
    property alias appTitleX: appTitle.x

    // signals
    signal logoClicked()
    signal itemClicked()
    signal versionClicked()
    signal transitionStarted()
    signal transitionStopped()
    signal toggleMinimized()

    // functions
    function restorePreviousIndex() {
        currentIndex = previousIndex
    }

    // Rectangle's properties
    states: State {
        when: minimized

        PropertyChanges {
            target: root
            width: isVertical ? minimizedSize : width
            height: isVertical ? height : minimizedSize
        }
        PropertyChanges {
            target: logo
            opacity: 0
        }
        PropertyChanges {
            target: minimizeIcon
            anchors.leftMargin: isVertical ? 0 : undefined
            anchors.topMargin: isVertical ? undefined : 0
        }
        PropertyChanges {
            target: menu
            widthFactor: 1
            textOpacity: 0
            iconScale: 0.25
        }
        AnchorChanges {
            target: minimizeIcon
            anchors.left: undefined; anchors.top: undefined
            anchors.horizontalCenter: isVertical ? minimizer.horizontalCenter : undefined
            anchors.verticalCenter: isVertical ? undefined : minimizer.verticalCenter
        }
    }
    transitions: Transition {
        id: minimizingTransition

        AnchorAnimation { duration: root.animationSpeed }
        NumberAnimation {
            properties: "widthFactor, opacity, iconScale, textOpacity, anchors.leftMargin, anchors.topMargin, height, width"
            duration: root.animationSpeed
            easing.type: Easing.InOutQuad
        }
        onRunningChanged: {
            if (!minimized && (!running))
                root.transitionStopped()
            if (minimized && (running))
                root.transitionStarted()
        }
    }

    // inner components
    ItemShadow {
        id: elev

        anchors.fill: parent
        opacity: 0
        Behavior on opacity { NumberAnimation {} }
        visible: opacity > 0
        elevation: 2
        primaryColor: Colors.skinMenuBGD
    }

    Rectangle {
        id: header

        width: isVertical ? parent.width : parent.width / 8
        height: isVertical ? parent.height / 8 : parent.height
        anchors { top: parent.top; left: parent.left }
        color: Colors.themeMainColor
        z: 1

        Image {
            id: logo

            opacity: 1
            visible: opacity > 0
            anchors {
                left: parent.left; leftMargin: parent.width/4
                verticalCenter: parent.verticalCenter
            }
            source: "icons/SomfyWhiteLogo.png"
            sourceSize.width: parent.width/2
            fillMode: Image.PreserveAspectFit
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.logoClicked()
        }
    }

    Rectangle {
        id: appTitle

        visible: appTitleText.text.length > 0
        width: isVertical ? parent.width :
                            visible ? parent.width / 24 : 0
        height: isVertical ? visible ? parent.height / 24 : 0 : parent.height
        anchors { top: header.bottom; left: parent.left }
        color: Colors.skinFrameFGD

        Row {
            id: appRow

            property bool showIcon: appIconIcon.length > 0

            anchors.fill: parent

            Item {
                height: parent.height
                width: appRow.showIcon ? height : 0
                visible: width > 0

                FontIcon {
                    id: appIcon

                    color: Colors.themeMainColor
                    size: parent.height * 3/4
                    anchors.centerIn: parent
                }
            }
            Item {
                height: parent.height
                width: appRow.showIcon ? parent.width - height : parent.width

                StandardText {
                    id: appTitleText

                    font {
                        family: ctrlFont
                        pixelSize: parent.height/3
                    }
                    color: Colors.themeMainColor
                    visible: opacity > 0
                    opacity: logo.opacity
                }
            }
        }
    }

    Item {
        id: entries

        width: isVertical ? parent.width : undefined
        height: isVertical ? undefined : parent.height
        anchors {
            top: isVertical ? appTitle.bottom : undefined
            bottom: isVertical ? footer.top : undefined
            left: isVertical ? undefined : appTitle.right
            right: isVertical ? undefined : footer.left
        }

        Rectangle {
            id: upArrow

            width: isVertical ? parent.width : (visible ? menu.itemSize : 0)
            height: isVertical ? (visible ? menu.itemSize : 0) : parent.height
            z: 1
            anchors {
                top: isVertical ? parent.top : undefined
                left: isVertical ? undefined : parent.left
            }
            color: Colors.skinMenuBGD
            visible: !menu.fits

            FontIcon {
                lib: Fonts.faSolid
                icon: isVertical ? FontAwesomeSolid.Icon.AngleUp : FontAwesomeSolid.Icon.AngleLeft
                color: Colors.themeMainColor
                size: parent.height
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (menu.currentIndex > 0)
                        menu.currentIndex--
                }
            }
        }

        Rectangle {
            id: buttons

            width: isVertical ? parent.width : undefined
            height: isVertical ? undefined : parent.height
            color: Colors.skinFrameBGD
            anchors {
                top: isVertical ? upArrow.bottom : undefined
                bottom: isVertical ? downArrow.top : undefined
                left: isVertical ? undefined : upArrow.right
                right: isVertical ? undefined : downArrow.left
            }

            ListView {
                id: menu

                property bool fits
                property int itemSize: Utils.bound(size / count, minSize, maxSize)
                property real iconScale: 0.5
                property real textOpacity: 1
                property int size: isVertical ?
                                        (root.height - header.height - appTitle.height - footer.height) :
                                        (root.width - header.width - appTitle.width - footer.width)
                property int minSize: isVertical ? root.height / 15 : root.width / 15
                property int maxSize: isVertical ? root.height / 8 : root.width / 8
                property int menuSize: (itemSize * count) + ((count+1) * spacing)
                property real widthFactor: 2/5

                anchors.fill: parent
                spacing: 1
                focus: true
                boundsBehavior : Flickable.StopAtBounds
                highlightFollowsCurrentItem: false
                footer: Rectangle { height: menu.spacing }
                header: Rectangle { height: menu.spacing }
                currentIndex: -1
                orientation: isVertical ? ListView.Vertical : ListView.Horizontal
                fits: ((count * itemSize) <= size)
                delegate: Rectangle {
                    id: del

                    width: isVertical ? menu.width : menu.itemSize
                    height: isVertical ? menu.itemSize : menu.height
                    color: ListView.isCurrentItem ? Colors.skinFrameBGD : Colors.skinMenuBGD
                    Behavior on color {
                        ColorAnimation { duration: root.animationSpeed }
                    }

                    states: State {
                        when: menuMouseControl.containsMouse
                        PropertyChanges {
                            target: buttonIcon
                            scale: 1.05
                        }
                    }
                    transitions: Transition {
                        NumberAnimation {
                            properties: "scale"; duration: 250
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Row {
                        anchors.fill: parent

                        Item {
                            height: parent.height; width: menu.widthFactor * parent.width

                            FontIcon {
                                id: buttonIcon

                                lib: model.lib; icon: model.img
                                color: del.ListView.isCurrentItem ? Colors.skinMenuBGD : Colors.skinMenuTXT
                                size: parent.width/3
                                anchors.centerIn: parent
                            }
                        }
                        Item {
                            height: parent.height; width: (1-menu.widthFactor) * parent.width

                            TrText {
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                                opacity: menu.textOpacity
                                visible: opacity > 0
                                color: del.ListView.isCurrentItem ? Colors.skinMenuBGD : Colors.skinMenuTXT
                                Behavior on color {
                                    ColorAnimation { duration: root.animationSpeed }
                                }
                                font {
                                    family: ctrlFont
                                    pixelSize: {
                                        if (textSize > 0)
                                            return textSize

                                        if (capitalized)
                                            return Math.min(parent.height / 5, parent.width / 10)
                                        return Math.min(parent.height / 4, 14)
                                    }
                                    bold: true
                                    capitalization: root.capitalized ? Font.AllUppercase : Font.MixedCase
                                }
                                smooth: true
                                content: name; context: trContext
                                minimumPixelSize: 5
                                fontSizeMode: Text.Fit
                            }
                        }
                    }

                    MouseArea {
                        id: menuMouseControl

                        anchors.fill: parent
                        cursorShape: selectionEnabled ? Qt.PointingHandCursor : Qt.ForbiddenCursor
                        onClicked: {
                            if (selectionEnabled) {
                                root.previousIndex = parent.ListView.view.currentIndex
                                parent.ListView.view.currentIndex = index;
                                root.itemClicked()
                            }
                        }
                        hoverEnabled: true
                    }

                    Item {
                        anchors {
                            right: isVertical ? parent.right : undefined
                            bottom: isVertical ? undefined : parent.bottom
                        }
                        visible: model.subMenuModel !== undefined
                        width: isVertical ? 8 : menu.currentItem.width
                        height: isVertical ? menu.currentIndex >= 0 ? menu.currentItem.height : 0 : 8

                        FontIcon {
                            lib: Fonts.faSolid
                            icon: isVertical ? FontAwesomeSolid.Icon.CaretRight : FontAwesomeSolid.Icon.CaretDown
                            color: Colors.skinMenuTXT
                            size: isVertical ? parent.width : parent.height
                            anchors.centerIn: parent
                        }
                    }
                }
                highlight: Rectangle {
                    color: Colors.themeMainColor
                    visible: menu.currentIndex >= 0
                    opacity: 0
                    width: isVertical ? 8 : (visible ? menu.currentItem.width : 0)
                    height: isVertical ? (visible ? menu.currentItem.height : 0) : 8
                    x: isVertical ?
                           (visible ? (menu.currentItem.width + menu.currentItem.x) : 0) :
                           (visible ? menu.currentItem.x : 0)
                    y: isVertical ?
                           (visible ? menu.currentItem.y : 0) :
                           (menu.currentItem.height + menu.currentItem.y)

                    Component.onCompleted: { opacity = 1 }
                    onVisibleChanged: { opacity = 0 }
                    Behavior on x {
                        enabled: !isVertical
                        NumberAnimation { easing.type: Easing.InOutQuad }
                    }
                    Behavior on y {
                        enabled: isVertical
                        NumberAnimation { easing.type: Easing.InOutQuad }
                    }
                    Behavior on opacity { NumberAnimation {} }
                }
            }
        }

        Rectangle {
            id: downArrow

            width: isVertical ? parent.width : (visible ? menu.itemSize : 0)
            height: isVertical ? (visible ? menu.itemSize : 0) : parent.height
            anchors {
                bottom: isVertical ? parent.bottom : undefined
                left: isVertical ? undefined : parent.right
            }
            color: Colors.skinMenuBGD
            visible: !menu.fits

            FontIcon {
                lib: Fonts.faSolid
                icon: isVertical ? FontAwesomeSolid.Icon.AngleDown : FontAwesomeSolid.Icon.AngleRight
                color: Colors.themeMainColor
                size: parent.height
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (menu.currentIndex < (menu.count-1))
                        menu.currentIndex++
                }
            }
        }

        Rectangle {
            id: spare

            width: isVertical ? parent.width : (parent.width - menu.menuSize)
            height: isVertical ? (parent.height - menu.menuSize) : parent.height
            anchors {
                bottom: isVertical ? parent.bottom : undefined
                right: isVertical ? undefined : parent.right
            }
            color: Colors.skinMenuBGD
            visible: menu.fits
        }
    }

    Rectangle {
        id: footer

        color: Colors.skinMenuBGD
        width: isVertical ? parent.width : custom.width + minimizer.width
        height: isVertical ? (custom.height + minimizer.height) : parent.height
        anchors {
            bottom: isVertical ? root.bottom : undefined
            right: isVertical ? undefined : root.right
        }

        Rectangle {
            id: custom

            property Item customItem

            visible: customItem
            color: Colors.skinMenuBGD
            width: isVertical ? parent.width : (customItem ? customItem.width : 0)
            height: isVertical ? (customItem ? customItem.height : 0) : parent.height
            anchors {
                bottom: isVertical ? minimizer.top : undefined
                right: isVertical ? undefined : minimizer.left
            }

            onCustomItemChanged: {
                if (customItem)
                    customItem.parent = custom
            }
        }

        Rectangle {
            visible: custom.visible
            color: Colors.themeMainColor
            width: isVertical ? parent.width : 1
            height: isVertical ? 1 : parent.height
            anchors {
                top: isVertical ? custom.top : undefined
                left: isVertical ? undefined : custom.left
            }
        }

        Rectangle {
            visible: custom.visible
            color: Colors.themeMainColor
            width: isVertical ? parent.width : 1
            height: isVertical ? 1 : parent.height
            anchors {
                bottom: isVertical ? custom.bottom : undefined
                right: isVertical ? undefined : custom.right
            }
        }

        Item {
            id: minimizer

            property alias logoOpacity: logo.opacity

            visible: canBeMinimized
            width: isVertical ? parent.width : root.width / 25
            height: isVertical ? root.height / 25 : parent.height
            anchors {
                bottom: isVertical ? parent.bottom : undefined
                right: isVertical ? undefined : parent.right
            }

            Text {
                id: version

                width: parent.width - minimizeIcon.width
                visible: parent.logoOpacity === 1
                text: Qt.application.version
                font {
                    family: ctrlFont
                    pointSize: Utils.limitMax(parent.height/4, 12)
                }
                color: Colors.skinMenuTXT
                anchors {
                    left: isVertical ? parent.left : undefined
                    leftMargin: isVertical ? 5 : 0
                    verticalCenter: isVertical ? parent.verticalCenter : undefined
                    top: isVertical ? undefined : parent.top
                    topMargin: isVertical ? 0 : 5
                    horizontalCenter: isVertical ? undefined : parent.horizontalCenter
                }
                horizontalAlignment: Text.AlignLeft

                MouseArea {
                    width: parent.contentWidth; height: parent.contentHeight
                    anchors.right: parent.right
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.versionClicked()
                }
            }

            FontIcon {
                id: minimizeIcon

                lib: Fonts.faSolid
                icon: FontAwesomeSolid.Icon.AngleDoubleLeft
                scale: 2*menu.iconScale
                color: Colors.skinMenuTXT
                size: isVertical ? parent.height : parent.width
                anchors {
                    right: parent.right; rightMargin: 5
                    verticalCenter: parent.verticalCenter
                }
                rotation: minimized ? 180 : 0
                Behavior on rotation {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.InOutQuad
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: toggleMinimized()
                }
            }
        }
    }
}

