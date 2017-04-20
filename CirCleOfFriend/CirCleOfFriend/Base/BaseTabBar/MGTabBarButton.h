//
//  MGTabBarButton.h
//  CirCleOfFriend
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGTabBarButton : UIButton

@property (nonatomic, assign) BOOL isShowTitle;

@property (nonatomic, strong) UITabBarItem *item;

@end
