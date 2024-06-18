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
** TranslationManagment.cpp
**
**        Created on: 04/03/2016
**   Original Author: frederic.vulliet@somfy.com
**
*/

#include <QtGui>
#include <QDebug>

#include "TranslationManagement.hpp"
#include "Singleton.hpp"
#include "Singleton.hxx"

#define LANGUAGE_PATH "langUsed"

class PubTranslationManagement: public TranslationManagement {};

TranslationManagement::TranslationManagement(QObject *parent) :
    QObject(parent),
    m_translator(parent),
    m_usedLang(LNG_ENGLISH)
{
    m_table[LNG_LAST] = "";
}

TranslationManagement *TranslationManagement::instance()
{
    return &Singleton<PubTranslationManagement>::instance();
}

void TranslationManagement::loadQMfile(TranslationManagement::LANGUAGE lang,
                                       QString path)
{
    if (lang >= LNG_LAST)
        return;

    m_table[lang] = path;
}

TranslationManagement::LANGUAGE TranslationManagement::usedLang() const
{
    return m_usedLang;
}

void TranslationManagement::setUsedLang(TranslationManagement::LANGUAGE value)
{
    if (value == m_usedLang)
        return;

    if (value >= LNG_LAST)
        return;

    // use only 1 translator at once
    if (!m_translator.isEmpty())
        qApp->removeTranslator(&m_translator);

    if (m_translator.load(m_table[value]) == true)
    {
        qApp->installTranslator(&m_translator);
        m_usedLang = value;
        emit usedLangChanged();
        emit languageChanged();
        qDebug() << "[TranslationManagement] language loaded" << m_table[value];
        return;
    }
    qCritical() << "[TranslationManagement] cannot select language" <<
                   m_table[value];
}
