//
//  UIConfig.h
//  YSAppFrame
//
//  Created by yangsen on 16/10/13.
//  Copyright © 2016年 sitemap. All rights reserved.
//

#ifndef UIConfig_h
#define UIConfig_h

#define SCREEN_W ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_H ([[UIScreen mainScreen] bounds].size.height)

#define RGBA_COLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define TITLE_HIGH_COLOR  [UIColor blackColor]
#define TITLE_LIGHT_COLOR RGBA_COLOR(144, 144, 144, 0.8)

#endif /* UIConfig_h */
