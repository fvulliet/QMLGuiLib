
#include <QCoreApplication>
#include <QProcess>
#include <QDebug>
#include <QStringList>
#include <QTemporaryFile>
#include <iostream>

#if !defined(QML2_IMPORT_PATH)
#define QML2_IMPORT_PATH ""
#endif

#if !defined(LD_LIBRARY_PATH)
#define LD_LIBRARY_PATH ""
#endif

#if defined(Q_OS_WIN)
#define LD_LIBRARY_PATH_VAR "PATH"
#define LD_LIBRARY_PATH_SEP ";"
#else
#define LD_LIBRARY_PATH_VAR "LD_LIBRARY_PATH"
#define LD_LIBRARY_PATH_SEP ":"
#endif

#if !defined(WORKDIR)
#define WORKDIR "."
#endif

#if !defined(QMLSCENE)
#define QMLSCENE "qmlscene"
#endif

#if !defined(QMLFILE)
#define QMLFILE ""
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

    QString libPath = env.value(LD_LIBRARY_PATH_VAR);
    libPath += LD_LIBRARY_PATH_SEP LD_LIBRARY_PATH;
    env.insert(LD_LIBRARY_PATH_VAR, libPath);

    process.setProcessEnvironment(env);
    process.setWorkingDirectory(WORKDIR);
    process.setProcessChannelMode(QProcess::ForwardedChannels);

    args << QMLFILE;
    qDebug() << "ImportPath:" << QML2_IMPORT_PATH;
    qDebug() << "LibPath:" << LD_LIBRARY_PATH;
    qDebug() << "Running" << args.front();
    process.start(QMLSCENE, args);
    if (!process.waitForFinished(-1))
    {
        qWarning() << "Failed to start qmlscene process";
        return -1;
    }
    else
        return process.exitCode();
}

