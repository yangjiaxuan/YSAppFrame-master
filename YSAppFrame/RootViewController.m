
//
//  RootViewController.m
//  YSAppFrame
//
//  Created by yangsen on 16/10/13.
//  Copyright © 2016年 sitemap. All rights reserved.
//

#import "RootViewController.h"
#import "MainViewController.h"

@interface RootViewController ()
{
    YSNavBarItem *badgeItem;
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addDefaultBackBarItem];
    badgeItem = [self addDefaultBadgeAndImageItemWithImageName:@"Nav_Message" isLeft:YES];
    [self addDefaultDotAndImageItemWithImageName:@"Nav_Message" isLeft:YES];

    [self addNavigationBarBtnWithImageName:@"Nav_Message" isLeft:NO];
    [self addNavigationBarBtnWithTitle:@"上海" isLeft:NO];
    
    
}

- (void)leftNavBarButtonClick:(YSNavBarItem *)sender itemIndex:(NSInteger)itemIndex
{
    
    NSLog(@"左-----index:%lu",itemIndex);
    if (itemIndex == 1) {
        NSInteger titleValue = sender.badgeValue.integerValue;
        [badgeItem changeBadgeTitle:[NSString stringWithFormat:@"%lu",++titleValue]];
    }
}

- (void)rightNavBarButtonClick:(YSNavBarItem *)sender itemIndex:(NSInteger)itemIndex{
    NSLog(@"右------index:%lu",itemIndex);
    if (itemIndex == 0) {
        MainViewController *main = [[MainViewController alloc]init];
        [self.navigationController pushViewController:main animated:NO];
    }
    if (itemIndex == 1) {
        MainViewController *main = [[MainViewController alloc]init];
        [self presentViewController:main animated:YES completion:nil];
    }
}
@end
