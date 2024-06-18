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
** TranslationManagment.hpp
**
**        Created on: 05.02.2016
**   Original Author: Johann Hägele <Johann.Haegele@somfy.com>
**
*/
#ifndef TRANSLATIONMANAGMENT_HPP
#define TRANSLATIONMANAGMENT_HPP

#include <QObject>
#include <QTranslator>
#include <QHash>
#include <QString>

#include "GuiLib_export.hpp"

class GUILIB_EXPORT TranslationManagement : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString emptyString READ getEmptyString NOTIFY languageChanged)
    Q_PROPERTY(LANGUAGE usedLang READ usedLang WRITE setUsedLang
               NOTIFY usedLangChanged)

public:
    enum LANGUAGE
    {
        LNG_ENGLISH = 0,
        LNG_GERMAN,
        LNG_FRENCH,
        LNG_LAST

    };
    Q_ENUMS (LANGUAGE)

    static TranslationManagement *instance();
    explicit TranslationManagement(QObject *parent = nullptr);

    Q_INVOKABLE void loadQMfile(LANGUAGE lang, QString path);

    QString getEmptyString() {
        return "";
    }

    LANGUAGE usedLang() const;
    void setUsedLang(LANGUAGE value);

signals:
    void languageChanged();
    void usedLangChanged();

private:
    QTranslator m_translator;
    LANGUAGE m_usedLang;
    QHash<LANGUAGE,QString> m_table;
};

#endif // TRANSLATIONMANAGMENT_HPP
