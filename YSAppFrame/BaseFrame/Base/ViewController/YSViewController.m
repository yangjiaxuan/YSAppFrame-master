//
//  YSViewController.m
//  YSAppFrame
//
//  Created by yangsen on 16/10/13.
//  Copyright © 2016年 sitemap. All rights reserved.
//

#import "YSViewController.h"
#import "NSString+Frame.h"

@implementation YSNavBarItemModel

- (instancetype)init{
    if (self = [super init]) {
        self.isLeftBar  = YES;
    }
    return self;
}

+ (id)backBarItemModel{
    
    YSNavBarItemModel *backBarModel = [[self alloc]init];
    backBarModel.barType    = YSBarItemCustom;
    backBarModel.frame      = CGRectMake(0, 0, 45, 30);
    YSTitleModel *title     = [[YSTitleModel alloc]init];
    title.titleFrame        = CGRectMake(12, 5, 35, 20);
    
    YSImageModel *image     = [[YSImageModel alloc]init];
    image.imageFrame        = CGRectMake(0, 3, 12, 24);
    
    backBarModel.titles     = @[title];
    backBarModel.images     = @[image];
    backBarModel.isBackBar  = YES;
    return backBarModel;
}

// 默认的拥有图片 和 数字角标的按钮模型
+ (id)badgeAndImageModel{

    YSNavBarItemModel *backBarModel = [[self alloc]init];
    backBarModel.barType    = YSBarItemBadgeItem;
    CGFloat titleW = 15;
    CGFloat imageW = 22;
    
    backBarModel.frame      = CGRectMake(0, 0, imageW + titleW/2, imageW + titleW);
    YSTitleModel *title     = [[YSTitleModel alloc]init];
    title.index             = 0;
    title.title             = @"0";
    title.titleFrame        = CGRectMake(imageW-titleW/2 -2, 2, titleW, titleW);
    title.titleFont  = [UIFont systemFontOfSize:10];
    title.titleColor = [UIColor whiteColor];
    title.isTitleNeedClipToCircle = YES;
    title.titleBackColor = [UIColor redColor];
    
    YSImageModel *image     = [[YSImageModel alloc]init];
    image.imageFrame        = CGRectMake(0, titleW/2, imageW, imageW);
   
    backBarModel.titles     = @[title];
    backBarModel.images     = @[image];

    return backBarModel;
}

// 默认的又有图片 和 小圆点的 按钮模型
+ (id)dotAndImageModel{

    YSNavBarItemModel *backBarModel = [[self alloc]init];
    backBarModel.barType    = YSBarItemDotItem;
    CGFloat titleW = 8;
    CGFloat imageW = 22;
    backBarModel.frame      = CGRectMake(0, 0, imageW + titleW/2, imageW + titleW);
    
    YSTitleModel *title     = [[YSTitleModel alloc]init];
    title.index             = 0;
    title.titleFrame        = CGRectMake(imageW-titleW/2 - 2, 1, titleW, titleW);
    title.title      = @"";
    title.isTitleNeedClipToCircle = YES;
    title.titleBackColor = [UIColor redColor];
    
    YSImageModel *image     = [[YSImageModel alloc]init];
    image.imageFrame        = CGRectMake(0, titleW/2, imageW, imageW);
    
    backBarModel.titles     = @[title];
    backBarModel.images     = @[image];
    return backBarModel;
}
@end

@interface YSNavBarItem()

@end

@implementation YSNavBarItem

- (void)hideDotAndBadge{
    if ((self.barModel.barType == YSBarItemDotItem) || (self.barModel.barType == YSBarItemBadgeItem)) {
        [self changeTitle:nil withTitleIndex:0];
    }
}

- (NSString *)badgeValue{
    if (self.barModel.barType == YSBarItemBadgeItem) {
        YSTitleModel *titleModel = self.barModel.titles.firstObject;
        return titleModel.title;
    }
    return nil;
}

