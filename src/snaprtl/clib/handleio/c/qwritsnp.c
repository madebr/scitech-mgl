/****************************************************************************
*
*                            Open Watcom Project
*
*    Portions Copyright (c) 1983-2002 Sybase, Inc. All Rights Reserved.
*
*  ========================================================================
*
*    This file contains Original Code and/or Modifications of Original
*    Code as defined in and that are subject to the Sybase Open Watcom
*    Public License version 1.0 (the 'License'). You may not use this file
*    except in compliance with the License. BY USING THIS FILE YOU AGREE TO
*    ALL TERMS AND CONDITIONS OF THE LICENSE. A copy of the License is
*    provided with the Original Code and Modifications, and is also
*    available at www.sybase.com/developer/opensource.
*
*    The Original Code and all software distributed under the License are
*    distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
*    EXPRESS OR IMPLIED, AND SYBASE AND ALL CONTRIBUTORS HEREBY DISCLAIM
*    ALL SUCH WARRANTIES, INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF
*    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR
*    NON-INFRINGEMENT. Please see the License for the specific language
*    governing rights and limitations under the License.
*
*  ========================================================================
*
* Description:  Implementation of __qwrite() for SNAP.
*
****************************************************************************/


#include "variety.h"
#include <unistd.h>
#include <limits.h>
#include "rtcheck.h"

#include "scitech.h"
#include <os/imports.h>

#define MAX_OS_TRANSFER (((unsigned)INT_MAX+1) - 512)

unsigned __qwrite( int file, void *buffer, unsigned len )
{
    unsigned    total;
    int         h;
    int         amount;

    __handle_check( file, -1 );

    total = 0;
    for( ;; ) {
        if( len == 0 ) return( total );
        amount = (len > MAX_OS_TRANSFER) ? MAX_OS_TRANSFER : len;
        h = xwrite( file, buffer, amount );
        if( h < 0 ) return( h );
        total += h;
        if( h != amount ) return( total );
        buffer = (char *)buffer + amount;
        len -= amount;
    }
}

