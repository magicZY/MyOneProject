//
//  MGMineViewController.m
//  CirCleOfFriend
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MGMineViewController.h"
#import "MGMainTouchTableTableView.h"
#import "UIView+SDAutoLayout.h"
#import "MGMineHeaderView.h"
#import "MGMineSegmentView.h"
#import "MGMineSubViewController.h"

@interface MGMineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isTopIsCanNotMoveTabViewPre;
    BOOL _isTopIsCanNotMoveTabView;
    BOOL _canScroll;
    CGFloat currentAlpha;
}
@property (nonatomic, strong) MGMainTouchTableTableView *mainTableView;
@property (nonatomic, strong) MGMineHeaderView *headerView;
@property (nonatomic, strong) MGMineSegmentView *segmentView;
@end

@implementation MGMineViewController
#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar:@"个人中心"];
    currentAlpha = 0.0f;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];
    [self setupView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.alpha = currentAlpha;
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.height - 64;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:self.setSubViewControllers];
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /*
     ** 联动处理
     */
    
    //获取视图滚动的偏移量
    CGFloat tabOffsetY = [self.mainTableView rectForSection:0].origin.y - 64;
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%f",scrollView.contentOffset.x);
    _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
    if (offsetY >= tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        _isTopIsCanNotMoveTabView = YES;
    }else _isTopIsCanNotMoveTabView = NO;
    
    if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {
        if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {
            //滑动到顶端
            [[NSNotificationCenter defaultCenter] postNotificationName:@"goTop" object:nil userInfo:@{@"canScroll":@"1"}];
            _canScroll = NO;
        }
        
        if (!_isTopIsCanNotMoveTabView && _isTopIsCanNotMoveTabViewPre) {
            //离开顶端
            if (!_canScroll) scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        }
    }
    
    if (scrollView.contentOffset.y < 0) {
        
        [_headerView setImageFrame:scrollView];
    }
    currentAlpha = (scrollView.contentOffset.y / 205) * 2;
    self.navigationController.navigationBar.alpha = currentAlpha;
    
}
#pragma mark - Public

#pragma mark - Private
- (void)setupView
{
    self.mainTableView.tableHeaderView = self.headerView;
}

- (UIView *)setSubViewControllers
{
    if (!_segmentView) {
        MGMineSubViewController *vc1 = [MGMineSubViewController new];
        vc1.view.backgroundColor = [UIColor redColor];
        
        MGMineSubViewController *vc2 = [MGMineSubViewController new];
        vc2.view.backgroundColor = [UIColor blueColor];
        
        NSArray *controllers = @[vc1,vc2];
        
        NSArray *titleArray = @[@"帖子",@"回复"];
        
        MGMineSegmentView *rcs = [[MGMineSegmentView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-64) controllers:controllers titleArray:titleArray ParentController:self lineWidth:self.view.width/5 lineHeight:2];
        
        _segmentView = rcs;
    }
    return _segmentView;

}

-(void)acceptMsg:(NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Getter
- (MGMainTouchTableTableView *)mainTableView
{
    if (!_mainTableView) {
        
        _mainTableView = [MGMainTouchTableTableView new];
        [self.view addSubview:_mainTableView];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.showsHorizontalScrollIndicator = NO;

        _mainTableView.sd_layout
        .leftEqualToView(self.view)
        .topEqualToView(self.view)
        .bottomEqualToView(self.view)
        .rightEqualToView(self.view);

    }
    
    return _mainTableView;
}

- (MGMineHeaderView *)headerView
{
    if (!_headerView) {
        
        _headerView = [MGMineHeaderView new];
        [self.view addSubview:_headerView];
        
        _headerView.sd_layout
        .heightIs(205)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view);
        
    }
    
    return _headerView;
}


#pragma mark - Setter






@end
