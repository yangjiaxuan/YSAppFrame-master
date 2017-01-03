//
//  YSTabBar.h
//  YSAppFrame
//
//  Created by yangsen on 16/10/17.
//  Copyright © 2016年 sitemap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSBarItemModel.h"
#import "YSBarItem.h"
#import "UIConfig.h"

@interface YSTabBarItemModel : YSBarItemModel

// 没有角标的item
+ (id)defaultTabBarItemModel;

// 默认的拥有数字角标的按钮模型
+ (id)badgeTabBarItemModel;

// 默认的又有 小圆点的 按钮模型
+ (id)dotTabBarModel;

@end

@interface YSTabBarItem : YSBarItem

@property (copy,   nonatomic) NSString *title;
@property (strong, nonatomic) UIFont   *font;

@property (strong, nonatomic) UIColor  *normalTitleColor;
@property (copy,   nonatomic) NSString *normalImageName;

@property (strong, nonatomic) UIColor  *selectedTitleColor;
@property (copy,   nonatomic) NSString *selectedImageName;

// 只有在dot 和 badge的title index 为0是才能被隐藏
- (void)hideDotAndBadge;
- (NSString *)badgeValue;
- (void)changeBadgeTitle:(NSString *)title;
@end

@interface YSTabBar : UIView

@property (assign, nonatomic) CGFloat height;

@property (strong, nonatomic) UIFont   *titleFont;

@property (strong, nonatomic) UIColor  *normalTitleColor;
@property (strong, nonatomic) UIColor  *selectedTitleColor;

@property (strong, nonatomic, readonly) NSArray *titles;
@property (strong, nonatomic, readonly) NSArray *normalImageNames;
@property (strong, nonatomic, readonly) NSArray *selectedImageNames;

// 只有设置了tabBar 才会有
+ (id)currentTabBar;

+ (id)tabBarWithHeight:(CGFloat)height titles:(NSArray *)titles normalImageNames:(NSArray *)normalImageNames selectedImageNames:(NSArray *)selectedImageNames selectedItemIndex:(void(^)(NSInteger index))selectedItemAction;

@end
