//
//  MGCommentView.m
//  CirCleOfFriend
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MGCommentView.h"
#import "CircleFriendModel.h"
#import "UIView+SDAutoLayout.h"
#import "MLLinkLabel.h"

#define CellHighlightedColor [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0]

@interface MGCommentView ()<MLLinkLabelDelegate>
@property (nonatomic, strong) NSArray *likeItemsArray; //点赞数组
@property (nonatomic, strong) NSArray *commentItemsArray; //评论数组

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) MLLinkLabel *likeLabel;
@property (nonatomic, strong) UIView *likeLableBottomLine;

@property (nonatomic, strong) NSMutableArray *commentLabelsArray;
@end

@implementation MGCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //初始化界面
        [self setUpViews];
    }
    
    return self;
}

- (void)setUpViews
{
    self.bgImageView.backgroundColor = [UIColor clearColor];
    
    _bgImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

#pragma mark - public
- (void)setUpWithLikeItemsArray:(NSArray *)likeItemsArray andCommentItemsArray:(NSArray *)commentItemsArray
{
    self.likeItemsArray = likeItemsArray;
    self.commentItemsArray = commentItemsArray;
    
    if (self.commentLabelsArray.count) {
        /*
         ** 这个地方可以用for in和enumerateObjectsUsingBlock来代替传统for循环
         ** for in 的优势在于当数组中数据量比较大时，那么他的速度是最快的，但是如下面的情况会崩溃
             NSMutableArray * arr = @[@1,@2,@3,@4,@5].mutableCopy;
             for (NSString * obj in arr) {
                 if ([obj integerValue] == 2) {
                     [arr addObject:@"6"];
                 }
             }
         若用
             for(int i = 0; i < arr.count; i++) {
                 NSString *obj = arr[i];
                 if ([obj integerValue] == 2){
                     [arr addObject:@"6"];
                 }
             }
         则没有问题
         ** 其原因为对于可变数组进行枚举操作时，不能通过添加或删除对象等这类操作来改变数组容器,否则就会报错.而本身这种操作也是有问题的，数组容器已经改变，可能遍历到没有分配的位置，用for循环机器不能自己察觉，但是枚举器可以察觉。
         ** 而enumerateObjectsUsingBlock则是对于字典的遍历速度是最快的
         ** 在这里根据实际情况我们选择传统for循环
         */
        for (int i = 0 ; i < self.commentLabelsArray.count; i ++) {
            UILabel *label = self.commentLabelsArray[i];
            //清除之前的约束
            [label sd_clearAutoLayoutSettings];
            //先把所有的评论全部隐藏起来，然后根据有多少评论数再来显示
            label.hidden = YES;
        }
    }
    
    if (!commentItemsArray.count && !likeItemsArray.count) {
         // 如果没有评论或者点赞，设置commentview的固定宽度为0（设置了fixedWith的控件将不再在自动布局过程中调整宽度）
        self.fixedWidth = @(0);
        self.fixedHeight = @(0);
        return;
    }else {
        // 取消固定宽度和高度的约束
        self.fixedHeight = nil;
        self.fixedWidth = nil;
    }
    
    UIView *bottomView = nil;
    
    if (likeItemsArray.count) {
        
        self.likeLabel.sd_resetLayout
        .leftSpaceToView(self, 5)
        .rightSpaceToView(self, 5)
        .topSpaceToView(bottomView, 10)
        .autoHeightRatio(0);
        
        bottomView = _likeLabel;
        
    } else {
        
        self.likeLabel.attributedText = nil;
        _likeLabel.sd_resetLayout.heightIs(0);
    }
    
    if (self.commentItemsArray.count && self.likeItemsArray.count) {
        self.likeLableBottomLine.sd_resetLayout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .heightIs(1)
        .topSpaceToView(bottomView, 3);
        
        bottomView = _likeLableBottomLine;
    } else {
        self.likeLableBottomLine.sd_resetLayout.heightIs(0);
    }

    for (int i = 0; i < self.commentItemsArray.count ; i++) {
        
        UILabel *label = (UILabel *)self.commentLabelsArray[i];
        label.hidden = NO;
        CGFloat topMargin = (i == 0 && likeItemsArray.count == 0) ? 10 : 5;
        label.sd_layout
        .leftSpaceToView(self, 8)
        .rightSpaceToView(self, 5)
        .topSpaceToView(bottomView, topMargin)
        .autoHeightRatio(0);
        
        label.isAttributedContent = YES;
        bottomView = label;

    }
    
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:6];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}


