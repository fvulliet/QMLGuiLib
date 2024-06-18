
#include <QProcess>

#include "FirmwareTools.hpp"

void FirmwareTools::check()
{
    QProcess *fwcheck = new QProcess;
    QObject::connect(fwcheck, SIGNAL(error(QProcess::ProcessError)),
            fwcheck, SLOT(deleteLater()));
    QObject::connect(fwcheck, SIGNAL(finished(int, QProcess::ExitStatus)),
            fwcheck, SLOT(deleteLater()));
    fwcheck->setProcessChannelMode(QProcess::ForwardedChannels);
    fwcheck->start("/usr/sbin/animeo-fwcheck");
}
