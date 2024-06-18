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
** GuiLibQmlPlugin.hpp
**
**        Created on: 04/03/2016
**   Original Author:
**
*/

#ifndef GUILIBQMLPLUGIN_HPP
#define GUILIBQMLPLUGIN_HPP

#include <QQmlExtensionPlugin>

/**
 * @brief GuiLib QML plugin class
 */
class GuiLibQmlPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "GuiLibQmlPlugin")

public:
    void registerTypes(const char *uri);
};

#endif // GUILIBQMLPLUGIN_HPP
