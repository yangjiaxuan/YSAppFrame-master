//
//  YSBarItemModel.m
//  YSAppFrame
//
//  Created by yangsen on 16/10/17.
//  Copyright © 2016年 sitemap. All rights reserved.
//

#import "YSBarItemModel.h"
#import "NSString+Frame.h"

@implementation YSImageModel

- (instancetype)init{
    if (self = [super init]) {
        self.index      = 0;
        self.imageFrame = CGRectMake(0, 0, 22, 22);
    }
    return self;
}

@end

@implementation YSTitleModel
{
    CGRect _titleContentFrame;
}
- (instancetype)init{
    if (self = [super init]) {
        self.index      = 1;
        self.titleFrame = CGRectMake(0, 0, 22, 22);
        self.titleColor = [UIColor blackColor];
        self.titleFont  = [UIFont systemFontOfSize:17];
        self.titleBackColor          = [UIColor clearColor];
        self.isTitleNeedClipToCircle = NO;
        self.isDotOrBadge            = NO;
        _titleContentFrame           = CGRectZero;
    }
    return self;
}

- (void)setTitleFrame:(CGRect)titleFrame{
    _titleFrame = titleFrame;
    [self setTitleContentFrame];
    [self setTitleCircleRect];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    [self setTitleContentFrame];
    [self setTitleCircleRect];
}

- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    [self setTitleContentFrame];
    [self setTitleCircleRect];
}

- (void)setTitleContentFrame{
    
    CGFloat titleW = [_title stringWidthWithHeight:_titleFrame.size.height font:_titleFont];
    CGFloat titleH = [_title stringHeightWithWidth:titleW font:_titleFont];
    
    CGFloat titleX = (_titleFrame.size.width - titleW)/2 + _titleFrame.origin.x;
    CGFloat titleY = (_titleFrame.size.height - titleH)/2 + _titleFrame.origin.y;
    _titleContentOrigin = CGPointMake(titleX, titleY);
    _titleContentFrame  = CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setTitleCircleRect{
    
    CGFloat titleW = _titleContentFrame.size.width;
    CGFloat titleH = _titleFrame.size.height;
    if (titleW < self.titleFont.pointSize) {

        CGFloat newRectX = _titleContentFrame.origin.x + (titleW - titleH)/2;
        CGFloat newRectY = _titleFrame.origin.y;
        CGRect rect = CGRectMake(newRectX, newRectY, titleH, titleH);
        _titleFramePath = CGPathCreateWithRoundedRect(rect, titleH/2, titleH/2, NULL);
    }
    else{
       
        CGFloat newRectW = titleW - self.titleFont.pointSize + titleH;
        CGFloat newRectX = _titleContentFrame.origin.x + (titleW - newRectW)/2;
        CGFloat newRectY = _titleFrame.origin.y;
        CGRect rect      = CGRectMake(newRectX, newRectY, newRectW, titleH);
        _titleFramePath  = CGPathCreateWithRoundedRect(rect, titleH/2, titleH/2, NULL);
    }
}

@end

@implementation YSBarItemModel

- (instancetype)init{
    if (self = [super init]) {
        
        self.frame      = CGRectMake(0, 0, 22, 22);
    }
    return self;
}


@end
