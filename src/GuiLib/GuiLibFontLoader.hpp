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
** GuiLibFontLoader.hpp
**
**        Created on: 22/02/18
**   Original Author: frederic.vulliet@somfy.com
**
*/
#ifndef GUILIBFONTLOADER_HPP
#define GUILIBFONTLOADER_HPP

#include <QObject>
#include <QFont>

#include "GuiLib_export.hpp"

class GUILIB_EXPORT GuiLibFontLoader : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName)
    Q_PROPERTY(QString source READ source WRITE setSource)
    Q_PROPERTY(QFont font READ font)

public:
    explicit GuiLibFontLoader(QObject *parent = nullptr);

    QString name() const;
    void setName(QString name);

    QString source() const;
    void setSource(QString source);

    QFont font() const;

signals:

private:
    QString m_name;
    QString m_source;
    int m_id;
    QFont m_font;
};

#endif // GUILIBFONTLOADER_HPP
