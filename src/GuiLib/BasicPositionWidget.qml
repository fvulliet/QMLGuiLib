
import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property color widgetColor: Colors.skinMenuBGD
    property bool withGhost: false

    // Item's properties

    // inner component
    Column {
        readonly property int nbItems: 3

        anchors.fill: parent
        spacing:0

        Loader {
            width: parent.width; height: (parent.height - parent.spacing*(parent.nbItems-1))/parent.nbItems
            sourceComponent: button
            onStatusChanged: {
                if (status === Loader.Ready)
                    item.icon = SfyIco.Icon.remoteUp
            }
        }
        Loader {
            width: parent.width; height: (parent.height - parent.spacing*(parent.nbItems-1))/parent.nbItems
            sourceComponent: button
            onStatusChanged: {
                if (status === Loader.Ready)
                    item.icon = SfyIco.Icon.remoteMy
            }
        }
        Loader {
            width: parent.width; height: (parent.height - parent.spacing*(parent.nbItems-1))/parent.nbItems
            sourceComponent: button
            onStatusChanged: {
                if (status === Loader.Ready)
                    item.icon = SfyIco.Icon.remoteDown
            }
        }
    }

    Component {
        id: button

        Item {
            property alias icon: myIcon.icon

            states: [
                State {
                    when: mouseArea.containsMouse
                    PropertyChanges { target: myIcon; scale: 1.1 }
                }
            ]
            transitions: [
                Transition {
                    NumberAnimation { properties: "scale"
                        easing.type: Easing.InOutQuad
                    }
                }
            ]

            ParallelAnimation {
                id: clickAnim

                NumberAnimation {
                    from: 1.2; to: 1
                    target: myIcon
                    property: "scale"
                    easing.type: Easing.OutElastic
                }
                NumberAnimation {
                    from: 1; to: 2
                    target: ghost
                    property: "scale"
                    easing.type: Easing.OutQuad
                }
                SequentialAnimation {
                    NumberAnimation {
                        from: 0; to: withGhost ? 0.05 : 0
                        target: ghost
                        property: "opacity"
                        easing.type: Easing.OutQuad
                    }
                    NumberAnimation {
                        from: withGhost ? 0.05 : 0; to: 0
                        target: ghost
                        property: "opacity"
                        easing.type: Easing.OutQuad
                        duration: 1500
                    }
                }
            }

            FontIcon {
                id: myIcon

                property real scale: 1

                lib: Fonts.sfyIco
                color: widgetColor
                size: parent.height * scale
                anchors.centerIn: parent
            }

            FontIcon {
                id: ghost

                property real scale: 1

                lib: Fonts.sfyIco
                icon: myIcon.icon
                color: widgetColor
                size: parent.height * scale
                anchors.centerIn: parent
                opacity: 0
                visible: opacity > 0
            }

            MouseArea {
                id: mouseArea

                anchors.fill: parent
                hoverEnabled: true
                onClicked:  clickAnim.start()
            }
        }
    }
}