- (void)changeBadgeTitle:(NSString *)title{
    if (self.barModel.barType == YSBarItemBadgeItem) {
        if (title.integerValue >= 100) {
            title = @"99";
        }
        [self changeTitle:title withTitleIndex:0];
    }
}
@end

@interface YSViewController ()
{
    NSMutableArray *_leftNavBtnArr;
    NSMutableArray *_rightNavBtnArr;
    NSMutableArray *_leftNavBarItemArr;
    NSMutableArray *_rightNavBarItemArr;
}
@end

@implementation YSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _leftNavBarItemArr  = [NSMutableArray new];
    _rightNavBarItemArr = [NSMutableArray new];
    _leftNavBtnArr      = [NSMutableArray new];
    _rightNavBtnArr     = [NSMutableArray new];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self cancleNetRequest];
}

- (YSNavBarItem *)addDefaultBackBarItem{

    YSNavBarItemModel *backItemModel = [YSNavBarItemModel backBarItemModel];
    YSTitleModel *title = backItemModel.titles.firstObject;
    title.title         = @"返回";
    YSImageModel *image = backItemModel.images.firstObject;
    image.imageName = @"Nav_Back.png";
    backItemModel.titles = @[title];
    backItemModel.images = @[image];
    return [self addBackBarItemWithBarModel:backItemModel];
}
- (YSNavBarItem *)addBackBarItemWithBarModel:(YSNavBarItemModel *)barModel{
    barModel.isBackBar = YES;
    barModel.isLeftBar = YES;
    YSNavBarItem *backItem = [self addNavigationBarBtnWithBarModel:barModel];
    if (self.navigationController) {
        [_leftNavBtnArr exchangeObjectAtIndex:0 withObjectAtIndex:_leftNavBtnArr.count - 1];
        [_leftNavBarItemArr exchangeObjectAtIndex:0 withObjectAtIndex:_leftNavBtnArr.count - 1];
        self.navigationItem.leftBarButtonItems = _leftNavBarItemArr;
    }
    else{
        backItem.frame = CGRectMake(15, 25, backItem.frame.size.width, backItem.frame.size.height);
        [self.view addSubview:backItem];
    }
    return backItem;
}

// 增加添加带角标的item
- (YSNavBarItem *)addDefaultBadgeAndImageItemWithImageName:(NSString *)imageName isLeft:(BOOL)isLeft{

    YSNavBarItemModel *itemModel = [YSNavBarItemModel badgeAndImageModel];
    itemModel.isLeftBar          = isLeft;
    YSImageModel *image          = itemModel.images.firstObject;
    image.imageName              = imageName;
    itemModel.images             = @[image];
    [self addNavigationBarBtnWithBarModels:@[itemModel]];
    return isLeft ? _leftNavBtnArr.lastObject : _rightNavBtnArr.lastObject;
}

// 增加添加带小红点的item
- (YSNavBarItem *)addDefaultDotAndImageItemWithImageName:(NSString *)imageName isLeft:(BOOL)isLeft{

    YSNavBarItemModel *itemModel = [YSNavBarItemModel dotAndImageModel];
    itemModel.isLeftBar          = isLeft;
    YSImageModel *image          = itemModel.images.firstObject;
    image.imageName              = imageName;
    itemModel.images             = @[image];
    [self addNavigationBarBtnWithBarModels:@[itemModel]];
    return isLeft ? _leftNavBtnArr.lastObject : _rightNavBtnArr.lastObject;
}

- (YSNavBarItem *)addNavigationBarBtnWithTitle:(NSString *)title isLeft:(BOOL)isLeft{

    if (!title) {
        return nil;
    }
    return [self addNavigationBarBtnWithTitle:title imageName:nil isLeft:isLeft];
}

- (YSNavBarItem *)addNavigationBarBtnWithImageName:(NSString *)imageName isLeft:(BOOL)isLeft{
    if (!imageName) {
        return nil;
    }
    return [self addNavigationBarBtnWithTitle:nil imageName:imageName isLeft:isLeft];
}

