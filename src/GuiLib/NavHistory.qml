import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    // current page
    property string page
    // history pages
    property var pages: ([])
    property string ctrlFont: Fonts.sfyFont
    property int borderRadius: 3
    property color bkgdColor: Colors.skinFrameTXT

    // functions
    function clear() {
        pages = []
        pagesModel.clear()
    }

    function displayPage(p, icon, title) {
        clear()
        displayNext(p, icon, title)
    }

    function displayGivenPage(idx) {
        if (pages[idx] === page)
            return

        var lastIdx = pagesModel.count-1
        for (var i=lastIdx; i>idx; --i) {
            pagesModel.remove(i)
            pages.pop()
        }
        page = pages[pages.length - 1]
    }

    function displayNext(p, icon, title) {
        pagesModel.append({name: p, historyIcon: icon, historyTitle: title});
        pages.push(p)
        page = pages[pages.length - 1]
    }

    function displayPrevious() {
        pagesModel.remove(pagesModel.count - 1)
        pages.pop()
        page = pages[pages.length - 1]
    }

    // inner components
    ListModel {
        id: pagesModel
    }

    ListView {
        id: entriesList

        anchors.fill: parent
        orientation: ListView.Horizontal
        currentIndex: 0
        visible: model.count > 0
        model: pagesModel
        interactive: false
        delegate: Item {
            height: parent.height; width: childrenRect.width

            Row {
                height: parent.height; width: childrenRect.width

                Rectangle {
                    height: parent.height*2/3; width: childrenRect.width
                    anchors.verticalCenter: parent.verticalCenter
                    color: bkgdColor
                    radius: borderRadius

                    Row {
                        height: parent.height; width: childrenRect.width

                        Item {
                            height: parent.height; width: height

                            FontIcon {
                                lib: historyIcon.iconLib
                                icon: historyIcon.iconIcon
                                color: Colors.skinFrameBGD
                                size: parent.height*3/4
                                anchors.centerIn: parent
                            }
                        }
                        Text {
                            height: parent.height
                            font {
                                pixelSize: parent.height/2
                                family: root.ctrlFont
                                capitalization: Font.AllLowercase
                            }
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            color: Colors.skinFrameBGD
                            text: historyTitle
                        }
                        Item {
                            height: parent.height; width: 4
                        }
                    }
                }
                Item {
                    height: parent.height*3/4; width: 20
                    anchors.verticalCenter: parent.verticalCenter

                    FontIcon {
                        lib: Fonts.faSolid
                        icon: FontAwesomeSolid.Icon.CaretRight
                        color: Colors.skinFrameTXT
                        size: parent.height*3/4
                        anchors.centerIn: parent
                        opacity: index < (entriesList.count-1) ? 1 : 0
                        Behavior on opacity { NumberAnimation {} }
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    parent.ListView.view.currentIndex = index
                    displayGivenPage(index)
                }
            }
        }
    }
}
