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
** GuiLibFontLoader.cpp
**
**        Created on: 22/02/18
**   Original Author: frederic.vulliet@somfy.com
**
*/

#include <QFontDatabase>
#include <QDebug>

#include "GuiLibFontLoader.hpp"

GuiLibFontLoader::GuiLibFontLoader(QObject *parent) :
    QObject(parent)
{
}

QString GuiLibFontLoader::name() const
{
    return m_name;
}

void GuiLibFontLoader::setName(QString name)
{
    m_name = name;
}

QString GuiLibFontLoader::source() const
{
    return m_source;
}

void GuiLibFontLoader::setSource(QString source)
{
    m_id = QFontDatabase::addApplicationFont(source);

    if (m_id < 0)
    {
        qWarning() << "could not load" << source;
        return;
    }

    QStringList loadedFontFamilies = QFontDatabase::applicationFontFamilies(m_id);
    if (loadedFontFamilies.count() > 1)
        qWarning() << "loadedFontFamilies.count() > 1 !!";

    //qDebug() << "[GuiLibFontLoader::setSource]" << "loaded" << loadedFontFamilies << "from" << source;

    if (!loadedFontFamilies.empty())
    {
        m_font = QFont(loadedFontFamilies.at(0));
        m_source = source;
    }
}

QFont GuiLibFontLoader::font() const
{
    return m_font;
}
