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
** Singleton.hpp
**
**        Created on: Nov 12, 2012
**   Original Author: Sylvain Fargier <fargier.sylvain@free.fr>
**
*/

#ifndef __SINGLETON_HH__
#define __SINGLETON_HH__

#include <QMutex>

/**
 * @brief singleton creation mutex.
 *
 */
class SingletonMutex
{
public:
    SingletonMutex();
    ~SingletonMutex();

protected:
    static QRecursiveMutex m_lock;
};

template <class C>
class Singleton
{
public:
    static C &instance();

    static void destroy();

protected:
    static C *m_instance;
};

#endif

