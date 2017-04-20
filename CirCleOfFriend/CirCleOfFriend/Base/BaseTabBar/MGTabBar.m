//
//  MGTabBar.m
//  CirCleOfFriend
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MGTabBar.h"
#import "MGTabBarButton.h"

#define RGBA(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define TextNoColor RGBA(170, 170, 170)
#define TextEnbleColor RGBA(16, 156, 231)

@interface MGTabBar ()
//tabBar点击动画方式
@property (nonatomic, assign)MGTabBarAnimationStyle style;

/** buttonItems，有多少控制器就有多少*/
@property (nonatomic, strong)NSMutableArray *buttonsAr;

/** 当前选中的buttonItem*/
@property (nonatomic, weak)UIButton *selectedButton;

@end

@implementation MGTabBar


#pragma mark - Public
- (instancetype)initWithFrame:(CGRect)frame AnimationStyle:(MGTabBarAnimationStyle)style {

    self = [super initWithFrame:frame];
    if (self) {
        _style = style;
    }
    return self;
}


#pragma mark - Private

- (void)itemButtonClick:(UIButton *)sender {

    if ([_delegate respondsToSelector:@selector(tabBar:didSelectedItemFrom:to:)]) {
        
        [_delegate tabBar:self didSelectedItemFrom:self.selectedButton.tag to:sender.tag];
    }

    //交换当前处于点击状态的item
    _selectedButton.selected = NO;
    sender.selected = YES;
    _selectedButton = sender;
    
    [self layoutSubviewsAnimated:YES];

}

//执行动画
- (void)layoutSubviewsAnimated:(BOOL)animated {
    
    //设置每个tabBarButton的frame
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0.0;
    CGFloat btnW = w / self.buttonsAr.count;
    
    CGFloat btnMin = w / (self.buttonsAr.count + .5);
    
    MGTabBarButton *lastBtn = nil;
    
    for (MGTabBarButton *btn in self.buttonsAr) {
        
        if (_style == MGTabBarAnimationStyleTranslation) btnW = btn.isSelected ? btnMin*1.5 : btnMin;
        
        btnX = CGRectGetMaxX(lastBtn.frame);
        
        if (animated) {
            
            [UIView animateWithDuration:.3 animations:^{
                
                btn.frame = CGRectMake(btnX, 0, btnW, h);
            }];
            
        }else {
        
            btn.frame = CGRectMake(btnX, 0, btnW, h);
        }
            
        lastBtn = btn;
    }
    

}


#pragma mark - Getter

- (NSMutableArray *)buttonsAr {

    if (!_buttonsAr) {
        
        _buttonsAr = [NSMutableArray array];
    }
    
    return _buttonsAr;
}

#pragma mark - Setter

//设置对应的item
- (void)setItems:(NSArray *)items {

    _items = items;
    
    for (UITabBarItem *item in items) {
        
        MGTabBarButton *itemButton = [MGTabBarButton buttonWithType:UIButtonTypeCustom];
        
        if (_style == MGTabBarAnimationStyleScale)  itemButton.isShowTitle = YES;
            
        [itemButton setTitleColor:TextNoColor forState:UIControlStateNormal];
        [itemButton setTitleColor:TextEnbleColor forState:UIControlStateSelected];
        
        itemButton.item = item;
        
        itemButton.tag = self.buttonsAr.count;
        
        [itemButton addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:itemButton];
        
        [self.buttonsAr addObject:itemButton];
        
    }
    
    [self itemButtonClick:self.buttonsAr[0]];
    
    [self layoutSubviewsAnimated:NO];
}

@end
