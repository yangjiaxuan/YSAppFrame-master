//
//  YSBarItemModel.h
//  YSAppFrame
//
//  Created by yangsen on 16/10/17.
//  Copyright © 2016年 sitemap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger){
    
    YSBarItemBadgeItem,
    YSBarItemDotItem,
    YSBarItemCustom
    
}YSBarItemType;

@interface YSImageModel : NSObject

@property (assign, nonatomic) NSInteger index;

@property (copy, nonatomic)   NSString *imageName;
@property (copy, nonatomic)   NSString *selectedImageName;

// 默认 {{0},{22,22}}
@property (assign, nonatomic) CGRect    imageFrame;

@end

@interface YSTitleModel : NSObject

@property (assign, nonatomic) NSInteger index;

@property (copy, nonatomic)   NSString *title;
// 默认 {{0},{22,22}}
@property (assign, nonatomic) CGRect    titleFrame;

@property (strong, nonatomic) UIColor  *titleColor;
@property (strong, nonatomic) UIFont   *titleFont;

@property (copy, nonatomic)   NSString *selectedTitle;
@property (strong, nonatomic) UIColor  *selectedTitleColor;

@property (strong, nonatomic) UIColor  *titleBackColor;

@property (assign, nonatomic) BOOL      isTitleNeedClipToCircle;
@property (assign, nonatomic, readonly) CGPathRef   titleFramePath;
@property (assign, nonatomic) BOOL      isDotOrBadge;

@property (assign, nonatomic, readonly) CGPoint  titleContentOrigin;

@end

@interface YSBarItemModel : NSObject

// 默认 {{0},{22,22}}
@property (assign, nonatomic) CGRect    frame;
@property (nonatomic,assign)  YSBarItemType barType;

@property (strong, nonatomic) NSArray <YSTitleModel *> *titles;
@property (strong, nonatomic) NSArray <YSImageModel *> *images;



@end
