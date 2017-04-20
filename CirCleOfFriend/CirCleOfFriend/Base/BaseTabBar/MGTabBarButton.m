//
//  MGTabBarButton.m
//  CirCleOfFriend
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MGTabBarButton.h"

@interface MGTabBarButton ()

@end

@implementation MGTabBarButton

#pragma mark - Public
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        // 图片，文字居中
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    
    return self;
}

#pragma mark - Private

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    //设置自己的title
    [self setTitle:_item.title forState:UIControlStateNormal];
    
    //设置自己的image
    [self setImage:_item.image forState:UIControlStateNormal];
    
    //设置自己的image（选择状态）
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
}

//重写布局
- (void)layoutSubviews {

    [super layoutSubviews];
    
    CGFloat imageRatio = 0.7;
    
    CGFloat imgX = 0;
    CGFloat imgY = 0;
    CGFloat imgW = CGRectGetWidth(self.frame);
    CGFloat imgH = (self.isSelected || _isShowTitle) ? CGRectGetHeight(self.frame) * imageRatio : CGRectGetHeight(self.frame);
    self.imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGFloat ttlY = CGRectGetHeight(self.frame) * imageRatio;
    CGFloat ttlW = CGRectGetWidth(self.frame);
    CGFloat ttlH = CGRectGetHeight(self.frame) * 0.2;
    
    if (_isShowTitle) {
        self.titleLabel.frame = CGRectMake(0, 0, ttlW, ttlH);
    }
    
    self.titleLabel.center = CGPointMake(ttlW/2.f, ttlY + ttlH/2.f);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.titleLabel.alpha = _isShowTitle || self.isSelected;
    }];
}

- (void)selectedScaleAnimation:(BOOL)selected
{
    [UIView animateWithDuration:0.3 animations:^{
        if (selected) {
            self.imageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
            self.titleLabel.transform = CGAffineTransformMakeScale(1.1, 1.1);
            self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        } else {
            self.imageView.transform = CGAffineTransformIdentity;
            self.titleLabel.transform = CGAffineTransformIdentity;
            self.titleLabel.font = [UIFont systemFontOfSize:12];
        }
    }];
}

- (void)selectedTranslationAnimation:(BOOL)selected
{
    // TODO:
}

#pragma mark - Getter

#pragma mark - Setter

// 传递UITabBarItem给UITabBarButton进行内容赋值，使用KVO
- (void)setItem:(UITabBarItem *)item {
    
    _item = item;
    
    //情况监听的内容
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    // 使用KVO 监听item各项值得变化
    // 观察者：self(UITabBarButton)，只要UITabBarItem的值发生变化，就通知UITabBarButton修改相应控件的值
    /**
     *  给item添加观察者self
     *
     *  @param observer NSObject 观察者
     *  @param keyPath NSString 要监听的属性的名称
     *  @param options NSKeyValueObservingOptions 监听值变化的方式
     *  @param context 上下文
     */
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    
    if (_isShowTitle) [self selectedScaleAnimation:selected];
    
    else [self selectedTranslationAnimation:selected];
    
}
@end
