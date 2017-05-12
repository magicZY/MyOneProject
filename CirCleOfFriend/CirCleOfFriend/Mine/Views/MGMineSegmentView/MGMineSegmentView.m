//
//  MGMineSegmentView.m
//  CirCleOfFriend
//
//  Created by apple on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MGMineSegmentView.h"
#import "UIView+SDAutoLayout.h"

@interface MGMineSegmentView()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) UIView *segmentView;
@property (nonatomic, strong) UIScrollView *segmentScrollView;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UILabel *downLabel;
@end

@implementation MGMineSegmentView

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    [UIView animateWithDuration:0.2 animations:^{
//        CGPoint frame = self.line.center;
//        frame.x = self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)*(self.segmentScrollView.contentOffset.x/self.frame.size.width);
//        self.line.center = frame;
//    }];
    UIButton * btn = (UIButton*)[self.segmentView viewWithTag:(self.segmentScrollView.contentOffset.x/self.frame.size.width)];
    self.selectButton.selected = NO;
    self.selectButton = btn;
    self.selectButton.selected = YES;
}


#pragma mark - Public
- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray *)controllers titleArray:(NSArray *)titleArray ParentController:(UIViewController *)parentC lineWidth:(float)lineW lineHeight:(float)lineH
{
    self = [super initWithFrame:frame];
    if (self) {
        self.controllers = controllers;
        self.nameArray = titleArray;
        [self setupView:parentC];
    }
    
    return self;
}

#pragma mark - Private
- (void)setupView:(UIViewController *)parentVC
{
    for (int i = 0; i < self.controllers.count; i++) {
        
        UIViewController *controller = self.controllers[i];
        [self.segmentScrollView addSubview:controller.view];
        
        controller.view.sd_layout
        .leftSpaceToView(self.segmentScrollView, i*self.width)
        .topEqualToView(self.segmentScrollView)
        .widthIs(self.width)
        .heightIs(self.height);
        
        [parentVC addChildViewController:controller];
        [controller didMoveToParentViewController:parentVC];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(self.width/self.controllers.count), 0, self.width/self.controllers.count, 41);
        btn.tag = i;
        [btn setTitle:self.nameArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        btn.selected = i == 0 ? YES : NO;
        
        [self.segmentView addSubview:btn];
    }
    
    self.downLabel.backgroundColor = [UIColor grayColor];
}

- (void)Click:(UIButton*)sender
{
    self.selectButton.titleLabel.font = [UIFont systemFontOfSize:15];;
    self.selectButton.selected = NO;
    self.selectButton = sender;
    self.selectButton.selected = YES;
    self.selectButton.titleLabel.font = [UIFont systemFontOfSize:15];;
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame = self.line.center;
        frame.x = self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)* (sender.tag);
        self.line.center = frame;
    }];
    [self.segmentScrollView setContentOffset:CGPointMake((sender.tag)*self.frame.size.width, 0) animated:YES ];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectVC" object:sender userInfo:nil];
}

#pragma mark - Getter
- (UIView *)segmentView
{
    if (!_segmentView) {
        
        _segmentView = [UIView new];
        [self addSubview:_segmentView];
        _segmentView.tag = 1000+50;
        
        _segmentView.sd_layout
        .leftEqualToView(self)
        .rightEqualToView(self)
        .topEqualToView(self)
        .heightIs(41);
    }
    
    return _segmentView;
}

- (UIScrollView *)segmentScrollView
{
    if (!_segmentScrollView) {
        
        _segmentScrollView = [UIScrollView new];
        [self addSubview:_segmentScrollView];
        _segmentScrollView.contentSize = CGSizeMake(self.width * self.controllers.count, 0);
        _segmentScrollView.delegate = self;
        _segmentScrollView.showsHorizontalScrollIndicator = NO;
        _segmentScrollView.bounces = NO;
        
        _segmentScrollView.sd_layout
        .leftEqualToView(self)
        .topSpaceToView(self, 41)
        .rightEqualToView(self)
        .bottomSpaceToView(self, -41);
    }
    
    return _segmentScrollView;
}

- (UILabel *)downLabel
{
    if (!_downLabel) {
        
        _downLabel = [UILabel new];
        
        [_segmentView addSubview:_downLabel];
        
        _downLabel.sd_layout
        .leftEqualToView(_segmentView)
        .rightEqualToView(_segmentView)
        .bottomEqualToView(_segmentView)
        .heightIs(1);
    }
    
    return _downLabel;
}
#pragma mark - Setter
@end
