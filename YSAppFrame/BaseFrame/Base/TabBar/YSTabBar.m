//
//  YSTabBar.m
//  YSAppFrame
//
//  Created by yangsen on 16/10/17.
//  Copyright © 2016年 sitemap. All rights reserved.
//

#import "YSTabBar.h"

@implementation YSTabBarItemModel

+ (id)defaultTabBarItemModel{
    
    CGFloat tabBarItemW  = 50;
    CGFloat tabBarItemH  = 49;
    
    CGFloat betweenLineY = tabBarItemH/2;
    CGFloat spaceToLine  = 5;
    
    YSTabBarItemModel *tabBarItemModel = [[self alloc]init];
    tabBarItemModel.barType    = YSBarItemCustom;
    tabBarItemModel.frame      = CGRectMake(0, 0, tabBarItemW, tabBarItemH);
    
    CGFloat titleW = tabBarItemW;
    CGFloat titleH = tabBarItemH * 0.3;
    CGFloat titleX = (tabBarItemW - titleW)/2;
    CGFloat titleY = betweenLineY + spaceToLine;
    YSTitleModel *title     = [[YSTitleModel alloc]init];
    title.titleFrame        = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat imageW = tabBarItemW * 0.4;
    CGFloat imageH = imageW;
    CGFloat imageX = (tabBarItemW - imageW)/2;
    CGFloat imageY = betweenLineY - spaceToLine - imageH;
    YSImageModel *image     = [[YSImageModel alloc]init];
    image.imageFrame        = CGRectMake(imageX, imageY, imageW, imageH);
    
    tabBarItemModel.titles     = @[title];
    tabBarItemModel.images     = @[image];
    return tabBarItemModel;
}

// 默认的拥有图片 和 数字角标的按钮模型
+ (id)badgeTabBarItemModel{
    
    YSTabBarItemModel *badgeBarModel = [self defaultTabBarItemModel];
    badgeBarModel.barType    = YSBarItemBadgeItem;
    CGFloat titleW = 15;
    YSImageModel *imageModel = (YSImageModel *)badgeBarModel.images.firstObject;
    CGFloat imageX = imageModel.imageFrame.origin.x;
    CGFloat imageY = imageModel.imageFrame.origin.y;
    CGFloat imageW = imageModel.imageFrame.size.width;
    
    YSTitleModel *title     = [[YSTitleModel alloc]init];
    title.title             = @"10";
    title.index             = 0;
    title.titleFrame        = CGRectMake(imageX + imageW-titleW/2, imageY - titleW/2, titleW, titleW);
    title.titleFont  = [UIFont systemFontOfSize:10];
    title.titleColor = [UIColor whiteColor];
    title.isTitleNeedClipToCircle = YES;
    title.titleBackColor = [UIColor redColor];
    
    badgeBarModel.titles = [NSArray arrayWithObjects:title, badgeBarModel.titles.firstObject, nil];
    return badgeBarModel;
}

// 默认的又有图片 和 小圆点的 按钮模型
+ (id)dotTabBarModel{
    
    YSTabBarItemModel *dotBarModel = [[self alloc]init];
    dotBarModel.barType    = YSBarItemDotItem;
    CGFloat titleW = 8;
    
    YSImageModel *imageModel = (YSImageModel *)dotBarModel.images.firstObject;
    CGFloat imageX = imageModel.imageFrame.origin.x;
    CGFloat imageY = imageModel.imageFrame.origin.y;
    CGFloat imageW = imageModel.imageFrame.size.width;
    YSTitleModel *title     = [[YSTitleModel alloc]init];
    title.title             = @"10";
    title.index             = 0;
    title.titleFrame        = CGRectMake(imageX + imageW-titleW/2, imageY - titleW/2, titleW, titleW);
    title.titleFont  = [UIFont systemFontOfSize:10];
    title.titleColor = [UIColor whiteColor];
    title.isTitleNeedClipToCircle = YES;
    title.titleBackColor = [UIColor redColor];
    
    dotBarModel.images = [NSArray arrayWithObjects:title, dotBarModel.images.firstObject, nil];
    return dotBarModel;
}

@end

@interface YSTabBarItem ()

@end

@implementation YSTabBarItem

