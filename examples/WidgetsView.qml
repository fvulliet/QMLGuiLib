import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    property string _trContext: "WidgetsView"
    property int current1: 45
    property int current2: 90
    property int current11: 45
    property int current22: 90
    property int currentCompass: 42
    property int currentCompass2: 42
    property int currentThreshold: 45
    property int currentThreshold2: 1
    property int currentElevation1: 0
    property int currentElevation2: 90

    Component.onCompleted: {
        rangeWidget.widgetValueFrom = current1
        rangeWidget.widgetValueTo = current2
        rangeWidget2.widgetValueFrom = current11
        rangeWidget2.widgetValueTo = current22
        compassWidget.widgetValue = currentCompass
        compassWidget2.widgetValue = currentCompass2
        thresholdWidget.currentValue = currentThreshold
        thresholdWidget2.currentValue = currentThreshold2
        elevationWidget.widgetValueFrom = currentElevation1
        elevationWidget.widgetValueTo = currentElevation2
        knob1.currentValue = 50
    }

    DemoHeader {
        id: header

        width: parent.width; height: parent.height / 15
        anchors.top: parent.top
        title: QT_TR_NOOP("WIDGETS"); trContext: _trContext
    }

    Row {
        anchors {
            top: header.bottom; topMargin: Style.stdMargin
            bottom: parent.bottom; bottomMargin: Style.stdMargin
        }
        width: parent.width

        Column {
            height: parent.height; width: parent.width/2
            spacing: 10

            Row {
                width: parent.width; height: (parent.height-parent.spacing)/3

                Item {
                    height: parent.height; width: parent.width/2

                    RangeWidget {
                        id: rangeWidget2

                        anchors.fill: parent
                        title: "Azimuth"
                        titleSize: 16
                        rot: 0
                        activeRangeIconLib: Fonts.sfyIco
                        activeRangeIconIcon: SfyIco.Icon.Sun

                        onWidgetValueFromChanged: current11 = widgetValueFrom
                        onWidgetValueToChanged: current22 = widgetValueTo
                    }
                }
                Item {
                    height: parent.height; width: parent.width/2

                    RangeWidget {
                        id: rangeWidget

                        anchors.fill: parent
                        title: "Range"
                        titleSize: 16
                        rot: 0
                        centerIconLib: Fonts.sfyIco
                        centerIconIcon: SfyIco.Icon.WindDirection

                        onWidgetValueFromChanged: current1 = widgetValueFrom
                        onWidgetValueToChanged: current2 = widgetValueTo
                    }
                }
            }
            Row {
                width: parent.width; height: (parent.height-parent.spacing)/3

                Item {
                    height: parent.height; width: parent.width/2

                    ThresholdWidget {
                        id: thresholdWidget

                        anchors.fill: parent
                        title: "Threshold"
                        minValue: 10
                        maxValue: 80
                        unit: "m/s"
                        lib: Fonts.sfyIco
                        icon: SfyIco.Icon.WindSensor

                        onCurrentValueChanged: currentThreshold = currentValue
                    }
                }
                Item {
                    height: parent.height; width: parent.width/2

                    ThresholdWidget {
                        id: thresholdWidget2

                        anchors.fill: parent
                        title: "Threshold"
                        minValue: -15
                        maxValue: 15
                        unit: "°C"
                        lib: Fonts.sfyIco
                        icon: SfyIco.Icon.Weather
                        isMaximal: false

                        onCurrentValueChanged: currentThreshold2 = currentValue
                    }
                }
            }
            Row {
                width: parent.width; height: (parent.height-parent.spacing)/3

                Item {
                    height: parent.height; width: parent.width/2

                    SignalLevel {
                        id: signalWidget

                        anchors.fill: parent; anchors.margins: 10
                        nbBars: 10
                        onColor: Colors.themeMainColor
                        offColor: Colors.skinFrameTXT
                        isLinear: false
                        min: 0
                        max: 100
                        maxOffset: 20
                        level: knob1.currentValue
                    }
                }
                Item {
                    height: parent.height; width: parent.width/2

                    Knob {
                        id: knob1

                        height: parent.height/2; width: height
                        anchors.centerIn: parent
                        txtTitle: "level"
                        txtValue: currentValue
                        txtUnit: "%"
                        minValue: 0; maxValue: 100
                        draggable: true
                        useBasicInput: true
                    }
                }
            }
        }
        Column {
            height: parent.height; width: parent.width/2
            spacing: 10

            Item {
                width: parent.width; height: (parent.height-parent.spacing)/3

                Compass {
                    id: compassWidget

                    width: parent.width; height: parent.height
                    anchors.centerIn: parent

                    onWidgetValueChanged: currentCompass = widgetValue
                }
            }
            Item {
                width: parent.width; height: (parent.height-parent.spacing)/3

                Compass2 {
                    id: compassWidget2

                    width: parent.width; height: parent.height
                    anchors.centerIn: parent
                    ctrlFont: Fonts.sfyFont

                    onWidgetValueChanged: currentCompass2 = widgetValue
                }
            }
            Item {
                width: parent.width; height: (parent.height-parent.spacing)/3

                ElevationWidget {
                    id: elevationWidget

                    anchors.fill: parent
                    title: "Elevation"
                    titleSize: 16
                    minGap: 5

                    onWidgetValueFromChanged: current1 = widgetValueFrom
                    onWidgetValueToChanged: current2 = widgetValueTo
                }
            }
        }
    }
}

