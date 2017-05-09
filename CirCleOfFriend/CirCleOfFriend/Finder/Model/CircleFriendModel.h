//
//  CircleFriendModel.h
//  CirCleOfFriend
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CircleFriendCommentModel,CircleFriendLikeModel;

@interface CircleFriendModel : NSObject
@property (nonatomic, copy) NSString *username; //昵称
@property (nonatomic, copy) NSString *content; //内容
@property (nonatomic, copy) NSString *avatar; //头像
@property (nonatomic, copy) NSString *time; //时间

@property (nonatomic, assign) BOOL isOpening; //是否被打开
@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;
@property (nonatomic, assign, getter = isLiked) BOOL liked;

@property (nonatomic, copy) NSArray *picNameAr; //图片
@property (nonatomic, copy) NSArray <CircleFriendCommentModel *> *commentsAr;
@property (nonatomic, copy) NSArray <CircleFriendLikeModel *> *likeAr;

@end



@interface CircleFriendCommentModel : NSObject
@property (nonatomic, copy) NSString *commentsContent; //评论的内容
@property (nonatomic, copy) NSString *commentsUsername;//评论者昵称
@property (nonatomic, copy) NSString *commentsUserId; //评论者id
@property (nonatomic, copy) NSString *toUsername;//被评论者昵称
@property (nonatomic, copy) NSString *toUserid; //被评论者ID

@property (nonatomic, copy) NSAttributedString *attributedContent;
@end



@interface CircleFriendLikeModel : NSObject
@property (nonatomic, copy) NSString *userId; //点赞人的id
@property (nonatomic, copy) NSString *likeUserName; //点赞人昵称
@property (nonatomic, copy) NSAttributedString *attributedContent;
@end
