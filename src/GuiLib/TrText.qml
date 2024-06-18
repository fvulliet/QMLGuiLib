import QtQuick 2.9
import GuiLib 1.0

Text {
    // public properties

    property string content: ""
    property string context: ""
    property string disambiguation: ""
    property int plural: 1

    text: qsTranslate(context, content, disambiguation)
          + TranslationManagement.emptyString
}
