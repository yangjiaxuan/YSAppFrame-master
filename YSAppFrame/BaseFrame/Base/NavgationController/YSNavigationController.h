//
//  YSNavigationController.h
//  YSAppFrame
//
//  Created by yangsen on 16/10/13.
//  Copyright © 2016年 sitemap. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSNavigationControllerProtocol <NSObject>

@optional
@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIColor *titleFont;
@property (strong, nonatomic) UIImage *backgroundImage;
@property (assign, nonatomic) BOOL     hideBottomLine;

@end

@interface YSNavigationController : UINavigationController

@property (strong, nonatomic) id <YSNavigationControllerProtocol> configModel;


@end
