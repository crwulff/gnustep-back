/*
   Copyright (C) 2013 Free Software Foundation, Inc.

   Author: Chris Wulff <crwulff@gmail.com>

   This file is part of GNUstep.

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with this library; see the file COPYING.LIB.
   If not, see <http://www.gnu.org/licenses/> or write to the 
   Free Software Foundation, 51 Franklin Street, Fifth Floor, 
   Boston, MA 02110-1301, USA.
*/

#include <AppKit/NSBitmapImageRep.h>

#include "cairo/CairoImageSurface.h"

@implementation CairoImageSurface

- (id) initWithDevice: (void *)device
{
  NSBitmapImageRep *bitmap = (NSBitmapImageRep*)device;

  size = NSMakeSize([bitmap pixelsWide], [bitmap pixelsHigh]);

  _surface = cairo_image_surface_create_for_data([bitmap bitmapData], CAIRO_FORMAT_ARGB32, [bitmap pixelsWide], [bitmap pixelsHigh], [bitmap bytesPerRow]);
  if (cairo_surface_status(_surface))
    {
      NSLog(@"Failed initWithDevice in CairoImageSurface");
      DESTROY(self);
    }

  return self;
}

- (void) dealloc
{
  if (_surface)
    {
      cairo_surface_flush(_surface);
    }

  [super dealloc];
}

- (NSSize) size
{
  return size;
}

- (void) setSize: (NSSize)newSize
{
  // Can't change the size
}

- (BOOL) isDrawingToScreen
{
  return NO;
}

@end

