//
//  NSString+Frame.m
//  YSAppFrame
//
//  Created by yangsen on 16/10/14.
//  Copyright © 2016年 sitemap. All rights reserved.
//

#import "NSString+Frame.h"

@implementation NSString (Frame)

- (CGFloat)stringWidthWithHeight:(CGFloat)height font:(UIFont *)font{
    CGSize size = CGSizeMake(1000, height);
    return [self stringSizeWithSize:size font:font].width;
}

- (CGFloat)stringHeightWithWidth:(CGFloat)width font:(UIFont *)font{

    CGSize size = CGSizeMake(width, 1000);
    return [self stringSizeWithSize:size font:font].height;
}

- (CGSize)stringSizeWithSize:(CGSize)size font:(UIFont *)font{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    return [self boundingRectWithSize:size
                                        options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;

}
@end