- (void)hideDotAndBadge{
    if ((self.barModel.barType == YSBarItemDotItem) || (self.barModel.barType == YSBarItemBadgeItem)) {
        [self changeTitle:nil withTitleIndex:0];
    }
}

- (NSString *)badgeValue{
    if (self.barModel.barType == YSBarItemBadgeItem) {
        for (YSTitleModel *titleModel in self.barModel.titles) {
            if (titleModel.index == 0) {
                return titleModel.title;
            }
        }
    }
    return nil;
}

- (void)changeBadgeTitle:(NSString *)title{
    if (self.barModel.barType == YSBarItemBadgeItem) {
        [self changeTitle:title withTitleIndex:0];
    }
}

- (void)setFont:(UIFont *)font{
    for (YSTitleModel *titleModel in self.barModel.titles) {
        if (titleModel.index == 1) {
            titleModel.titleFont = font;
            break;
        }
    }
}

- (void)setTitle:(NSString *)title{
    for (YSTitleModel *titleModel in self.barModel.titles) {
        if (titleModel.index == 1) {
            titleModel.title = title;
            break;
        }
    }
}

- (void)setNormalTitleColor:(UIColor *)normalTitleColor{
    for (YSTitleModel *titleModel in self.barModel.titles) {
        if (titleModel.index == 1) {
            titleModel.titleColor = normalTitleColor;
            break;
        }
    }
}

- (void)setNormalImageName:(NSString *)normalImageName{
    for (YSImageModel *imageModel in self.barModel.images) {
        if (imageModel.index == 1) {
            imageModel.imageName = normalImageName;
            break;
        }
    }
}

- (void)setSelectedImageName:(NSString *)selectedImageName{
    for (YSImageModel *imageModel in self.barModel.images) {
        if (imageModel.index == 1) {
            imageModel.selectedImageName = selectedImageName;
            break;
        }
    }
}
@end

@interface YSTabBar()
{
    NSMutableArray *_itemBackViews;
}
@end
@implementation YSTabBar

static YSTabBar *_tabBar = nil;
+ (id)tabBarWithHeight:(CGFloat)height titles:(NSArray *)titles normalImageNames:(NSArray *)normalImageNames selectedImageNames:(NSArray *)selectedImageNames selectedItemIndex:(void(^)(NSInteger index))selectedItemAction{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGRect tabBarFrame = CGRectMake(0, SCREEN_H - height, SCREEN_W, height);
        _tabBar = [[YSTabBar alloc]initWithFrame:tabBarFrame];
        _tabBar->_titles = titles;
        _tabBar->_normalImageNames   = normalImageNames;
        _tabBar->_selectedImageNames = selectedImageNames;
        _tabBar->_height             = height;
        [_tabBar setUI];
    });
    
    return _tabBar;
}

+ (id)currentTabBar{
    return _tabBar;
}

- (void)setUI{

    NSInteger numberOfItem =MIN(MIN(self.titles.count, self.normalImageNames.count), self.selectedImageNames.count);
    for (NSInteger i = 0; i < numberOfItem; i ++ ) {
        
        CGFloat itemBackViewW = SCREEN_W / numberOfItem;
        CGFloat itemBackViewH = _height;
        CGFloat itemBackViewX = itemBackViewW *i;
        UIView *itemBackView = [[UIView alloc]initWithFrame:CGRectMake(itemBackViewX, 0, itemBackViewW, itemBackViewH)];
        [self addSubview:itemBackView];
        
        
        YSTabBarItem *barItem = [YSTabBarItem barItemWithBarModel:[YSTabBarItemModel defaultTabBarItemModel] target:self action:@selector(tabBarItemAction:)];
        
        YSTabBarItemModel *model = (YSTabBarItemModel *)barItem.barModel;
        CGFloat barItemW = model.frame.size.width;
        CGFloat barItemH = model.frame.size.height;
        CGFloat barItemX = (itemBackViewW - barItemW)/2;
        CGFloat barItemY = (itemBackViewH - barItemH)/2;
        model.frame = CGRectMake(barItemX, barItemY, barItemW, barItemH);
        barItem.barModel = model;
        
        barItem.tag = i + 100;
        [itemBackView addSubview:barItem];
        [_itemBackViews addObject:itemBackView];
    }
}

- (void)tabBarItemAction:(YSTabBarItem *)sender{

}

@end
