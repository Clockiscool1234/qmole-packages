/*
 * Sylpheed -- a GTK+ based, lightweight, and fast e-mail client
 * Copyright (C) 1999-2012 Hiroyuki Yamamoto  and the Claws Mail team
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 * 
 */

#ifndef __VERSION_H__
#define __VERSION_H__

#include <glib.h>

#define MAKE_NUMERIC_VERSION(a, b, c, d) ((((guint32)a) << 24) | (((guint32)b) << 16) | \
					  (((guint32)c) <<  8) |  ((guint32)d)      )

#define PACKAGE			"claws-mail"
#define VERSION			"3.9.0"
#define PROG_VERSION		"Claws Mail "VERSION
#define VERSION_NUMERIC		MAKE_NUMERIC_VERSION(3, 9, \
						     0, 0)

#endif /* __VERSION_H__ */
