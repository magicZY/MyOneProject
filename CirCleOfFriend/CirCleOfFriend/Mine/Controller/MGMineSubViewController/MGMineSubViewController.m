//
//  MGMineSubViewController.m
//  CirCleOfFriend
//
//  Created by apple on 2017/5/12.
//  Copyright © 2017年 apple. All rights reserved.
//
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#import "MGMineSubViewController.h"

@interface MGMineSubViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MGMineSubViewController
#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.contentTableView.backgroundColor = [UIColor clearColor];
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    cell.textLabel.text = @"123";
    return cell;
}
#pragma mark - Public

#pragma mark - Private

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Getter
- (UITableView *)contentTableView
{
    if (!_contentTableView) {
        
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-41)];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        _contentTableView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_contentTableView];
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _contentTableView;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark - Setter

@end
