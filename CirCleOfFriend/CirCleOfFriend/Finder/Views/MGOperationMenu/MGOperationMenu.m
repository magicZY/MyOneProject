//
//  MGOperationMenu.m
//  CirCleOfFriend
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#define MGColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

#import "MGOperationMenu.h"
#import "UIView+SDAutoLayout.h"

@interface MGOperationMenu ()
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIView *centerLine;
@end

@implementation MGOperationMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        [self setUp];
    }
    
    return self;
}

- (void)setUp
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
    self.backgroundColor = MGColor(69, 74, 76, 1);
    
    self.likeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    
    self.centerLine.backgroundColor = [UIColor grayColor];
    
    self.commentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
}

#pragma - Private
- (UIButton *)createButtonWithTittle:(NSString *)title image:(UIImage *)image setImage:(UIImage *)setImage target:(id)target selector:(SEL)sel
{
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateSelected];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
//    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    return btn;
}

- (void)likeButtonClicked
{
}

- (void)commentButtonClicked
{}

#pragma mark - getter
- (UIButton *)likeButton
{
    if (!_likeButton) {
    
        _likeButton = [self createButtonWithTittle:@"赞" image:[UIImage imageNamed:@"Like"] setImage:[UIImage imageNamed:@""] target:self selector:@selector(likeButtonClicked)];
        
        [self addSubview:_likeButton];
        
        _likeButton.sd_layout
        .leftSpaceToView(self, 5)
        .topEqualToView(self)
        .bottomEqualToView(self)
        .widthIs(80);
        
    }
    
    return _likeButton;
}

- (UIView *)centerLine
{
    if (!_centerLine) {
        
        _centerLine = [UIView new];
        
        [self addSubview:_centerLine];
        
        _centerLine.sd_layout
        .leftSpaceToView(_likeButton, 5)
        .topSpaceToView(self, 5)
        .bottomSpaceToView(self, 5)
        .widthIs(1);
    }
    return _centerLine;
}

- (UIButton *)commentButton
{
    if (!_commentButton) {
        
        _commentButton = [self createButtonWithTittle:@"评论" image:[UIImage imageNamed:@"Comment"] setImage:[UIImage imageNamed:@""] target:self selector:@selector(likeButtonClicked)];
        
        [self addSubview:_commentButton];

        _commentButton.sd_layout
        .leftSpaceToView(_centerLine, 5)
        .topEqualToView(_likeButton)
        .bottomEqualToView(_likeButton)
        .widthRatioToView(_likeButton, 1);
    }
    
    return _commentButton;
}

#pragma mark - setter
- (void)setShow:(BOOL)show
{
    _show = show;
    
    [UIView animateWithDuration:0.2 animations:^{
        if (!show) {
            [self clearAutoWidthSettings];
            self.sd_layout
            .widthIs(0);
        } else {
            self.fixedWidth = nil;
            [self setupAutoWidthWithRightView:_commentButton rightMargin:5];
        }
        [self updateLayoutWithCellContentView:self.superview];
    }];
}
@end
