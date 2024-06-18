/*
** Copyright (C) 2012 Fargier Sylvain <fargier.sylvain@free.fr>
**
** This software is provided 'as-is', without any express or implied
** warranty.  In no event will the authors be held liable for any damages
** arising from the use of this software.
**
** Permission is granted to anyone to use this software for any purpose,
** including commercial applications, and to alter it and redistribute it
** freely, subject to the following restrictions:
**
** 1. The origin of this software must not be misrepresented; you must not
**    claim that you wrote the original software. If you use this software
**    in a product, an acknowledgment in the product documentation would be
**    appreciated but is not required.
** 2. Altered source versions must be plainly marked as such, and must not be
**    misrepresented as being the original software.
** 3. This notice may not be removed or altered from any source distribution.
**
** Singleton.hxx
**
**        Created on: Nov 12, 2012
**   Original Author: Sylvain Fargier <fargier.sylvain@free.fr>
**
*/

/**
 * @file Template code for Worker class
 * @details this class is not automatically included since the template must be
 * instantiated with caution on windows like systems, see :
 * http://www.codesynthesis.com/~boris/blog/2010/01/18/dll-export-cxx-templates/
 */
#ifndef SINGLETON_HXX
#include "Singleton.hpp"

template <class C>
C &Singleton<C>::instance()
{
    if (!m_instance)
    {
        SingletonMutex lock;
        if (!m_instance)
            m_instance = new C();
    }
    return *m_instance;
}

template <class C>
void Singleton<C>::destroy()
{
    SingletonMutex lock;
    if (m_instance)
    {
        delete m_instance;
        m_instance = NULL;
    }
}

template <class C>
C *Singleton<C>::m_instance = 0;

#define SINGLETON_HXX



#endif // SINGLETON_HXX
