//
//  MGTabBar.h
//  CirCleOfFriend
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, MGTabBarAnimationStyle)
{
    MGTabBarAnimationStyleScale,
    MGTabBarAnimationStyleTranslation
};

@class MGTabBar;

@protocol MGTabBarDelegate <NSObject>

- (void)tabBar:(MGTabBar *)tabBar didSelectedItemFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface MGTabBar : UIView

//子控制器的tabBarItem数组
@property (nonatomic, copy)NSArray *items;

@property (nonatomic, assign)id <MGTabBarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame AnimationStyle:(MGTabBarAnimationStyle)style;
@end
