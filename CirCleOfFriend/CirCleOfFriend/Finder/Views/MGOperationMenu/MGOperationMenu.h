//
//  MGOperationMenu.h
//  CirCleOfFriend
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGOperationMenu : UIView
@property (nonatomic, assign, getter = isShowing) BOOL show;

@property (nonatomic, copy) void (^likeClickedOperation)(); //点赞
@property (nonatomic, copy) void (^commentClickedOperation)(); //评论
@end
