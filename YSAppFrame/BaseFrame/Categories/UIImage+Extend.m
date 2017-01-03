//
//  UIImage+Extend.m
//  YSAppFrame
//
//  Created by yangsen on 16/10/14.
//  Copyright © 2016年 sitemap. All rights reserved.
//

#import "UIImage+Extend.h"

@implementation UIImage (Extend)

+ (UIImage *)imageWithColor:(UIColor *)color{

    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    CGContextRef ct = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ct, color.CGColor);
    CGContextFillRect(ct, CGRectMake(0, 0, 1, 1));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