#pragma mark - private

- (NSMutableAttributedString *)generateAttributedStringWithLikeItemModel:(CircleFriendLikeModel *)model
{
    NSString *text = model.likeUserName;
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    UIColor *highLightColor = [UIColor blueColor];
    [attString setAttributes:@{NSForegroundColorAttributeName : highLightColor, NSLinkAttributeName : model.userId} range:[text rangeOfString:model.likeUserName]];
    
    return attString;
}

- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(CircleFriendCommentModel *)model
{
    NSString *text = model.commentsUsername;
    if (model.toUsername.length) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"回复%@", model.toUsername]];
    }
    text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", model.commentsContent]];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    [attString setAttributes:@{NSLinkAttributeName : model.commentsUserId} range:[text rangeOfString:model.commentsUsername]];
    if (model.toUsername) {
        [attString setAttributes:@{NSLinkAttributeName : model.toUserid} range:[text rangeOfString:model.toUsername]];
    }
    return attString;
}

#pragma mark - MLLinkLabelDelegate
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    NSLog(@"%@", link.linkValue);
}

#pragma mark - getter
- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        
        _bgImageView = [UIImageView new];
        
        [self addSubview:_bgImageView];
        
        UIImage *bgImage = [[[UIImage imageNamed:@"LikeCmtBg"] stretchableImageWithLeftCapWidth:40 topCapHeight:30] imageWithRenderingMode:UIImageRenderingModeAutomatic];
        
        _bgImageView.image = bgImage;
        
    }
    
    return _bgImageView;
}

- (MLLinkLabel *)likeLabel
{
    if (!_likeLabel) {
        
        _likeLabel = [MLLinkLabel new];
        
        [self addSubview:_likeLabel];
        
        _likeLabel.font = [UIFont systemFontOfSize:14];
        
        _likeLabel.linkTextAttributes = @{NSForegroundColorAttributeName : CellHighlightedColor};
        
        _likeLabel.isAttributedContent = YES;
    }
    
    return _likeLabel;
}

- (UIView *)likeLableBottomLine
{
    if (!_likeLableBottomLine) {
        
        _likeLableBottomLine = [UIView new];
        
        [self addSubview:_likeLableBottomLine];
    }
    
    return _likeLableBottomLine;
}

- (NSMutableArray *)commentLabelsArray
{
    if (!_commentLabelsArray) {
        
        _commentLabelsArray = [NSMutableArray array];
    }
    
    return _commentLabelsArray;
}

#pragma mark - setter
- (void)setCommentItemsArray:(NSArray *)commentItemsArray
{
    _commentItemsArray = commentItemsArray;
    NSInteger originalLabelsCount = self.commentLabelsArray.count;
    NSInteger needsToAddCount = commentItemsArray.count > originalLabelsCount ? (commentItemsArray.count - originalLabelsCount) : 0;
    for (int i = 0; i < needsToAddCount; i++) {
        MLLinkLabel *label = [MLLinkLabel new];
        UIColor *highLightColor = CellHighlightedColor;
        label.linkTextAttributes = @{NSForegroundColorAttributeName : highLightColor};
        label.font = [UIFont systemFontOfSize:14];
        label.delegate = self;
        [self addSubview:label];
        [self.commentLabelsArray addObject:label];
    }
    
    for (int i = 0; i < commentItemsArray.count; i++) {
        CircleFriendCommentModel *model = commentItemsArray[i];
        MLLinkLabel *label = self.commentLabelsArray[i];
        if (!model.attributedContent) {
            model.attributedContent = [self generateAttributedStringWithCommentItemModel:model];
        }
        label.attributedText = model.attributedContent;
    }
}

- (void)setLikeItemsArray:(NSArray *)likeItemsArray
{
    _likeItemsArray = likeItemsArray;
    
    NSTextAttachment *attach = [NSTextAttachment new];
    attach.image = [UIImage imageNamed:@"Like"];
    attach.bounds = CGRectMake(0, -3, 16, 16);
    NSAttributedString *likeIcon = [NSAttributedString attributedStringWithAttachment:attach];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:likeIcon];
    
    for (int i = 0; i < likeItemsArray.count; i++) {
        CircleFriendLikeModel *model = likeItemsArray[i];
        if (i > 0) {
            [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"，"]];
        }
        if (!model.attributedContent) {
            model.attributedContent = [self generateAttributedStringWithLikeItemModel:model];
        }
        [attributedText appendAttributedString:model.attributedContent];
    }
    
    self.likeLabel.attributedText = [attributedText copy];
}
@end
