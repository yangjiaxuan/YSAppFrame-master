//
//  NSString+Frame.h
//  YSAppFrame
//
//  Created by yangsen on 16/10/14.
//  Copyright © 2016年 sitemap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Frame)

- (CGFloat)stringHeightWithWidth:(CGFloat)width font:(UIFont *)font;

- (CGFloat)stringWidthWithHeight:(CGFloat)height font:(UIFont *)font;

@end
