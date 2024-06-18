import QtQuick 2.9
import QtQml 2.0

QtObject {
    id: root

    property string name
    property string lib
    property string icon
    property color color
    property real size: 0 // 0 means 'fit parent'
    property bool displayed: true

    signal actionClicked()
}