- (YSNavBarItem *)addNavigationBarBtnWithTitle:(NSString *)title imageName:(NSString *)imageName isLeft:(BOOL)isLeft{
    YSNavBarItemModel *itemModel = [[YSNavBarItemModel alloc]init];
    
    YSImageModel *image          = [[YSImageModel alloc]init];
    image.imageName              = imageName;
    itemModel.images             = @[image];
    
    YSTitleModel *titleModel  = [[YSTitleModel alloc]init];
    titleModel.title          = title;
    CGFloat titleW        = [title stringWidthWithHeight:17 font:[UIFont systemFontOfSize:17]];
    titleModel.titleFrame = CGRectMake(titleModel.titleFrame.origin.x, titleModel.titleFrame.origin.y, titleW , titleModel.titleFrame.size.height);
    itemModel.frame      = CGRectMake(0, 0, titleW + (imageName?(image.imageFrame.size.width):0), itemModel.frame.size.height);
    itemModel.titles     = @[titleModel];
    
    itemModel.isLeftBar  = isLeft;
    [self addNavigationBarBtnWithBarModels:@[itemModel]];
    return isLeft?_leftNavBtnArr.lastObject:_rightNavBtnArr.lastObject;

}


- (void)addNavigationBarBtnWithBarModels:(NSArray <YSNavBarItemModel *> *)barModels{
    for (NSInteger i = 0; i < barModels.count; i ++) {
        [self addNavigationBarBtnWithBarModel:barModels[i]];
    }
    if (_leftNavBarItemArr.count) {
        self.navigationItem.leftBarButtonItems = _leftNavBarItemArr;
    }
    if (_rightNavBarItemArr.count) {
        self.navigationItem.rightBarButtonItems = _rightNavBarItemArr;
    }
}

- (YSNavBarItem *)addNavigationBarBtnWithBarModel:(YSNavBarItemModel *)barModel{
    YSNavBarItem *barItem = [YSNavBarItem barItemWithBarModel:barModel target:self action:barModel.isLeftBar?@selector(leftNavBarButtonClick:):@selector(rightNavBarButtonClick:)];
    if (barModel.isLeftBar) {
        [_leftNavBtnArr     addObject:barItem];
        [_leftNavBarItemArr addObject:[[UIBarButtonItem alloc]initWithCustomView:barItem]];
    }
    else{
        [_rightNavBtnArr     addObject:barItem];
        [_rightNavBarItemArr addObject:[[UIBarButtonItem alloc]initWithCustomView:barItem]];
    }
    return barItem;
}

- (void)leftNavBarButtonClick:(YSNavBarItem *)sender{
    if (((YSNavBarItemModel *)sender.barModel).isBackBar) {
        [self backBarClick:sender];
    }
    NSInteger index = [_leftNavBtnArr indexOfObject:sender];
    [self leftNavBarButtonClick:sender itemIndex:index];
}
- (void)rightNavBarButtonClick:(YSNavBarItem *)sender{
    [self rightNavBarButtonClick:sender itemIndex:[_rightNavBtnArr indexOfObject:sender]];
}

- (void)leftNavBarButtonClick:(YSNavBarItem *)sender itemIndex:(NSInteger)itemIndex{}

- (void)rightNavBarButtonClick:(YSNavBarItem *)sender itemIndex:(NSInteger)itemIndex{}

- (void)backBarClick:(YSNavBarItem *)sender{
    
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

+ (id)controller{
    
    return [[self alloc]init];
}

+ (id)controllerWithStoryBoardName:(NSString *)storyBoardName controllerStoryBoardIndentifier:(NSString *)identifier{

    return [[UIStoryboard storyboardWithName:storyBoardName bundle:nil]instantiateViewControllerWithIdentifier:identifier];
}

- (void)cancleNetRequest{
    
    if (self.netRequestTask) {
        [self.netRequestTask cancel];
    }
}

- (NSArray *)leftNavBtns{
    
    return [_leftNavBtnArr copy];
}

- (NSArray *)rightNavBtns{

    return [_rightNavBtnArr copy];
}
@end
