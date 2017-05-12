//
//  MGMineHeaderView.m
//  CirCleOfFriend
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MGMineHeaderView.h"
#import "UIView+SDAutoLayout.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@interface MGMineHeaderView()
@property (nonatomic, strong) UIImageView *bgImageView;//背景
@property (nonatomic, strong) UIImageView *avatarImage; //头像


@end

@implementation MGMineHeaderView

#pragma mark - Public
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpViews];
    }
    return self;
}

- (void)setImageFrame:(UIScrollView *)scrollView
{
    _bgImageView.frame = CGRectMake(0+scrollView.contentOffset.y, +scrollView.contentOffset.y, self.width-scrollView.contentOffset.y*2, 205 -scrollView.contentOffset.y*1);
}

#pragma mark - Private
- (void)setUpViews
{
    self.bgImageView.image = [UIImage imageNamed:@"10.jpg"];
    
    self.avatarImage.image = [UIImage imageNamed:@"18.jpg"];
}
#pragma mark - Getter
- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        
        _bgImageView = [UIImageView new];
        
        [self addSubview:_bgImageView];

        _bgImageView.frame = CGRectMake(0, 0, ScreenWidth, 205);
        
    }
    return _bgImageView;
}

- (UIImageView *)avatarImage
{
    if (!_avatarImage) {
        
        _avatarImage = [UIImageView new];
        
        [self addSubview:_avatarImage];
        
        _avatarImage.sd_layout
        .centerXEqualToView(self)
        .topSpaceToView(self, 50)
        .heightIs(68)
        .widthIs(68);
        
        _avatarImage.layer.masksToBounds = YES;
        _avatarImage.layer.cornerRadius = 34.0f;
        _avatarImage.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImage.clipsToBounds = YES;
        
    }
    
    return _avatarImage;
}
#pragma mark - Setter
@end
