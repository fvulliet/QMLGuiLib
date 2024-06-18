import QtQuick
import QtQuick.Controls
import GuiLib 1.0

Column {
    id: root

    // public properties
    property date currentDate
    property int selectedDay
    property int currentYear
    property int currentMonth
    property string ctrlFont: Fonts.sfyFont
    property bool withYears: true

    // signals
    signal dateChanged(date newDate)

    // functions
    function updateYear(year) {
        var d = new Date(currentDate)
        d.setUTCFullYear(year)
        currentDate = d
        dateChanged(currentDate)
    }

    function getMonthStr(value) {
        switch (value) {
        case 0:
            return qsTr("January")
        case 1:
            return qsTr("February")
        case 2:
            return qsTr("March")
        case 3:
            return qsTr("April")
        case 4:
            return qsTr("May")
        case 5:
            return qsTr("June")
        case 6:
            return qsTr("July")
        case 7:
            return qsTr("August")
        case 8:
            return qsTr("September")
        case 9:
            return qsTr("October")
        case 10:
            return qsTr("November")
        case 11:
            return qsTr("December")
        }
    }

    // inner components
    Row {
        id: header

        width: parent.width; height: Math.min(50, parent.height/6)

        Item {
            height: parent.height; width: withYears ? height/2 : 0
            visible: width > 0

            FontIcon {
                anchors.centerIn: parent
                color: dblLeftArrow.pressed && root.currentYear > 2000 ? Colors.skinFrameBGD : Colors.skinMenuBGD
                lib: Fonts.faSolid
                icon: FontAwesomeSolid.Icon.AngleDoubleLeft
                size: parent.width
            }
            MouseArea {
                id: dblLeftArrow

                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (root.currentYear > 2000) {
                        root.currentYear--
                        updateYear(root.currentYear)
                    }
                }
            }
        }
        Item {
            height: parent.height; width: height/2

            FontIcon {
                anchors.centerIn: parent
                color: leftArrow.pressed ? Colors.skinFrameBGD : Colors.skinMenuBGD
                lib: Fonts.faSolid
                icon: FontAwesomeSolid.Icon.AngleLeft
                size: parent.width
            }
            MouseArea {
                id: leftArrow
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (root.currentMonth > 0)
                        root.currentMonth--
                    else {
                        // min year is 2000
                        if (root.currentYear > 2000) {
                            root.currentYear--
                            root.currentMonth = 11
                        }
                    }
                }
            }
        }
        Item {
            height: parent.height
            width: withYears ? parent.width-2*height : parent.width-height

            StandardText {
                id: calendarTitleTxt

                font {
                    family: ctrlFont
                    pixelSize: parent.height/3
                }
                text: withYears ? calendar.title : getMonthStr(root.currentMonth)
            }
        }
        Item {
            height: parent.height; width: height/2

            FontIcon {
                anchors.centerIn: parent
                color: rightArrow.pressed ? Colors.skinFrameBGD : Colors.skinMenuBGD
                lib: Fonts.faSolid
                icon: FontAwesomeSolid.Icon.AngleRight
                size: parent.width
            }
            MouseArea {
                id: rightArrow
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (root.currentMonth < 11)
                        root.currentMonth++
                    else {
                        // max year is 2099
                        if (root.currentYear < 2099) {
                            root.currentYear++
                            root.currentMonth = 0
                        }
                    }
                }
            }
        }
        Item {
            height: parent.height; width: withYears ? height/2 : 0
            visible: width > 0

            FontIcon {
                anchors.centerIn: parent
                color: dblRightArrow.pressed && root.currentYear < 2099 ? Colors.skinFrameBGD : Colors.skinMenuBGD
                lib: Fonts.faSolid
                icon: FontAwesomeSolid.Icon.AngleDoubleRight
                size: parent.width
            }
            MouseArea {
                id: dblRightArrow
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (root.currentYear < 2099) {
                        root.currentYear++
                        updateYear(root.currentYear)
                    }
                }
            }
        }
    }
    DayOfWeekRow {
        id: dayOfWeekCtnr

        width: parent.width; height: withYears ? header.height *2/3 : 0
        visible: height > 0
        delegate: Item {
            width: dayOfWeekCtnr.width; height: dayOfWeekCtnr.height

            StandardText {
                text: model.shortName
                font {
                    family: ctrlFont
                    pixelSize: Math.min(14, parent.height*0.9)
                    bold: true
                }
            }
        }
    }
    Item {
        id: calendarCtnr

        width: parent.width; height: withYears ? parent.height - header.height - dayOfWeekCtnr.height : 0
        visible: height > 0

        MonthGrid {
            id: calendar

            spacing: 0
            anchors.fill: parent
            month: root.currentMonth
            year: root.currentYear
            locale: dayOfWeekCtnr.locale
            delegate: Rectangle {
                id: del

                property bool selected: {
                    return currentDate.getDate() === model.day && currentDate.getMonth() === model.month
                }

                color: selected ? Colors.themeMainColor : "transparent"

                StandardText {
                    text: model.day
                    font {
                        family: ctrlFont
                        pixelSize: del.selected ? Math.min(22, parent.height/1.25) : Math.min(18, parent.height/1.75)
                        bold: del.selected
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        currentDate = model.date
                        root.selectedDay = model.day
                        dateChanged(model.date)
                    }
                }
            }
        }
    }
    Item {
        id: daysCtnr

        width: parent.width; height: withYears ? 0 : parent.height - header.height
        visible: height > 0

        GridView {
            id: daysGrid

            property int maxItemsPerLine: 7
            property int maxItemsPerColumn: 5
            property int currentRow: 0
            property int currentColumn: 0

            anchors.fill: parent
            model: root.currentMonth === 1 ? 29 : root.currentMonth === 0
                   || root.currentMonth === 2
                   || root.currentMonth === 4
                   || root.currentMonth === 6
                   || root.currentMonth === 7
                   || root.currentMonth === 9
                   || root.currentMonth === 11 ? 31 : 30
            currentIndex: -1
            boundsBehavior: Flickable.StopAtBounds
            clip: true
            cellWidth: width/maxItemsPerLine
            cellHeight: height / maxItemsPerColumn
            interactive: false
            delegate: Rectangle {
                id: dayDel

                property bool selected: (root.selectedDay === index + 1)
                                        && (currentDate.getMonth() === root.currentMonth)

                width: GridView.view.cellWidth; height: GridView.view.cellHeight
                color: selected ? Colors.themeMainColor : "transparent"

                StandardText {
                    text: index + 1
                    font {
                        family: ctrlFont
                        pixelSize: dayDel.selected ? Math.min(22, parent.height/1.25) : Math.min(18, parent.height/1.75)
                        bold: dayDel.selected
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        root.selectedDay = index + 1
                        var dateTime = new Date() // now, useless anyway
                        dateTime.setDate(root.selectedDay)
                        dateTime.setMonth(root.currentMonth)
                        currentDate = dateTime
                        dateChanged(dateTime)
                    }
                }
            }
        }
    }
}
