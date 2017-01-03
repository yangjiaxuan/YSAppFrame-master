//
//  YSBarItem.h
//  YSAppFrame
//
//  Created by yangsen on 16/10/17.
//  Copyright © 2016年 sitemap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSBarItemModel.h"

@interface YSBarItem : UIView

@property (strong, nonatomic, readonly) id target;
@property (assign, nonatomic, readonly) SEL action;

@property (strong, nonatomic) YSBarItemModel *barModel;

@property (assign, nonatomic, getter=isSelected) BOOL selected;

@property (assign, nonatomic) BOOL hideDotOrBadge;

+ (id)barItemWithBarModel:(YSBarItemModel *)barModel target:(id)target action:(SEL)action;

- (void)changeTitle:(NSString *)title withTitleIndex:(NSInteger)titleIndex;
- (void)changeImage:(NSString *)imageName withImageIndex:(NSInteger)imageIndex;

@end
