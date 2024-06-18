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
** Copyright © (2009-2015), Somfy SAS. All rights reserved.
** All reproduction, use or distribution of this software, in whole or
** in part, by any means, without Somfy SAS prior written approval, is
** strictly forbidden.
**
** GuiLibQmlPlugin.cpp
**
**        Created on: 04/03/2016
**   Original Author:
**
*/

#include <qqml.h>

#include "GuiLibQmlPlugin.hpp"
#include "TranslationManagement.hpp"
#include "GuiLibFontLoader.hpp"

static QObject *TranslationManagementProvider(QQmlEngine *engine,
                                              QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    return TranslationManagement::instance();
}

void GuiLibQmlPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("GuiLib"));

    qmlRegisterSingletonType<TranslationManagement>(
                uri, 1, 0, "TranslationManagement",
                TranslationManagementProvider);

    qmlRegisterType<GuiLibFontLoader>(uri, 1, 0, "GuiLibFontLoader");
}
