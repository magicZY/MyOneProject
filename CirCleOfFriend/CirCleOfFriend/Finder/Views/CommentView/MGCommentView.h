//
//  MGCommentView.h
//  CirCleOfFriend
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGCommentView : UIView
- (void)setUpWithLikeItemsArray:(NSArray *)likeItemsArray andCommentItemsArray:(NSArray *)commentItemsArray;

@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId, CGRect rectInWindow);

@end
