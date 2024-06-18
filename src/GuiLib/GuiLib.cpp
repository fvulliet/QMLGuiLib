/*
** This document and/or file is SOMFY's property. All information it
** contains is strictly confidential. This document and/or file shall
** not be used, reproduced or passed on in any way, in full or in part
** without SOMFY's prior written approval. All rights reserved.
** Ce document et/ou fichier est la propritye SOMFY. Les informations
** quil contient sont strictement confidentielles. Toute reproduction,
** utilisation, transmission de ce document et/ou fichier, partielle ou
** intégrale, non autorisée préalablement par SOMFY par écrit est
** interdite. Tous droits réservés.
** 
** Copyright © (2009-2012), Somfy SAS. All rights reserved.
** All reproduction, use or distribution of this software, in whole or
** in part, by any means, without Somfy SAS prior written approval, is
** strictly forbidden.
**
** GuiLib.cpp
**
**        Created on: Jun 08, 2015
**   Original Author: Sylvain Fargier <sylvain.fargier@somfy.com>
**
*/

#include <QQmlEngine>
#include <QGuiApplication>
#include <QFile>
#include <QDebug>

#include "config.h"

#include "GuiLib.hpp"

#define QML_MODULE "GuiLib"
#if defined(Q_OS_WIN)
#define PLUGINFILE "guilibplugin" LIBEXT
#else
#define PLUGINFILE "libguilibplugin" LIBEXT
#endif

static bool initPluginPath(const QStringList &paths, QQmlEngine *engine)
{
    foreach (const QString &path, paths)
    {
        if (QFile::exists(path + ("/" PLUGINFILE)))
        {
            if (!engine->pluginPathList().contains(path))
                engine->addPluginPath(path);
            return true;
        }
    }
    return false;
}

bool GuiLibQml::load(QQmlEngine *engine)
{
    QStringList pluginPaths;
    pluginPaths << (TOP_BUILDDIR "/src/" QML_MODULE)
                << (TOP_BUILDDIR "/src/");
    pluginPaths << qApp->applicationDirPath(); // tmp workaround for qml plugins on android

    if (QString(LIBDIR).startsWith('/'))
        pluginPaths << qgetenv("SYSROOT") + (LIBDIR "/qml/" QML_MODULE);
    else
        pluginPaths << (qApp->applicationDirPath() + "/../" LIBDIR "/qml/" QML_MODULE)
                    << (qgetenv("SYSROOT") + ("/" PREFIX "/" LIBDIR "/qml/" QML_MODULE));

    if (!engine)
        qWarning("[GuiLibQml]: can't initialize module on a null engine");
    else if (!QFile::exists(":/qml/GuiLib/qmldir"))
        qWarning("[GuiLibQml]: resources not available");
    else if (!initPluginPath(pluginPaths, engine)) {
        qWarning("[GuiLibQml]: failed to find GuiLib plugin");
    }
    else
    {
        if (!engine->importPathList().contains("qrc:/qml"))
            engine->addImportPath("qrc:/qml");
        return true;
    }
    return false;
}



