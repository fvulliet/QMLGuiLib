import QtQuick 2.9
import GuiLib 1.0

Item {
    id: root

    // public properties
    property string source
    property QtObject currentItem: (_currentPage === 0) ? page0.item : page1.item
    // 0: no animation; 1: fade out ; 2: slide ; 3: curved slide
    property int animationType: 1
    // 0: left ; 1: right
    property bool reversedSlide: false
    property alias loading: pageSwap.running

    // private properties
    property int _currentPage: 0

    // signals
    signal pageLoaded()

    onSourceChanged: {
        if (source.length <= 0)
            return

        pageSwap.stop()
        if (_currentPage === 0) {
            page0.z = -1
            page1.z = 0
            pageSwapIn.target = page1
            pageSwapOut.target = page0
            if (animationType === 2)
                // no fading animation on opacity, set the value directly
                page1.opacity = 1
            _currentPage = 1
            page1.setSource(source)
        } else {
            page1.z = -1
            page0.z = 0
            pageSwapIn.target = page0
            pageSwapOut.target = page1
            if (animationType === 2)
                // no fading animation on opacity, set the value directly
                page0.opacity = 1
            _currentPage = 0
            page0.setSource(source)
        }
        pageSwap.start()
    }

    // note: Loader loads a component and provides it the current context
    Loader {
        id: page0

        width: root.width; height: root.height
        x: 0; y: 0
    }

    Loader {
        id: page1

        width: root.width; height: root.height
        x: 0; y: 0
    }

    ParallelAnimation {
        id: pageSwap

        onRunningChanged: {
            if (!running) {
                if (_currentPage === 0)
                    page1.setSource("")
                else
                    page0.setSource("")
                pageLoaded()
            }
        }

        PropertyAnimation {
            id: pageSwapOut

            property: animationType === 2 ? "x" : "opacity"
            from: animationType === 2 ? 0 : 1
            to: {
                if (animationType === 2) {
                    if (!reversedSlide)
                        return -root.width
                    else
                        return root.width
                } else
                    return root.x
            }
            duration: animationType > 0 ? 250 : 10
            easing.type: animationType === 3 ? Easing.OutQuad : Easing.InQuad
        }

        PropertyAnimation {
            id: pageSwapIn

            property: animationType === 2 ? "x" : "opacity"
            from: {
                if (animationType === 2) {
                    if (!reversedSlide)
                        return root.width
                    else
                        return -root.width
                } else
                    return 0
            }
            to: animationType === 2 ? 0 : 1
            duration: animationType > 0 ? 250 : 10
            easing.type: Easing.InQuad
        }
    }
}
