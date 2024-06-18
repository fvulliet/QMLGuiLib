import QtQuick 2.9
import GuiLib 1.0

Rectangle {
    id: root

    // public properties
    property int count
    property int rawCount
    property bool registerPlus
    property bool registerMinus
    property bool isHorizontal: true
    property bool withCount: true
    property int maxItemHeight: 40
    property ListModel actions: ListModel {}
    property bool withFilter: false
    property alias showFilterChoice: filterItem.showFilterChoice
    property real prefixRatio: 0.33
    property real filterRatio: 0.33
    property real filterMargin: Style.stdMargin
    property alias filterList: filterItem.filterList
    property alias currentFilter: filterItem.currentFilter
    property int filterKey
    property int maxTextSize: 20
    property int margin: 4
    property bool withPrefix: false
    property alias prefixText: prefixField.text

    property alias taskbarTitle: title.text
    property alias showMinus: minusAction.displayed

    signal creationRequested()
    signal destructionRequested()
    signal setFilter(string text)
    signal setPrefix(string text)

    function registerAction(action) {
        actions.append({ item: action })
    }

    function unregisterAction(action) {
        // find 'action' in actions list and remove it
        for (var i=0; i<actions.count; ++i) {
            if (actions.get(i).item.icon === action.icon) {
                actions.remove(i)
                break
            }
        }
    }

    // Rectangle's properties
    color: Colors.skinFrameFGD

    Component.onCompleted: {
        if (registerPlus)
            registerAction(plusAction)
        if (registerMinus)
            registerAction(minusAction)
    }

    onCurrentFilterChanged: {
        filterKey = filterList[currentFilter].key
    }

    // inner components
    TaskBarAction {
        id: plusAction

        lib: Fonts.faSolid
        icon: FontAwesomeSolid.Icon.PlusSign
        color: Colors.skinFrameTXT
        onActionClicked: creationRequested()
        Component.onDestruction: unregisterAction(plusAction)
    }

    TaskBarAction {
        id: minusAction

        lib: Fonts.faSolid
        icon: FontAwesomeSolid.Icon.MinusSign
        color: Colors.skinFrameTXT
        onActionClicked: destructionRequested()
        Component.onDestruction: unregisterAction(minusAction)
    }

    Row {
        id: countRowItem

        height: isHorizontal ? parent.height : Math.min(maxItemHeight, parent.height/4)
        width: withCount ? childrenRect.width : 0
        visible: width > 0

        Item {
            height: parent.height; width: root.margin
        }
        ListCount {
            id: countText

            height: parent.height; width: parent.height*2/3
            value: count
            filtered: withFilter
            filteredIconBkgd: root.color
        }
        Item {
            id: separatorCtnr

            height: parent.height
            width: withFilter ? height/4 : 0
            opacity: width > 0 ? 1 : 0
            Behavior on opacity { NumberAnimation {} }
            visible: opacity > 0

            Text {
                anchors.centerIn: parent
                text: "/"
                color: countText.textColor
                font {
                    family: Fonts.sfyFont
                    pixelSize: countText.textSize*0.9
                }
                minimumPixelSize: 5; fontSizeMode: Text.Fit
            }
        }
        Item {
            id: rawCountCtnr

            height: parent.height
            width: withFilter ? childrenRect.width : 0
            opacity: width > 0 ? 1 : 0
            Behavior on opacity { NumberAnimation {} }
            visible: opacity > 0

            Text {
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: rawCount
                color: countText.textColor
                font {
                    pixelSize: countText.textSize*0.9
                    family: Fonts.sfyFont
                }
            }
        }
        Item {
            height: parent.height; width: root.margin
        }
        Item {
            id: titleItem

            height: parent.height
            width: childrenRect.width

            Text {
                id: title

                anchors.verticalCenter: parent.verticalCenter
                color: Colors.skinFrameTXT
                font {
                    family: Fonts.sfyFont
                    pixelSize: parent.height/3
                }
                minimumPixelSize: 10
                fontSizeMode: Text.Fit
            }
        }
    }

    Searchable {
        id: filterItem

        height: isHorizontal ? parent.height : Math.min(maxItemHeight, parent.height/4)
        width: {
            if (!withFilter)
                return 0
            return isHorizontal ? (parent.width - titleItem.width - actionsItem.width - filterMargin - prefixItem.width - Style.stdMargin) * filterRatio
                                : parent.width - 2*Style.borderMargin
        }
        opacity: width > 0 ? 1 : 0
        Behavior on opacity { NumberAnimation {} }
        visible: opacity > 0
        anchors {
            right: isHorizontal ? prefixItem.left : undefined; rightMargin: isHorizontal ? filterMargin : 0
            top: isHorizontal ? parent.top : countRowItem.bottom
            horizontalCenter: isHorizontal ? undefined : parent.horizontalCenter
        }
        onSetFilter: root.setFilter(text)
    }

    Item {
        id: prefixItem

        height: isHorizontal ? parent.height : Math.min(maxItemHeight, parent.height/4)
        width: {
            if (!withPrefix)
                return 0
            return isHorizontal ? (parent.width - titleItem.width - actionsItem.width - filterMargin - filterItem.width - Style.stdMargin) * prefixRatio
                                : parent.width - 2*Style.borderMargin
        }
        opacity: width > 0 ? 1 : 0
        Behavior on opacity { NumberAnimation {} }
        visible: opacity > 0
        anchors {
            right: isHorizontal ? actionsItem.left : undefined; rightMargin: isHorizontal ? Style.stdMargin : 0
            top: isHorizontal ? parent.top : filterItem.bottom
            horizontalCenter: isHorizontal ? undefined : parent.horizontalCenter
        }

        SfyTextInput {
            id: prefixField

            height: parent.height - 2
            width: parent.width
            anchors.centerIn: parent
            ctrlFont: Fonts.sfyFont
            placeholderText: qsTr("prefix")
            onEditingFinished: setPrefix(prefixField.text)
        }
    }

    ListView {
        id: actionsItem

        anchors {
            right: parent.right
            bottom: isHorizontal ? undefined : parent.bottom
        }
        height: isHorizontal ? parent.height : Math.min(maxItemHeight, parent.height/4)
        implicitWidth: contentItem.childrenRect.width
        orientation: ListView.Horizontal
        layoutDirection: Qt.RightToLeft
        interactive: false
        model: actions
        delegate: Item {
            height: ListView.view.height
            width: item.displayed ? ListView.view.height : 0
            Behavior on width { NumberAnimation {} }
            opacity: item.displayed ? 1 : 0
            Behavior on opacity { NumberAnimation {} }
            visible: width > 0
            anchors.verticalCenter: parent.verticalCenter

            PressedIcon {
                width: item.size > 0 ? item.size : parent.height*0.9
                height: width
                anchors.centerIn: parent
                lib: item.lib
                icon: item.icon
                color: item.color
                enabled: parent.visible

                onClicked: item.actionClicked()
            }
        }
    }
}

