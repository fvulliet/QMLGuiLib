#include <QApplication>
#include <QQuickView>

#include "GuiLib/GuiLib.hpp"

#if defined(FIRMWARE_CHECK)
#include "FirmwareTools.hpp"
#endif

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQuickView view;
    GuiLibQml::load(view.engine());
    view.setSource(QUrl("qrc:///GuiLibDemo.qml"));
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.show();

    #if defined(FIRMWARE_CHECK)
    FirmwareTools::check();
    #endif

    return app.exec();
}
