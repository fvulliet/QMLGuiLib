
#include <QCoreApplication>
#include <QProcess>
#include <QDebug>
#include <QStringList>
#include <QTemporaryFile>
#include <iostream>

#if !defined(QML2_IMPORT_PATH)
#define QML2_IMPORT_PATH ""
#endif

#if !defined(WORKDIR)
#define WORKDIR "."
#endif

#if !defined(QMLTESTRUNNER)
#define QMLTESTRUNNER "qmltestrunner"
#endif

int main(int argc, char *argv[])
{
    QStringList args;
    for (int i = 1; i < argc; ++i)
        args << argv[i];
    argc = 1;

    QCoreApplication app(argc, argv); /* no arguments allowed */

    QProcess process;
    QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
    env.insert("QML2_IMPORT_PATH", QML2_IMPORT_PATH);
    process.setProcessEnvironment(env);
    process.setWorkingDirectory(WORKDIR);
    process.setProcessChannelMode(QProcess::ForwardedChannels);

#if defined(Q_OS_WIN)
    QTemporaryFile file;

    file.open();
    file.setTextModeEnabled(true);
    args << "-o" << QString("%1,txt").arg(file.fileName());
    process.start(QMLTESTRUNNER, args);
#else
    process.start(QMLTESTRUNNER, args);
#endif

    if (!process.waitForStarted(3000))
    {
        qWarning() << "Failed to start qmltestrunner process:"
                   << process.errorString();
        return -1;
    }
    else
    {
#if defined(Q_OS_WIN)
        while (!process.waitForFinished(500))
        {
            QByteArray data = file.readAll();
            if (!data.isEmpty())
                std::cout << qPrintable(data) << std::flush;
        }
        if (file.bytesAvailable())
            std::cout << qPrintable(file.readAll()) << std::flush;
#else
        process.waitForFinished(-1);
#endif

        return process.exitCode();
    }
}

