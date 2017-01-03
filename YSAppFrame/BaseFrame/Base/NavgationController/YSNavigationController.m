//
//  YSNavigationController.m
//  YSAppFrame
//
//  Created by yangsen on 16/10/13.
//  Copyright © 2016年 sitemap. All rights reserved.
//

#import "YSNavigationController.h"
#import "UIImage+Extend.h"

@interface YSNavigationController ()
{
    id <YSNavigationControllerProtocol> _configModel;
}
@end

@implementation YSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController configModel:(id <YSNavigationControllerProtocol>)configModel{

    if (self = [super initWithRootViewController:rootViewController]) {
        _configModel = configModel;
    }
    return self;
}

- (void)setConfigModel:(id<YSNavigationControllerProtocol>)configModel{
    _configModel = configModel;
    // 隐藏底部的线
    if ([_configModel respondsToSelector:@selector(hideBottomLine)]) {
        [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    }
    // 设置背景
    if ([_configModel respondsToSelector:@selector(backgroundColor)]) {
        self.navigationBar.barTintColor = [_configModel backgroundColor];
        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[_configModel backgroundColor]] forBarMetrics:UIBarMetricsDefault];
    }
    else if ([_configModel respondsToSelector:@selector(backgroundImage)]) {
        [self.navigationBar setBackgroundImage:[_configModel backgroundImage] forBarMetrics:UIBarMetricsDefault];
    }
    // 设置title
    NSMutableDictionary *titleAttributes;
    if ([_configModel respondsToSelector:@selector(titleColor)]) {
        titleAttributes = [[NSMutableDictionary alloc]initWithDictionary:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[_configModel titleColor]}];
    }
    if ([_configModel respondsToSelector:@selector(titleFont)]) {
        if (titleAttributes) {
            [titleAttributes setObject:[_configModel titleFont] forKey:NSFontAttributeName];
        }
        else{
            titleAttributes = [[NSMutableDictionary alloc]initWithDictionary:@{NSFontAttributeName:[_configModel titleFont]}];
        }
    }
    if (titleAttributes) {
        [self.navigationBar setTitleTextAttributes:titleAttributes];
    }
    
    
}

#pragma mark ------- 设置转屏 -------
- (BOOL)shouldAutorotate {
    
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

#pragma mark --------- 设置状态栏样式 ----------
- (UIViewController *)childViewControllerForStatusBarStyle{
    
    return self.topViewController;
}

@end
