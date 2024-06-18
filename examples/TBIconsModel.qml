import QtQuick 2.9
import GuiLib 1.0


Item {
    property ListModel firstMenu: ListModel {
        ListElement { iconName: "main"; iconLib: "SfyIco"; iconId: "\ue640"; valid: true }
        ListElement { iconName: "main"; iconLib: "FontAwesome"; iconId: "\uf1ad"; valid: false }
        ListElement { iconName: "main"; iconLib: "FontAwesome"; iconId: "\uf0f7"; valid: false }
        ListElement { iconName: "guided"; iconLib: "SfyIco"; iconId: "\ue642"; valid: true }
    }

    property ListModel wizard: ListModel {
        ListElement { iconName: "info"; iconLib: "SfyIco"; iconId: "\ue634"; valid: true }
        ListElement { iconName: "info"; iconLib: "SfyIco"; iconId: "\ue633"; valid: true }
    }

    property ListModel mainMenu: ListModel {
        ListElement { iconName: "home"; iconLib: "FontAwesome"; iconId: "\uf015"; valid: true }
        ListElement { iconName: "dashboard"; iconLib: "FontAwesome"; iconId: "\uf0e4"; valid: false }
        ListElement { iconName: "control"; iconLib: "FontAwesome"; iconId: "\uf0d0"; valid: false }
        ListElement { iconName: "control"; iconLib: "FontAwesome"; iconId: "\uf255"; valid: false }
        ListElement { iconName: "control"; iconLib: "SfyIco"; iconId: "\ue6ac"; valid: false }
        ListElement { iconName: "control"; iconLib: "SfyIco"; iconId: "\ue6ad"; valid: false }
        ListElement { iconName: "control"; iconLib: "SfyIco"; iconId: "\ue6ae"; valid: false }
        ListElement { iconName: "control"; iconLib: "SfyIco"; iconId: "\ue6af"; valid: false }
        ListElement { iconName: "control"; iconLib: "SfyIco"; iconId: "\ue6b0"; valid: false }
        ListElement { iconName: "control"; iconLib: "SfyIco"; iconId: "\ue6b1"; valid: true }
        ListElement { iconName: "control"; iconLib: "SfyIco"; iconId: "\ue6b2"; valid: false }
        ListElement { iconName: "sensors"; iconLib: "FontAwesome"; iconId: "\uf1c0"; valid: false }
        ListElement { iconName: "sensors"; iconLib: "SfyIco"; iconId: "\ue632"; valid: true }
        ListElement { iconName: "sensors"; iconLib: "SfyIco"; iconId: "\ue6c5"; valid: false }
        ListElement { iconName: "sensors"; iconLib: "SfyIco"; iconId: "\ue6c6"; valid: false }
        ListElement { iconName: "sensors"; iconLib: "SfyIco"; iconId: "\ue6c7"; valid: false }
        ListElement { iconName: "log"; iconLib: "FontAwesome"; iconId: "\uf201"; valid: true }
        ListElement { iconName: "settings"; iconLib: "FontAwesome"; iconId: "\uf013"; valid: true }
        ListElement { iconName: "settings"; iconLib: "FontAwesome"; iconId: "\uf1de"; valid: false }
    }

    property ListModel control: ListModel {
        ListElement { iconName: "lock"; iconLib: "SfyIco"; iconId: "\ue637"; valid: true }
        ListElement { iconName: "sun"; iconLib: "SfyIco"; iconId: "\ue61e"; valid: true }
        ListElement { iconName: "impulseOff"; iconLib: "SfyIco"; iconId: "\ue6c8"; valid: false }
        ListElement { iconName: "impulseOn"; iconLib: "SfyIco"; iconId: "\ue6c9"; valid: false }
    }

    property ListModel log: ListModel {
        ListElement { iconName: "event"; iconLib: "SfyIco"; iconId: "\ue636"; valid: true }
        ListElement { iconName: "sensor"; iconLib: "SfyIco"; iconId: "\ue632"; valid: true }
        ListElement { iconName: "error"; iconLib: "SfyIco"; iconId: "\ue649"; valid: true }
        ListElement { iconName: "nav L"; iconLib: "FontAwesome"; iconId: "\uf053"; valid: true }
        ListElement { iconName: "nav R"; iconLib: "FontAwesome"; iconId: "\uf054"; valid: true }
        ListElement { iconName: "trash"; iconLib: "FontAwesome"; iconId: "\uf1f8"; valid: true }
        ListElement { iconName: "trash"; iconLib: "FontAwesome"; iconId: "\uf014"; valid: false }
        ListElement { iconName: "sun"; iconLib: "SfyIco"; iconId: "\ue61e"; valid: false }
        ListElement { iconName: "sun"; iconLib: "SfyIco"; iconId: "\ue679"; valid: true }
        ListElement { iconName: "wind"; iconLib: "SfyIco"; iconId: "\ue646"; valid: true }
        ListElement { iconName: "winddir"; iconLib: "SfyIco"; iconId: "\ue671"; valid: true }
        ListElement { iconName: "temp"; iconLib: "SfyIco"; iconId: "\ue62b"; valid: true }
        ListElement { iconName: "rain"; iconLib: "SfyIco"; iconId: "\ue635"; valid: true }
    }

    property ListModel settingsData: ListModel {
        ListElement { iconName: "security"; iconLib: "SfyIco"; iconId: "\ue631"; valid: true }
        ListElement { iconName: "comfort"; iconLib: "SfyIco"; iconId: "\ue672"; valid: true }
        ListElement { iconName: "comfort"; iconLib: "SfyIco"; iconId: "\ue673"; valid: false }
        ListElement { iconName: "sensors"; iconLib: "SfyIco"; iconId: "\ue632"; valid: true }
        ListElement { iconName: "options"; iconLib: "SfyIco"; iconId: "\ue62d"; valid: true }
        ListElement { iconName: "options"; iconLib: "FontAwesome"; iconId: "\uf1de"; valid: false }
    }

    property ListModel security: ListModel {
        ListElement { iconName: "alarm"; iconLib: "SfyIco"; iconId: "\ue638"; valid: false }
        ListElement { iconName: "alarm"; iconLib: "SfyIco"; iconId: "\ue676"; valid: false }
        ListElement { iconName: "alarm"; iconLib: "FontAwesome"; iconId: "\uf0f3"; valid: false }
        ListElement { iconName: "alarm"; iconLib: "FontAwesome"; iconId: "\uf0a2"; valid: true }
        ListElement { iconName: "rain/snow"; iconLib: "SfyIco"; iconId: "\ue63e"; valid: true }
        ListElement { iconName: "rain/snow"; iconLib: "SfyIco"; iconId: "\ue674"; valid: false }
        ListElement { iconName: "rain/snow"; iconLib: "SfyIco"; iconId: "\ue675"; valid: false }
        ListElement { iconName: "frost/ice"; iconLib: "SfyIco"; iconId: "\ue625"; valid: false }
        ListElement { iconName: "frost/ice"; iconLib: "SfyIco"; iconId: "\ue65f"; valid: false }
        ListElement { iconName: "frost/ice"; iconLib: "SfyIco"; iconId: "\ue660"; valid: false }
        ListElement { iconName: "frost/ice"; iconLib: "SfyIco"; iconId: "\ue661"; valid: false }
        ListElement { iconName: "frost/ice"; iconLib: "SfyIco"; iconId: "\ue662"; valid: true }
        ListElement { iconName: "frost/ice"; iconLib: "SfyIco"; iconId: "\ue65e"; valid: false }
        ListElement { iconName: "wind"; iconLib: "SfyIco"; iconId: "\ue646"; valid: true }
        ListElement { iconName: "lock timer"; iconLib: "SfyIco"; iconId: "\ue648"; valid: false }
        ListElement { iconName: "lock timer"; iconLib: "SfyIco"; iconId: "\ue678"; valid: false }
        ListElement { iconName: "lock timer"; iconLib: "SfyIco"; iconId: "\ue6a5"; valid: true }
        ListElement { iconName: "lock timer"; iconLib: "SfyIco"; iconId: "\ue6a6"; valid: false }
    }

    property ListModel comfort: ListModel {
        Component.onCompleted: {
            append({ iconName: "timer", iconLib: Fonts.sfyIco, iconId: "\ue641", valid: false });
            append({ iconName: "timer", iconLib: Fonts.faSolid, iconId: "\uf017", valid: true });
            append({ iconName: "sun", iconLib: Fonts.sfyIco, iconId: "\ue61e", valid: false });
            append({ iconName: "sun", iconLib: Fonts.sfyIco, iconId: "\ue679", valid: true });
        }
    }

    property ListModel sensors: ListModel {
        ListElement { iconName: "osb"; iconLib: "SfyIco"; iconId: "\ue653"; valid: false }
        ListElement { iconName: "osb"; iconLib: "SfyIco"; iconId: "\ue655"; valid: true }
        ListElement { iconName: "osb"; iconLib: "SfyIco"; iconId: "\ue657"; valid: false }
        ListElement { iconName: "osb"; iconLib: "SfyIco"; iconId: "\ue65b"; valid: false }
        ListElement { iconName: "isb"; iconLib: "SfyIco"; iconId: "\ue652"; valid: false }
        ListElement { iconName: "isb"; iconLib: "SfyIco"; iconId: "\ue656"; valid: true }
        ListElement { iconName: "isb"; iconLib: "SfyIco"; iconId: "\ue658"; valid: false }
        ListElement { iconName: "isb"; iconLib: "SfyIco"; iconId: "\ue65a"; valid: false }
    }

    property ListModel options: ListModel {
        ListElement { iconName: "system settings"; iconLib: "SfyIco"; iconId: "\ue63b"; valid: false }
        ListElement { iconName: "system settings"; iconLib: "FontAwesome"; iconId: "\uf085"; valid: true }
        ListElement { iconName: "moco settings"; iconLib: "FontAwesome"; iconId: "\uf0a0"; valid: false }
        ListElement { iconName: "moco settings"; iconLib: "SfyIco"; iconId: "\ue66f"; valid: false }
        ListElement { iconName: "moco settings"; iconLib: "SfyIco"; iconId: "\ue66e"; valid: true }
        ListElement { iconName: "basic settings"; iconLib: "SfyIco"; iconId: "\ue62d"; valid: true }
        ListElement { iconName: "load save"; iconLib: "SfyIco"; iconId: "\ue62c"; valid: false }
        ListElement { iconName: "load save"; iconLib: "SfyIco"; iconId: "\ue67a"; valid: true }
        ListElement { iconName: "load save"; iconLib: "FontAwesome"; iconId: "\uf019"; valid: false }
        ListElement { iconName: "update moco"; iconLib: "SfyIco"; iconId: "\ue63d"; valid: false }
        ListElement { iconName: "update moco"; iconLib: "FontAwesome"; iconId: "\uf021"; valid: true }
        ListElement { iconName: "guided"; iconLib: "SfyIco"; iconId: "\ue642"; valid: true }
    }

    property ListModel systemSettings: ListModel {
        ListElement { iconName: "location"; iconLib: "SfyIco"; iconId: "\ue613"; valid: false }
        ListElement { iconName: "location"; iconLib: "FontAwesome"; iconId: "\uf041"; valid: true }
        ListElement { iconName: "zones number"; iconLib: "SfyIco"; iconId: "\ue611"; valid: false }
        ListElement { iconName: "zones number"; iconLib: "FontAwesome"; iconId: "\uf009"; valid: true }
        ListElement { iconName: "products"; iconLib: "SfyIco"; iconId: "\ue68d"; valid: true }
        ListElement { iconName: "products"; iconLib: "SfyIco"; iconId: "\ue612"; valid: false }
        ListElement { iconName: "std values"; iconLib: "FontAwesome"; iconId: "\uf1de"; valid: true }
        ListElement { iconName: "std values"; iconLib: "SfyIco"; iconId: "\ue616"; valid: false }
        ListElement { iconName: "reset"; iconLib: "FontAwesome"; iconId: "\uf0e2"; valid: true }
        ListElement { iconName: "reset"; iconLib: "SfyIco"; iconId: "\ue610"; valid: false }
        ListElement { iconName: "reset to auto"; iconLib: "FontAwesome"; iconId: "\uf1da"; valid: true }
    }

    property ListModel mocoSettings: ListModel {
        ListElement { iconName: "test zones"; iconLib: "SfyIco"; iconId: "\ue602"; valid: true }
        ListElement { iconName: "program zones"; iconLib: "SfyIco"; iconId: "\ue611"; valid: true }
        ListElement { iconName: "run/tilt"; iconLib: "FontAwesome"; iconId: "\uf251"; valid: false }
        ListElement { iconName: "run/tilt"; iconLib: "FontAwesome"; iconId: "\uf253"; valid: false }
        ListElement { iconName: "run/tilt"; iconLib: "FontAwesome"; iconId: "\uf252"; valid: true }
        ListElement { iconName: "run/tilt"; iconLib: "FontAwesome"; iconId: "\uf254"; valid: false }
        ListElement { iconName: "switches"; iconLib: "SfyIco"; iconId: "\ue66c"; valid: false }
        ListElement { iconName: "switches"; iconLib: "SfyIco"; iconId: "\ue617"; valid: true }
        ListElement { iconName: "switches"; iconLib: "FontAwesome"; iconId: "\uf1e0"; valid: false }
        ListElement { iconName: "switches"; iconLib: "FontAwesome"; iconId: "\uf074"; valid: false }
        ListElement { iconName: "my"; iconLib: "SfyIco"; iconId: "\ue600"; valid: true }
    }

    property ListModel basicSettings: ListModel {
        ListElement { iconName: "date/time"; iconLib: "SfyIco"; iconId: "\ue645"; valid: true }
        ListElement { iconName: "language"; iconLib: "SfyIco"; iconId: "\ue614"; valid: true }
        ListElement { iconName: "language"; iconLib: "FontAwesome"; iconId: "\uf0ac"; valid: false }
        ListElement { iconName: "theme"; iconLib: "FontAwesome"; iconId: "\uf043"; valid: true }
        ListElement { iconName: "theme"; iconLib: "FontAwesome"; iconId: "\uf06e"; valid: false }
        ListElement { iconName: "touch"; iconLib: "SfyIco"; iconId: "\ue601"; valid: true }
        ListElement { iconName: "demo"; iconLib: "SfyIco"; iconId: "\ue615"; valid: false }
        ListElement { iconName: "demo"; iconLib: "FontAwesome"; iconId: "\uf152"; valid: true }
        ListElement { iconName: "password"; iconLib: "SfyIco"; iconId: "\ue648"; valid: false }
        ListElement { iconName: "password"; iconLib: "SfyIco"; iconId: "\ue644"; valid: false }
        ListElement { iconName: "password"; iconLib: "FontAwesome"; iconId: "\uf084"; valid: true }
        ListElement { iconName: "network"; iconLib: "SfyIco"; iconId: "\ue617"; valid: false }
        ListElement { iconName: "network"; iconLib: "FontAwesome"; iconId: "\uf0e8"; valid: true }
    }

    property ListModel products: ListModel {
        ListElement { iconName: "IVB 3D"; iconLib: "SfyIco"; iconId: "\ue67b"; valid: false }
        ListElement { iconName: "EVB 3D"; iconLib: "SfyIco"; iconId: "\ue67c"; valid: false }
        ListElement { iconName: "RollerShutter 3D"; iconLib: "SfyIco"; iconId: "\ue67d"; valid: false }
        ListElement { iconName: "RollerBlind 3D"; iconLib: "SfyIco"; iconId: "\ue67e"; valid: false }
        ListElement { iconName: "ExtScreen 3D"; iconLib: "SfyIco"; iconId: "\ue67f"; valid: false }
        ListElement { iconName: "Curtain 3D"; iconLib: "SfyIco"; iconId: "\ue680"; valid: false }
        ListElement { iconName: "IVB"; iconLib: "SfyIco"; iconId: "\ue681"; valid: false }
        ListElement { iconName: "EVB"; iconLib: "SfyIco"; iconId: "\ue682"; valid: false }
        ListElement { iconName: "EVB2"; iconLib: "SfyIco"; iconId: "\ue6b3"; valid: false }
        ListElement { iconName: "EVB3"; iconLib: "SfyIco"; iconId: "\ue6b4"; valid: false }
        ListElement { iconName: "RollerShutter"; iconLib: "SfyIco"; iconId: "\ue683"; valid: false }
        ListElement { iconName: "RollerBlind"; iconLib: "SfyIco"; iconId: "\ue684"; valid: false }
        ListElement { iconName: "ExtScreen"; iconLib: "SfyIco"; iconId: "\ue685"; valid: false }
        ListElement { iconName: "Curtain"; iconLib: "SfyIco"; iconId: "\ue686"; valid: false }
        ListElement { iconName: "EVB"; iconLib: "SfyIco"; iconId: "\ue687"; valid: false }
        ListElement { iconName: "Frame"; iconLib: "SfyIco"; iconId: "\ue688"; valid: false }
        ListElement { iconName: "RollerShutter"; iconLib: "SfyIco"; iconId: "\ue689"; valid: true }
        ListElement { iconName: "RollerBlind"; iconLib: "SfyIco"; iconId: "\ue68a"; valid: false }
        ListElement { iconName: "ExtScreen"; iconLib: "SfyIco"; iconId: "\ue68b"; valid: true }
        ListElement { iconName: "Curtain"; iconLib: "SfyIco"; iconId: "\ue68c"; valid: true }
        ListElement { iconName: "VB"; iconLib: "SfyIco"; iconId: "\ue68d"; valid: true }
        ListElement { iconName: "Louver"; iconLib: "SfyIco"; iconId: "\ue68e"; valid: true }
        ListElement { iconName: "Window"; iconLib: "SfyIco"; iconId: "\ue68f"; valid: false }
        ListElement { iconName: "Window"; iconLib: "SfyIco"; iconId: "\ue6a2"; valid: false }
        ListElement { iconName: "Window"; iconLib: "SfyIco"; iconId: "\ue6a7"; valid: true }
        ListElement { iconName: "Window"; iconLib: "SfyIco"; iconId: "\ue6a8"; valid: false }
        ListElement { iconName: "Window"; iconLib: "SfyIco"; iconId: "\ue6ab"; valid: false }
        ListElement { iconName: "Vertical"; iconLib: "SfyIco"; iconId: "\ue690"; valid: true }
        ListElement { iconName: "Markisolette"; iconLib: "SfyIco"; iconId: "\ue691"; valid: true }
        ListElement { iconName: "Awning"; iconLib: "SfyIco"; iconId: "\ue692"; valid: false }
        ListElement { iconName: "Awning"; iconLib: "SfyIco"; iconId: "\ue693"; valid: true }
        ListElement { iconName: "Plisse"; iconLib: "SfyIco"; iconId: "\ue694"; valid: true }
        ListElement { iconName: "Frame 3D"; iconLib: "SfyIco"; iconId: "\ue695"; valid: false }
        ListElement { iconName: "RollerShutter 3D"; iconLib: "SfyIco"; iconId: "\ue696"; valid: false }
        ListElement { iconName: "RollerBlind 3D"; iconLib: "SfyIco"; iconId: "\ue697"; valid: false }
        ListElement { iconName: "ExtScreen 3D"; iconLib: "SfyIco"; iconId: "\ue698"; valid: false }
        ListElement { iconName: "Curtain 3D"; iconLib: "SfyIco"; iconId: "\ue699"; valid: false }
        ListElement { iconName: "VB 3D"; iconLib: "SfyIco"; iconId: "\ue69a"; valid: false }
        ListElement { iconName: "Louver 3D"; iconLib: "SfyIco"; iconId: "\ue69b"; valid: false }
        ListElement { iconName: "Window 3D"; iconLib: "SfyIco"; iconId: "\ue69c"; valid: false }
        ListElement { iconName: "Window 3D"; iconLib: "SfyIco"; iconId: "\ue6a9"; valid: false }
        ListElement { iconName: "Window 3D"; iconLib: "SfyIco"; iconId: "\ue6aa"; valid: false }
        ListElement { iconName: "Window 3D"; iconLib: "SfyIco"; iconId: "\ue6a3"; valid: false }
        ListElement { iconName: "Vertical 3D"; iconLib: "SfyIco"; iconId: "\ue69d"; valid: false }
        ListElement { iconName: "Markisolette 3D"; iconLib: "SfyIco"; iconId: "\ue69e"; valid: false }
        ListElement { iconName: "Awning 3D"; iconLib: "SfyIco"; iconId: "\ue69f"; valid: false }
        ListElement { iconName: "Awning 3D"; iconLib: "SfyIco"; iconId: "\ue6a0"; valid: false }
        ListElement { iconName: "Plisse 3D"; iconLib: "SfyIco"; iconId: "\ue6a1"; valid: false }
    }

    property ListModel productsCom: ListModel {
        ListElement { iconName: "Awning"; iconLib: "SfyIco"; iconId: "\ue6b7"; valid: false }
        ListElement { iconName: "Awning2"; iconLib: "SfyIco"; iconId: "\ue6c3"; valid: false }
        ListElement { iconName: "Curtain"; iconLib: "SfyIco"; iconId: "\ue6b8"; valid: false }
        ListElement { iconName: "Ext. Screen"; iconLib: "SfyIco"; iconId: "\ue6b9"; valid: false }
        ListElement { iconName: "Louver"; iconLib: "SfyIco"; iconId: "\ue6ba"; valid: false }
        ListElement { iconName: "Louver2"; iconLib: "SfyIco"; iconId: "\ue6c2"; valid: false }
        ListElement { iconName: "Markisolette"; iconLib: "SfyIco"; iconId: "\ue6bb"; valid: false }
        ListElement { iconName: "Plisse"; iconLib: "SfyIco"; iconId: "\ue6bc"; valid: false }
        ListElement { iconName: "VB"; iconLib: "SfyIco"; iconId: "\ue6bd"; valid: false }
        ListElement { iconName: "Vert. Blind"; iconLib: "SfyIco"; iconId: "\ue6be"; valid: false }
        ListElement { iconName: "Frame"; iconLib: "SfyIco"; iconId: "\ue6bf"; valid: false }
        ListElement { iconName: "Roller Shutter"; iconLib: "SfyIco"; iconId: "\ue6c0"; valid: false }
        ListElement { iconName: "Window"; iconLib: "SfyIco"; iconId: "\ue6c1"; valid: false }        
    }

    property ListModel energy: ListModel {
        ListElement { iconName: "Energy"; iconLib: "SfyIco"; iconId: "\ue6d2"; valid: false }
        ListElement { iconName: "Energy"; iconLib: "SfyIco"; iconId: "\ue6d3"; valid: false }
        ListElement { iconName: "Energy"; iconLib: "SfyIco"; iconId: "\ue6d4"; valid: false }
        ListElement { iconName: "Energy"; iconLib: "SfyIco"; iconId: "\ue6d5"; valid: true }
        ListElement { iconName: "Mode"; iconLib: "SfyIco"; iconId: "\ue6d7"; valid: false }
        ListElement { iconName: "Mode"; iconLib: "SfyIco"; iconId: "\ue6d8"; valid: false }
        ListElement { iconName: "Mode"; iconLib: "SfyIco"; iconId: "\ue6d9"; valid: false }
        ListElement { iconName: "Scheduler"; iconLib: "SfyIco"; iconId: "\ue6da"; valid: true }
        ListElement { iconName: "BlockHeat"; iconLib: "SfyIco"; iconId: "\ue6de"; valid: true }
        ListElement { iconName: "Cooling"; iconLib: "SfyIco"; iconId: "\ue6df"; valid: true }
        ListElement { iconName: "SolarHeating"; iconLib: "SfyIco"; iconId: "\ue6e1"; valid: true }
        ListElement { iconName: "MaintainHeat"; iconLib: "SfyIco"; iconId: "\ue6e3"; valid: true }
    }
}
