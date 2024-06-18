
pragma Singleton
import QtQuick 2.9
import QtQml 2.0

QtObject {
    id: root

    property string themeName: "standard"
    property color themeMainColor
    Behavior on themeMainColor { ColorAnimation {} }
    property color themeSignalOK
    property color themeSignalKO
    property color themeSecuFuncActive
    property color themeSecuFuncInactive
    property color themeComfortFuncActive
    property color themeComfortFuncInactive
    property color themeUserFuncActive
    property color themeUserFuncInactive
    property color themeAppCtrlActive
    property color themeAppCtrlInactive
    property color themeNrjFuncActive
    property color themeNrjFuncInactive
    property color themeStatusOk
    property color themeStatusKo

    property string skinName: "bright"
    property color skinMenuBGD
    property color skinMenuTXT
    property color skinFrameBGD
    property color skinFrameFGD
    property color skinFrameTXT
    property color skinFrameSelectedTXT
    property color skinItemBGD
    property color skinItemHOV
    property color skinItemFGD
    property color skinButtonTXT
    property color skinListBGD
    property color skinListTXT
    property color skinListBgdTXT
    property color skinListFgdTXT
    property color skinWizardSeparator
    property color skinWizardTXT
    property color skinTxtInputBGD
    property color skinTxtInputTXT
    property color skinDropdownBGD
    property color skinDropdownHOV
    property color skinDropdownFGD
    property color skinFrameBgdTXT
    property color skinFrameFgdTXT
    property color skinFrameBoldTXT
    property color skinFrameBoldBgdTXT
    property color skinFrameBoldFgdTXT
    property color skinHeaderBGD
    property color skinHeaderTXT

    property var themes: ({})

    readonly property var standardTheme: {
        'themeName' : 'standard',
        'themeMainColor': '#fab800',
        'themeSignalOK': '#0b8e30',
        'themeSignalKO': '#db3c3c',
        'themeSecuFuncActive': '#fa0c49',
        'themeSecuFuncInactive': '#ff7f7f',
        'themeNrjFuncActive': '#194bfa',
        'themeNrjFuncInactive': '#7fbfff',
        'themeUserFuncActive': '#fabe19',
        'themeUserFuncInactive': '#ffd970',
        'themeAppCtrlActive': '#bd55ea',
        'themeAppCtrlInactive': '#c788e2',
        'themeComfortFuncActive': '#19fa38',
        'themeComfortFuncInactive': '#7fff7f',
        'themeStatusKo' : 'lightCoral',
        'themeStatusOk' : 'lightGreen',
        'bright': {
            'skinMenuBGD': '#404040',
            'skinMenuTXT': '#c5c6c8',
            'skinHeaderBGD': '#ffffff',
            'skinHeaderTXT': '#404040',
            'skinFrameBGD': '#f2f1f6',
            'skinFrameFGD': '#ffffff',
            'skinFrameTXT': '#404040', //666666
            'skinFrameSelectedTXT': '#f2f1f6',
            'skinItemBGD': '#f2f1f6',
            'skinItemHOV': '#c5c6c8',
            'skinItemFGD': '#404040',
            'skinButtonTXT': '#404040',
            'skinListTXT': '#404040',
            'skinListBGD': '#f2f1f6',
            'skinWizardSeparator': '#ffffff',
            'skinWizardTXT': '#8a8a8b',
            'skinFrameBoldTXT': '#404040',
            'skinTxtInputBGD': '#f2f1f6',
            'skinTxtInputTXT': '#404040',
        },
        'dark': {
            'skinMenuBGD': '#404040',
            'skinMenuTXT': '#c5c6c8',
            'skinHeaderBGD': '#f2f1f6',
            'skinHeaderTXT': '#404040',
            'skinFrameBGD': '#c5c6c8',
            'skinFrameFGD': '#404040',
            'skinFrameTXT': '#c5c6c8',
            'skinFrameSelectedTXT': '#404040',
            'skinItemBGD': '#666666',
            'skinItemHOV': '#c5c6c8',
            'skinItemFGD': '#f2f1f6',
            'skinButtonTXT': '#c5c6c8',
            'skinListTXT': '#666666',
            'skinListBGD': '#f2f1f6',
            'skinWizardSeparator': '#ffffff',
            'skinWizardTXT': '#8a8a8b',
            'skinFrameBoldTXT': '#f2f1f6',
            'skinTxtInputBGD': '#f2f1f6',
            'skinTxtInputTXT': '#666666',
        }
    }

    readonly property var standardTheme2020: {
        'themeName' : 'std2020',
        'themeMainColor': '#fab800',
        'themeSignalOK': '#08c27f',
        'themeSignalKO': '#ff510f',
        'themeSecuFuncActive': '#ff0000',
        'themeSecuFuncInactive': '#ff7f7f',
        'themeNrjFuncActive': '#007eff',
        'themeNrjFuncInactive': '#7fbfff',
        'themeUserFuncActive': '#ffb900',
        'themeUserFuncInactive': '#ffd970',
        'themeAppCtrlActive': '#bd55ea',
        'themeAppCtrlInactive': '#c788e2',
        'themeComfortFuncActive': '#008000',
        'themeComfortFuncInactive': '#7fff7f',
        'themeStatusKo' : 'lightCoral',
        'themeStatusOk' : 'lightGreen',
        'bright': {
            'skinMenuBGD': '#27384e',
            'skinMenuTXT': '#cacfd5',
            'skinHeaderBGD': '#ffffff',
            'skinHeaderTXT': '#27384e',
            'skinFrameBGD': '#f3f5f8',
            'skinFrameFGD': '#ffffff',
            'skinFrameTXT': '#666666',
            'skinFrameSelectedTXT': '#f3f5f8',
            'skinItemBGD': '#f3f5f8',
            'skinItemHOV': '#cacfd5',
            'skinItemFGD': '#666666',
            'skinButtonTXT': '#27384e',
            'skinListTXT': '#666666',
            'skinListBGD': '#f3f5f8',
            'skinWizardSeparator': '#ffffff',
            'skinWizardTXT': '#8a8a8b',
            'skinFrameBoldTXT': '#27384e',
            'skinTxtInputBGD': '#f3f5f8',
            'skinTxtInputTXT': '#666666',
        },
        'dark': {
            'skinMenuBGD': '#f3f5f8',
            'skinMenuTXT': '#27384e',
            'skinHeaderBGD': '#cacfd5',
            'skinHeaderTXT': '#f3f5f8',
            'skinFrameBGD': '#27384e',
            'skinFrameFGD': '#ffffff',
            'skinFrameTXT': '#27384e',
            'skinFrameSelectedTXT': '#f3f5f8',
            'skinItemBGD': '#666666',
            'skinItemHOV': '#27384e',
            'skinItemFGD': '#cacfd5',
            'skinButtonTXT': '#27384e',
            'skinListTXT': '#666666',
            'skinListBGD': '#cacfd5',
            'skinWizardSeparator': '#ffffff',
            'skinWizardTXT': '#8a8a8b',
            'skinFrameBoldTXT': '#cacfd5',
            'skinTxtInputBGD': '#cacfd5',
            'skinTxtInputTXT': '#666666',
        }
    }

    readonly property var somfyTheme: {
        'themeName' : 'somfy',
        'themeMainColor': '#e35200',
        'themeSignalOK': '#0b8e30',
        'themeSignalKO': '#db3c3c',
        'themeSecuFuncActive': '#ff0000',
        'themeSecuFuncInactive': '#ff7f7f',
        'themeNrjFuncActive': '#007eff',
        'themeNrjFuncInactive': '#7fbfff',
        'themeUserFuncActive': '#ffb900',
        'themeUserFuncInactive': '#ffd970',
        'themeAppCtrlActive': '#bd55ea',
        'themeAppCtrlInactive': '#c788e2',
        'themeComfortFuncActive': '#008000',
        'themeComfortFuncInactive': '#7fff7f',
        'themeStatusKo' : 'lightCoral',
        'themeStatusOk' : 'lightGreen',
        'bright': {
            'skinMenuBGD': '#001544',
            'skinMenuTXT': '#c5c6c8',
            'skinHeaderBGD': '#ffffff',
            'skinHeaderTXT': '#001544',
            'skinFrameBGD': '#a29588',
            'skinFrameFGD': '#ffffff',
            'skinFrameTXT': '#333333',
            'skinFrameSelectedTXT': '#a29588',
            'skinItemBGD': '#a29588',
            'skinItemHOV': '#c5c6c8',
            'skinItemFGD': '#333333',
            'skinButtonTXT': '#001544',
            'skinListTXT': '#333333',
            'skinListBGD': '#a29588',
            'skinWizardSeparator': '#ffffff',
            'skinWizardTXT': '#8a8a8b',
            'skinFrameBoldTXT': '#001544',
            'skinTxtInputBGD': '#a29588',
            'skinTxtInputTXT': '#333333',
        },
        'dark': {
            'skinMenuBGD': '#404040',
            'skinMenuTXT': '#c5c6c8',
            'skinHeaderBGD': '#f2f1f6',
            'skinHeaderTXT': '#404040',
            'skinFrameBGD': '#c5c6c8',
            'skinFrameFGD': '#404040',
            'skinFrameTXT': '#c5c6c8',
            'skinFrameSelectedTXT': '#404040',
            'skinItemBGD': '#666666',
            'skinItemHOV': '#c5c6c8',
            'skinItemFGD': '#f2f1f6',
            'skinButtonTXT': '#c5c6c8',
            'skinListTXT': '#666666',
            'skinListBGD': '#f2f1f6',
            'skinWizardSeparator': '#ffffff',
            'skinWizardTXT': '#8a8a8b',
            'skinFrameBoldTXT': '#f2f1f6',
            'skinTxtInputBGD': '#f2f1f6',
            'skinTxtInputTXT': '#666666',
        }
    }

    readonly property var officeTheme: {
        'themeName' : 'office',
        'themeMainColor': '#047caa',
        'themeSignalOK': '#0b8e30',
        'themeSignalKO': '#db3c3c',
        'themeSecuFuncActive': '#ff0000',
        'themeSecuFuncInactive': '#ff7f7f',
        'themeNrjFuncActive': '#00ff00',
        'themeNrjFuncInactive': '#7fff7f',
        'themeUserFuncActive': '#ffff00',
        'themeUserFuncInactive': '#fffe7f',
        'themeAppCtrlActive': '#bd55ea',
        'themeAppCtrlInactive': '#c788e2',
        'themeComfortFuncActive': '#007eff',
        'themeComfortFuncInactive': '#7fbfff',
        'themeStatusKo' : 'lightCoral',
        'themeStatusOk' : 'lightGreen',
        'bright': {
            'skinMenuBGD': '#404040',
            'skinMenuTXT': '#c5c6c8',
            'skinHeaderBGD': '#ffffff',
            'skinHeaderTXT': '#404040',
            'skinFrameBGD': '#f2f1f6',
            'skinFrameFGD': '#ffffff',
            'skinFrameTXT': '#666666',
            'skinFrameSelectedTXT': '#f2f1f6',
            'skinItemBGD': '#f2f1f6',
            'skinItemHOV': '#c5c6c8',
            'skinItemFGD': '#666666',
            'skinButtonTXT': '#404040',
            'skinListTXT': '#666666',
            'skinListBGD': '#f2f1f6',
            'skinWizardSeparator': '#ffffff',
            'skinWizardTXT': '#8a8a8b',
            'skinFrameBoldTXT': '#404040',
            'skinTxtInputBGD': '#f2f1f6',
            'skinTxtInputTXT': '#666666',
        },
        'dark': {
            'skinMenuBGD': '#404040',
            'skinMenuTXT': '#c5c6c8',
            'skinHeaderBGD': '#f2f1f6',
            'skinHeaderTXT': '#404040',
            'skinFrameBGD': '#c5c6c8',
            'skinFrameFGD': '#404040',
            'skinFrameTXT': '#c5c6c8',
            'skinFrameSelectedTXT': '#404040',
            'skinItemBGD': '#666666',
            'skinItemHOV': '#c5c6c8',
            'skinItemFGD': '#f2f1f6',
            'skinButtonTXT': '#c5c6c8',
            'skinListTXT': '#666666',
            'skinListBGD': '#f2f1f6',
            'skinWizardSeparator': '#ffffff',
            'skinWizardTXT': '#8a8a8b',
            'skinFrameBoldTXT': '#f2f1f6',
            'skinTxtInputBGD': '#f2f1f6',
            'skinTxtInputTXT': '#666666',
        }
    }

    readonly property var educationTheme: {
        'themeName' : 'education',
        'themeMainColor': '#ea7c1d',
        'themeSignalOK': '#0b8e30',
        'themeSignalKO': '#db3c3c',
        'themeSecuFuncActive': '#ff0000',
        'themeSecuFuncInactive': '#ff7f7f',
        'themeNrjFuncActive': '#00ff00',
        'themeNrjFuncInactive': '#7fff7f',
        'themeUserFuncActive': '#ffff00',
        'themeUserFuncInactive': '#fffe7f',
        'themeAppCtrlActive': '#bd55ea',
        'themeAppCtrlInactive': '#c788e2',
        'themeComfortFuncActive': '#007eff',
        'themeComfortFuncInactive': '#7fbfff',
        'themeStatusKo' : '#db004d',
        'themeStatusOk' : '#72e100',
        'bright': {
            'skinMenuBGD': '#404040',
            'skinMenuTXT': '#c5c6c8',
            'skinHeaderBGD': '#ffffff',
            'skinHeaderTXT': '#404040',
            'skinFrameBGD': '#f2f1f6',
            'skinFrameFGD': '#ffffff',
            'skinFrameTXT': '#666666',
            'skinFrameSelectedTXT': '#f2f1f6',
            'skinItemBGD': '#f2f1f6',
            'skinItemHOV': '#c5c6c8',
            'skinItemFGD': '#666666',
            'skinButtonTXT': '#404040',
            'skinListTXT': '#666666',
            'skinListBGD': '#f2f1f6',
            'skinWizardSeparator': '#ffffff',
            'skinWizardTXT': '#8a8a8b',
            'skinFrameBoldTXT': '#404040',
            'skinTxtInputBGD': '#f2f1f6',
            'skinTxtInputTXT': '#666666',
        },
        'dark': {
            'skinMenuBGD': '#404040',
            'skinMenuTXT': '#c5c6c8',
            'skinHeaderBGD': '#f2f1f6',
            'skinHeaderTXT': '#404040',
            'skinFrameBGD': '#c5c6c8',
            'skinFrameFGD': '#404040',
            'skinFrameTXT': '#c5c6c8',
            'skinFrameSelectedTXT': '#404040',
            'skinItemBGD': '#666666',
            'skinItemHOV': '#c5c6c8',
            'skinItemFGD': '#f2f1f6',
            'skinButtonTXT': '#c5c6c8',
            'skinListTXT': '#666666',
            'skinListBGD': '#f2f1f6',
            'skinWizardSeparator': '#ffffff',
            'skinWizardTXT': '#8a8a8b',
            'skinFrameBoldTXT': '#f2f1f6',
            'skinTxtInputBGD': '#f2f1f6',
            'skinTxtInputTXT': '#666666',
        }
    }

    readonly property var hospitalityTheme: {
        'themeName' : 'hospitality',
        'themeMainColor': '#44a9b9',
        'themeSignalOK': '#0b8e30',
        'themeSignalKO': '#db3c3c',
        'themeSecuFuncActive': '#ff0000',
        'themeSecuFuncInactive': '#ff7f7f',
        'themeNrjFuncActive': '#00ff00',
        'themeNrjFuncInactive': '#7fff7f',
        'themeUserFuncActive': '#ffff00',
        'themeUserFuncInactive': '#fffe7f',
        'themeAppCtrlActive': '#bd55ea',
        'themeAppCtrlInactive': '#c788e2',
        'themeComfortFuncActive': '#007eff',
        'themeComfortFuncInactive': '#7fbfff',
        'themeStatusKo' : '#db004d',
        'themeStatusOk' : '#72e100',
        'bright': {
            'skinMenuBGD': '#404040',
            'skinMenuTXT': '#c5c6c8',
            'skinHeaderBGD': '#ffffff',
            'skinHeaderTXT': '#404040',
            'skinFrameBGD': '#f2f1f6',
            'skinFrameFGD': '#ffffff',
            'skinFrameTXT': '#666666',
            'skinFrameSelectedTXT': '#f2f1f6',
            'skinItemBGD': '#f2f1f6',
            'skinItemHOV': '#c5c6c8',
            'skinItemFGD': '#666666',
            'skinButtonTXT': '#404040',
            'skinListTXT': '#666666',
            'skinListBGD': '#f2f1f6',
            'skinWizardSeparator': '#ffffff',
            'skinWizardTXT': '#8a8a8b',
            'skinFrameBoldTXT': '#404040',
            'skinTxtInputBGD': '#f2f1f6',
            'skinTxtInputTXT': '#666666',
        },
        'dark': {
            'skinMenuBGD': '#404040',
            'skinMenuTXT': '#c5c6c8',
            'skinHeaderBGD': '#f2f1f6',
            'skinHeaderTXT': '#404040',
            'skinFrameBGD': '#c5c6c8',
            'skinFrameFGD': '#404040',
            'skinFrameTXT': '#c5c6c8',
            'skinFrameSelectedTXT': '#404040',
            'skinItemBGD': '#666666',
            'skinItemHOV': '#c5c6c8',
            'skinItemFGD': '#f2f1f6',
            'skinButtonTXT': '#c5c6c8',
            'skinListTXT': '#666666',
            'skinListBGD': '#f2f1f6',
            'skinWizardSeparator': '#ffffff',
            'skinWizardTXT': '#8a8a8b',
            'skinFrameBoldTXT': '#f2f1f6',
            'skinTxtInputBGD': '#f2f1f6',
            'skinTxtInputTXT': '#666666',
        }
    }

    readonly property var healthcareTheme: {
        'themeName' : 'healthcare',
        'themeMainColor': '#9bcc58',
        'themeSignalOK': '#0b8e30',
        'themeSignalKO': '#db3c3c',
        'themeSecuFuncActive': '#ff0000',
        'themeSecuFuncInactive': '#ff7f7f',
        'themeNrjFuncActive': '#00ff00',
        'themeNrjFuncInactive': '#7fff7f',
        'themeUserFuncActive': '#ffff00',
        'themeUserFuncInactive': '#fffe7f',
        'themeAppCtrlActive': '#bd55ea',
        'themeAppCtrlInactive': '#c788e2',
        'themeComfortFuncActive': '#007eff',
        'themeComfortFuncInactive': '#7fbfff',
        'themeStatusKo' : '#db004d',
        'themeStatusOk' : '#72e100',
        'bright': {
            'skinMenuBGD': '#404040',
            'skinMenuTXT': '#c5c6c8',
            'skinHeaderBGD': '#ffffff',
            'skinHeaderTXT': '#404040',
            'skinFrameBGD': '#f2f1f6',
            'skinFrameFGD': '#ffffff',
            'skinFrameTXT': '#666666',
            'skinFrameSelectedTXT': '#f2f1f6',
            'skinItemBGD': '#f2f1f6',
            'skinItemHOV': '#c5c6c8',
            'skinItemFGD': '#666666',
            'skinButtonTXT': '#404040',
            'skinListTXT': '#666666',
            'skinListBGD': '#f2f1f6',
            'skinWizardSeparator': '#ffffff',
            'skinWizardTXT': '#8a8a8b',
            'skinFrameBoldTXT': '#404040',
            'skinTxtInputBGD': '#f2f1f6',
            'skinTxtInputTXT': '#666666',
        },
        'dark': {
            'skinMenuBGD': '#404040',
            'skinMenuTXT': '#c5c6c8',
            'skinHeaderBGD': '#f2f1f6',
            'skinHeaderTXT': '#404040',
            'skinFrameBGD': '#c5c6c8',
            'skinFrameFGD': '#404040',
            'skinFrameTXT': '#c5c6c8',
            'skinFrameSelectedTXT': '#404040',
            'skinItemBGD': '#666666',
            'skinItemHOV': '#c5c6c8',
            'skinItemFGD': '#f2f1f6',
            'skinButtonTXT': '#c5c6c8',
            'skinListTXT': '#666666',
            'skinListBGD': '#f2f1f6',
            'skinWizardSeparator': '#ffffff',
            'skinWizardTXT': '#8a8a8b',
            'skinFrameBoldTXT': '#f2f1f6',
            'skinTxtInputBGD': '#f2f1f6',
            'skinTxtInputTXT': '#666666',
        }
    }

    Component.onCompleted: {
        // fill the "themes" object
        for (var prop in root)
        {
            var theme = root[prop]
            if (theme instanceof Object && theme.themeName) {
                // theme is an object and features a "themeName" property (e.g standardTheme)
                themes[theme.themeName] = {}
                for(var i = 0; i < Object.keys(theme).length; ++i) {
                    var innerProp = Object.keys(theme)[i]
                    if (theme[innerProp] instanceof Object && theme[innerProp].skinFrameTXT) {
                        themes[theme.themeName][innerProp] = {}
                        for(var j = 0; j < Object.keys(theme[innerProp]).length; ++j) {
                            var innerProp2 = Object.keys(theme[innerProp])[j]
                            themes[theme.themeName][innerProp][innerProp2] = theme[innerProp][innerProp2]
                        }
                    }
                    else
                    themes[theme.themeName][innerProp] = theme[innerProp]
                }
            }
        }
        root.setTheme(themes.standard)
        root.setSkinName("bright")
    }

    function setTheme(theme) {
        for(var i = 0; i < Object.keys(theme).length; ++i) {
            var prop = theme[Object.keys(theme)[i]]
            if (prop instanceof Object && prop.skinFrameTXT) {
                if (Object.keys(theme)[i] !== skinName)
                    continue
                for(var j = 0; j < Object.keys(prop).length; ++j) {
                    root[Object.keys(prop)[j]] = prop[Object.keys(prop)[j]]
                }
            } else {
                root[Object.keys(theme)[i]] = prop
            }
        }
    }

    function setThemeName(name) {
        for (var i in themes) {
            if (themes[i] === themes[name]) {
                setTheme(themes[name])
            }
        }
    }

    function setSkinName(name) {
        skinName = name
        setTheme(themes[themeName]) // refresh
    }

    function fade(col, bg, factor) {
        if (!factor)
            factor = 1.6
        if (Qt.colorEqual(Qt.darker(bg, 64.0), "#010101"))
            return Qt.darker(col, factor)
        else
            return Qt.lighter(col, factor)
    }

    function disabled(col) {
        if (skinName === "bright")
            return Qt.lighter(col, 1.75)
        else
            return Qt.darker(col, 1.75)
    }

    function active(col) {
        return col
    }

    function inactive(col) {
        return Qt.lighter(col, 1.5)
    }

    function getStr(color) {
        return color.toString()
    }
}
