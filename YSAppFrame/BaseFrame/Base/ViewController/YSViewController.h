//
//  YSViewController.h
//  YSAppFrame
//
//  Created by yangsen on 16/10/13.
//  Copyright © 2016年 sitemap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSBarItemModel.h"
#import "YSBarItem.h"

@interface YSNavBarItemModel : YSBarItemModel

@property (assign, nonatomic) BOOL      isBackBar;
@property (assign, nonatomic) BOOL      isLeftBar;

// 默认的返回按钮模型
+ (id)backBarItemModel;

// 默认的拥有图片 和 数字角标的按钮模型
+ (id)badgeAndImageModel;

// 默认的又有图片 和 小圆点的 按钮模型
+ (id)dotAndImageModel;

@end



@interface YSNavBarItem : YSBarItem

// 只有在dot 和 badge的title index 为0是才能被隐藏
- (void)hideDotAndBadge;
- (NSString *)badgeValue;
- (void)changeBadgeTitle:(NSString *)title;

@end



@interface YSViewController : UIViewController

@property (strong, nonatomic) NSURLSessionTask *netRequestTask;
@property (strong, nonatomic, readonly) NSArray *leftNavBtns;
@property (strong, nonatomic, readonly) NSArray *rightNavBtns;

- (YSNavBarItem *)addDefaultBackBarItem;
- (YSNavBarItem *)addBackBarItemWithBarModel:(YSNavBarItemModel *)barModel;

// 增加添加带角标的item
- (YSNavBarItem *)addDefaultBadgeAndImageItemWithImageName:(NSString *)imageName isLeft:(BOOL)isLeft;
// 增加添加带小红点的item
- (YSNavBarItem *)addDefaultDotAndImageItemWithImageName:(NSString *)imageName isLeft:(BOOL)isLeft;

- (YSNavBarItem *)addNavigationBarBtnWithTitle:(NSString *)title isLeft:(BOOL)isLeft;

- (YSNavBarItem *)addNavigationBarBtnWithImageName:(NSString *)imageName isLeft:(BOOL)isLeft;

- (void)addNavigationBarBtnWithBarModels:(NSArray <YSNavBarItemModel *> *)barModels;

// 从 左 到 右 index 0 1 2。。。
- (void)leftNavBarButtonClick:(YSNavBarItem *)sender  itemIndex:(NSInteger)itemIndex;
// 从 右 到 左 index 0 1 2。。。
- (void)rightNavBarButtonClick:(YSNavBarItem *)sender itemIndex:(NSInteger)itemIndex;

+ (id)controller;
+ (id)controllerWithStoryBoardName:(NSString *)storyBoardName controllerStoryBoardIndentifier:(NSString *)identifier;

@end

