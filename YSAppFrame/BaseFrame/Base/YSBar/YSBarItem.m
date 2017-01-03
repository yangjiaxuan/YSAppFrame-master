//
//  YSBarItem.m
//  YSAppFrame
//
//  Created by yangsen on 16/10/17.
//  Copyright © 2016年 sitemap. All rights reserved.
//

#import "YSBarItem.h"
#import "NSString+Frame.h"

@interface YSBarItem()
{
    id                 _target;
    SEL                _action;
    NSString          *_title;
    NSString          *_imageName;
}
@end

@implementation YSBarItem

+ (id)barItemWithBarModel:(YSBarItemModel *)barModel target:(id)target action:(SEL)action{
    
    YSBarItem *barItem = [[self alloc]initWithFrame:barModel.frame];
    barItem->_barModel    = barModel;
    barItem->_target      = target;
    barItem->_action      = action;
    barItem->_hideDotOrBadge = NO;
    barItem.layer.masksToBounds = NO;
    [barItem setup];
    return barItem;
}

- (void)setup{
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds   = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
}

- (void)tapAction{
    if ([_target respondsToSelector:_action]) {
        [_target performSelector:_action withObject:self];
    }
}


- (void)setSelected:(BOOL)selected{
    _selected = selected;
    [self setNeedsDisplay];
}

- (void)setBarModel:(YSBarItemModel *)barModel{
    _barModel = barModel;
    [self setNeedsLayout];
}

- (void)drawRect:(CGRect)rect{
    for (YSImageModel *imageModel in self.barModel.images) {
        [self drawImageWithImageModel:imageModel];
    }
    for (YSTitleModel *titleModel in self.barModel.titles) {
        [self drawTitleWithTitleModel:titleModel];
    }
}

- (void)drawTitleWithTitleModel:(YSTitleModel *)titleModel{

    if (titleModel.isDotOrBadge && self.hideDotOrBadge) {
        return;
    }
    if (titleModel.title) {
        if (titleModel.titleBackColor) {
            CGContextRef ct = UIGraphicsGetCurrentContext();
            CGContextSetFillColorWithColor(ct, titleModel.titleBackColor.CGColor);
            if (titleModel.isTitleNeedClipToCircle) {

                CGContextAddPath(ct, titleModel.titleFramePath);
            }
            else{
                CGContextAddRect(ct, titleModel.titleFrame);
            }
            CGContextFillPath(ct);
        }
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [(self.isSelected&&titleModel.selectedTitle)?titleModel.selectedTitle:titleModel.title  drawAtPoint:titleModel.titleContentOrigin withAttributes:@{NSFontAttributeName:titleModel.titleFont,NSForegroundColorAttributeName:titleModel.titleColor, NSParagraphStyleAttributeName:paragraphStyle}];
    }

}

- (void)drawImageWithImageModel:(YSImageModel *)imageModel{

    if (imageModel.imageName) {
        UIImage *backImage = [UIImage imageNamed:(self.isSelected&&imageModel.selectedImageName)?imageModel.selectedImageName:imageModel.imageName];
        [backImage drawInRect:imageModel.imageFrame];
    }
}

- (void)setHideDotOrBadge:(BOOL)hideDotOrBadge{
    _hideDotOrBadge = hideDotOrBadge;
    [self setNeedsDisplay];
}

- (void)changeTitle:(NSString *)title withTitleIndex:(NSInteger)titleIndex{
    for (YSTitleModel *titleModel in self.barModel.titles) {
        if (titleModel.index == titleIndex) {
            titleModel.title = title;
            [self setNeedsDisplay];
            break;
        }
    }
}

- (void)changeImage:(NSString *)imageName withImageIndex:(NSInteger)imageIndex{
    for (YSImageModel *imageModel in self.barModel.images) {
        if (imageModel.index == imageIndex) {
            imageModel.imageName = imageName;
            break;
        }
    }
}

@end
