import QtQuick
import GuiLib 1.0

Rectangle {
    // public properties
    property string controlName
    property string controlValue: '0'
    property bool commaUsed: false
    property bool plusMinusUsed: false
    property bool doubleUsed: false
    property int doubleFixPos: 1
    property string minimum: "-3"
    property string maximum: "100"
    property int fieldNumber: -1
    property bool firstTime: true
    property bool overLimits: false
    property int nbRows: 4
    property int nbCols: 4
    // 0: numbers; 1: time; 2: date; 3: IP
    property int keyboardType: 0

    // signals
    signal okPressed(var value, var fieldNumber)
    signal cancelPressed()

    // functions
    function checkLimits () {
        if (doubleUsed) {
            if (parseFloat(controlValue) > parseFloat(maximum))
                overLimits = true
            else if (parseFloat(controlValue) < parseFloat(minimum))
                overLimits = true
            else
                overLimits = false
        } else {
            if (Number(controlValue) > Number(maximum))
                overLimits = true
            else if (Number(controlValue) < Number(minimum))
                overLimits = true
            else
                overLimits = false
        }
    }

    function checkLimitsFix () {
        if (doubleUsed) {
            if (parseFloat(controlValue) > parseFloat(maximum)) {
                controlValue = Number(maximum).toFixed(doubleFixPos)
            } else if (parseFloat(controlValue) < parseFloat(minimum))
                controlValue = Number(minimum).toFixed(doubleFixPos)
        } else {
            if (Number(controlValue) > Number(maximum)) {
                controlValue = maximum
            } else if (Number(controlValue) < Number(minimum))
                controlValue = minimum
        }
    }

    function addNumber(number) {
        switch (keyboardType) {
        case 3:
            // IP
            if (textValue1.selectionStart !== textValue1.selectionEnd)
                controlValue = "" // clear input

            controlValue += number
            break;
        case 2:
            // DATE
            if (firstTime) {
                firstTime = false
                controlValue = "";
            }

            if (textValue1.selectionStart !== textValue1.selectionEnd)
                controlValue = "" // clear input

            controlValue += number
            break;
        case 1:
            // TIME
            if (firstTime) {
                firstTime = false
                controlValue = "";
            }

            if ( controlValue.search(/\:/) != -1) {
                if (controlValue.indexOf(':') + 2 >= controlValue.length) {
                    var tempString = controlValue + number
                    var tempMinutes = tempString.split(":")

                    if (Number(tempMinutes[1]) > 59)
                        controlValue = tempMinutes[0] + ":59"
                    else
                        controlValue += number
                }
            } else {
                if (Number(controlValue + number) < 24) {
                    controlValue += number

                    if (controlValue.length == 2)
                        controlValue += ':' // maximum hour length reached
                } else
                    controlValue = '23:'
            }
            break;
        default:
            // NUMBERS
            if (firstTime) {
                firstTime = false
                controlValue = 0;
            }

            if ( controlValue.search(/\./) != -1) {
                if (controlValue.indexOf('.') + doubleFixPos >= controlValue.length)
                    // still can add number
                    controlValue += number
            } else {
                // still can add number
                var tryValue = controlValue
                tryValue += number
                if (!isNaN(tryValue) && isFinite(tryValue))
                    controlValue = Number(tryValue)
            }

            checkLimits()
        }
    }

    // Rectangle's properties
    color: "#99696969"

    // inner components
    MouseArea {
        // block lower mouse events
        anchors.fill: parent
    }

    Rectangle {
        anchors.fill: parent
        border.width: 5; border.color: Colors.skinMenuBGD
        color: Colors.skinFrameBGD

        Rectangle {
            anchors.fill: parent
            anchors.margins: 10
            color: Colors.skinFrameFGD

            Column {
                height: parent.height * 0.95; width: parent.width * 0.95
                anchors.centerIn: parent

                Item {
                    width: parent.width; height: parent.height / 12

                    Text {
                        color: Colors.skinFrameTXT
                        font {
                            family: Fonts.sfyFont
                            pixelSize: parent.height * 2/3
                        }
                        anchors.centerIn: parent
                        text: controlName
                    }
                }
                Rectangle {
                    width: parent.width; height: parent.height / 12
                    color: Colors.themeMainColor
                    radius: 5

                    RegularExpressionValidator {
                        id: numberValidator
                        regularExpression: /^[0-9]*$/
                    }
                    RegularExpressionValidator {
                        id: timeValidator
                        regularExpression: /([01]?[0-9]|2[0-3]):[0-5][0-9]/
                    }
                    RegularExpressionValidator {
                        id: dateValidator
                        regularExpression: /^[0-3]?[0-9].[01]?[0-9].[12][90][0-9][0-9]$/
                    }
                    RegularExpressionValidator {
                        id: ipValidator
                        regularExpression: /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
                    }

                    TextInput {
                        id: textValue1

                        anchors.centerIn: parent
                        width: parent.width
                        font.pixelSize: parent.height * 2/3
                        horizontalAlignment: Text.AlignHCenter
                        font.family: Fonts.sfyFont
                        text: controlValue
                        cursorPosition: 0
                        cursorVisible: keyboardType === 3 ? true : false
                        selectByMouse: keyboardType === 3 ? true : false
                        color: {
                            if (!textValue1.acceptableInput || overLimits)
                                return "red"
                            else
                                return Colors.skinFrameTXT
                        }
                        selectionColor: Colors.skinFrameTXT
                        selectedTextColor: Colors.themeMainColor
                        inputMask: {
                            switch (keyboardType) {
                            case 2: return "99.99.9999"
                            case 1: return "00:00"
                            default: return ""
                            }
                        }
                        validator: {
                            switch (keyboardType) {
                            case 3: return ipValidator
                            case 2: return dateValidator
                            case 1: return timeValidator
                            default: return numberValidator
                            }
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (keyboardType === 3) {
                                textValue1.cursorPosition = 0
                                //textValue1.moveCursorSelection(mouseX, TextInput.SelectCharacters)
                            }
                            else
                                textValue1.selectAll()
                        }
                    }
                }
                Item {
                    width: parent.width; height: parent.height * 9/12

                    Row {
                        id: grid

                        property int itemHeight: (height - (nbRows - 1) * spacing) / nbRows
                        property int itemWidth: (width - (nbCols - 1) * spacing) / nbCols

                        anchors.fill: parent
                        anchors.topMargin: Style.stdMargin; anchors.bottomMargin: Style.stdMargin
                        spacing: 5

                        Column {
                            width: grid.itemWidth
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: parent.spacing

                            ButtonInput {
                                text: "7"
                                width: parent.width; height: grid.itemHeight
                                onButtonClicked: addNumber(text)
                            }
                            ButtonInput {
                                text: "4"
                                width: parent.width; height: grid.itemHeight
                                onButtonClicked: addNumber(text)
                            }
                            ButtonInput {
                                text: "1"
                                width: parent.width; height: grid.itemHeight
                                onButtonClicked: addNumber(text)
                            }
                            ButtonInput {
                                text: "0"
                                width: parent.width; height: grid.itemHeight
                                onButtonClicked: addNumber(text)
                            }
                        }
                        Column {
                            width: grid.itemWidth
                            spacing: parent.spacing

                            ButtonInput {
                                text: "8"
                                width: parent.width; height: grid.itemHeight
                                onButtonClicked: addNumber(text)
                            }
                            ButtonInput {
                                text: "5"
                                width: parent.width; height: grid.itemHeight
                                onButtonClicked: addNumber(text)
                            }
                            ButtonInput {
                                text: "2"
                                width: parent.width; height: grid.itemHeight
                                onButtonClicked: addNumber(text)
                            }
                            ButtonInput {
                                text: {
                                    switch (keyboardType) {
                                    case 2:
                                        return ''
                                    case 1: return ':'
                                    default: return '.'
                                    }
                                }
                                enabled: {
                                    switch (keyboardType) {
                                    case 2:
                                        return false
                                    default:
                                        return true
                                    }
                                }
                                textSize: height/3
                                width: parent.width; height: grid.itemHeight
                                dimmable: keyboardType === 1 ? true : commaUsed
                                dimmed: keyboardType === 1 ? controlValue.search(/\:/) != -1 : controlValue.search(/\./) != -1
                                onButtonClicked: {
                                    switch (keyboardType) {
                                    case 3:
                                        controlValue += '.'
                                        break;
                                    case 1:
                                        if (dimmed == false) {
                                            if (controlValue == "")
                                                controlValue = "00:" // empty so add 00 hours
                                            else
                                                controlValue += ':' // add time splitter
                                        }
                                        break;
                                    default:
                                        if ( (dimmed === false) && commaUsed)
                                            controlValue += '.'
                                    }
                                }
                            }
                        }
                        Column {
                            width: grid.itemWidth
                            spacing: parent.spacing

                            ButtonInput {
                                text: "9"
                                width: parent.width; height: grid.itemHeight
                                onButtonClicked: addNumber(text)
                            }
                            ButtonInput {
                                text: "6"
                                width: parent.width; height: grid.itemHeight
                                onButtonClicked: addNumber(text)
                            }
                            ButtonInput {
                                text: "3"
                                width: parent.width; height: grid.itemHeight
                                onButtonClicked: addNumber(text)
                            }
                            ButtonInput {
                                text: {
                                    switch (keyboardType) {
                                    case 0: return '+/-'
                                    default: return ''
                                    }
                                }
                                enabled: {
                                    switch (keyboardType) {
                                    case 0:
                                        return true
                                    default:
                                        return false
                                    }
                                }
                                textSize: height/3
                                width: parent.width; height: grid.itemHeight
                                dimmable: commaUsed
                                dimmed: controlValue.search(/\./) != -1
                                onButtonClicked: {
                                    if (dimmed === false) {
                                        if (doubleUsed)
                                            controlValue = parseFloat(controlValue * -1).toFixed(doubleFixPos)
                                        else
                                            controlValue = Number(controlValue * -1).toString()
                                        checkLimits()
                                    }
                                }
                            }
                        }
                        Column {
                            width: grid.itemWidth
                            spacing: parent.spacing

                            ButtonInput {
                                text: "C"
                                textSize: width/3
                                width: parent.width
                                height: 2*grid.itemHeight + parent.spacing
                                onButtonClicked: {
                                    if (keyboardType === 0) {
                                        controlValue = "0"
                                        checkLimits()
                                    } else {
                                        controlValue = ""
                                    }
                                }
                            }
                            ButtonInput {
                                iconId: FontAwesomeSolid.Icon.Eraser
                                iconLib: Fonts.faSolid
                                iconSize: width/3
                                width: parent.width
                                text:""
                                height: 2*grid.itemHeight + parent.spacing
                                onButtonClicked: {
                                    if (controlValue.length == 1)
                                    {
                                        switch (keyboardType) {
                                        case 3:
                                            controlValue = ""
                                            break;
                                        default:
                                            controlValue = '0'
                                        }
                                    }
                                    else if (controlValue.length > 0)
                                    {
                                        firstTime = false
                                        controlValue = controlValue.slice(0, controlValue.length -1)
                                        if (controlValue == "-")
                                            controlValue = '0'

                                        if (controlValue == ".")
                                            controlValue = '0'
                                    }
                                    if (keyboardType === 0)
                                        checkLimits()
                                }
                            }
                        }
                    }
                }
                Row {
                    width: parent.width; height: parent.height * 1/12
                    anchors.right: parent.right
                    spacing:10

                    Item {
                        height: parent.height; width: parent.width/2
                        Button {
                            anchors.centerIn: parent
                            width: parent.width*0.6; height: Utils.limitMax(parent.height, 40)
                            text: qsTr("Cancel")
                            isFlat: true
                            onClicked: cancelPressed()
                        }
                    }
                    Item {
                        height: parent.height; width: parent.width/2
                        Button {
                            anchors.centerIn: parent
                            width: parent.width*0.6; height: Utils.limitMax(parent.height, 40)
                            text: qsTr("OK")
                            isFlat: true
                            onClicked: {
                                switch (keyboardType) {
                                case 3:
                                    if (textValue1.acceptableInput)
                                        okPressed(textValue1.text, fieldNumber)
                                    break;
                                case 2:
                                    if (textValue1.acceptableInput) {
                                        controlValue = controlValue.substring(0,2)
                                                + "."
                                                + controlValue.substring(2,4)
                                                + "."
                                                + controlValue.substring(4,8)
                                        okPressed(controlValue, fieldNumber)
                                    }
                                    break;
                                case 1:
                                    if (textValue1.acceptableInput)
                                        okPressed(textValue1.text, fieldNumber)
                                    break;
                                default:
                                    if (overLimits) {
                                        checkLimitsFix()
                                        overLimits = false
                                    } else {
                                        // values ar correct
                                        if (doubleUsed)
                                            okPressed(parseFloat(controlValue).toFixed(doubleFixPos), fieldNumber)
                                        else
                                            okPressed(Number(controlValue), fieldNumber)
                                    }
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
