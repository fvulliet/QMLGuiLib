import QtQuick 2.9
import GuiLib 1.0

pragma Singleton

QtObject {
    // public properties
    property string sfyFont: somfySansRegular

    property alias somfySansRegular: somfySansRegularLoader.name
    property alias somfySansBold: somfySansBoldLoader.name
    property alias somfySansItalic: somfySansItalicLoader.name
    property alias fontAwesome: fontAwesomeLoader.name
    property alias faBrands: fontAwesomeBrandsLoader.name
    property alias faRegular: fontAwesomeRegularLoader.name
    property alias faSolid: fontAwesomeSolidLoader.name
    property alias googleMaterial: googleMaterialLoader.name
    property alias sfyIco: sfyIcoLoader.name
    property alias sfyFontDinReg: sfyFontDinRegLoader.name
    property alias sfyFontNotoSansDisplayReg: sfyFontNotoSansDisplayRegLoader.name
    property alias sfyFontNanumGothicReg: sfyFontNanumGothicRegLoader.name

    // SomfySans
    property GuiLibFontLoader somfySansRegularLoader: GuiLibFontLoader {
        id: somfySansRegularLoader

        name: "SfySansRegular"
        source: ":/qml/GuiLib/fonts/SomfySans-Regular.ttf"
    }

    property GuiLibFontLoader somfySansBoldLoader: GuiLibFontLoader {
        id: somfySansBoldLoader

        name: "SfySansBold"
        source: ":/qml/GuiLib/fonts/SomfySans-Bold.ttf"
    }

    property GuiLibFontLoader somfySansItalicLoader: GuiLibFontLoader {
        id: somfySansItalicLoader

        name: "SfySansItalic"
        source: ":/qml/GuiLib/fonts/SomfySans-Italic.ttf"
    }

    // FontAwesome
    property GuiLibFontLoader fontAwesomeLoader: GuiLibFontLoader {
        id: fontAwesomeLoader

        name: "FontAwesome"
        source: ":/qml/GuiLib/fonts/fontawesome-webfont.ttf"
    }

    property GuiLibFontLoader fontAwesomeBrandsLoader: GuiLibFontLoader {
        id: fontAwesomeBrandsLoader

        name: "Font Awesome 5 Brands"
        source: ":/qml/GuiLib/fonts/fa-brands-400.otf"
    }

    property GuiLibFontLoader fontAwesomeRegularLoader: GuiLibFontLoader {
        id: fontAwesomeRegularLoader

        name: "Font Awesome 5 Free"
        source: ":/qml/GuiLib/fonts/fa-regular-400.otf"
    }

    property GuiLibFontLoader fontAwesomeSolidLoader: GuiLibFontLoader {
        id: fontAwesomeSolidLoader

        name: "Font Awesome 5 Free Solid"
        source: ":/qml/GuiLib/fonts/fa-solid-900.otf"
    }

    property GuiLibFontLoader googleMaterialLoader: GuiLibFontLoader {
        id: googleMaterialLoader

        name: "Material-Design-Iconic-Font"
        source: ":/qml/GuiLib/fonts/Material-Design-Iconic-Font.ttf"
    }

    // SfyIco
    property GuiLibFontLoader sfyIcoLoader: GuiLibFontLoader {
        id: sfyIcoLoader

        name: "SfyIco"
        source: ":/qml/GuiLib/fonts/SfyIco.ttf"
    }

    // Din
    property GuiLibFontLoader sfyFontDinRegLoader: GuiLibFontLoader {
        id: sfyFontDinRegLoader

        name: "PF DinText Pro"
        source: ":/qml/GuiLib/fonts/Parachute - PFDinTextPro-Regular.otf"
    }

    property GuiLibFontLoader sfyFontDinBoldLoader: GuiLibFontLoader {
        id: sfyFontDinBoldLoader

        name: "PF DinText Pro"
        source: ":/qml/GuiLib/fonts/Parachute - PFDinTextPro-Bold.otf"
    }

    property GuiLibFontLoader sfyFontNotoSansDisplayRegLoader: GuiLibFontLoader {
        id: sfyFontNotoSansDisplayRegLoader

        name: "Noto Sans Display"
        source: ":/qml/GuiLib/fonts/NotoSansDisplay-Regular.ttf"
    }

    property GuiLibFontLoader sfyFontNanumGothicRegLoader: GuiLibFontLoader {
        id: sfyFontNanumGothicRegLoader

        name: "Nanum Gothic"
        source: ":/qml/GuiLib/fonts/NanumGothic.ttf"
    }
}

