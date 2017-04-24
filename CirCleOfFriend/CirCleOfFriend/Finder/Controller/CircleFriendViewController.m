//
//  CircleFriendViewController.m
//  CirCleOfFriend
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CircleFriendViewController.h"
#import "SDAutoLayout.h"
#import "CircleFriendCell.h"
#import "CircleFriendModel.h"


@interface CircleFriendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *circleFriendTableView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation CircleFriendViewController


#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigationBar:@"朋友圈"];
    
    [self.dataSource addObjectsFromArray:[self createModelWithCount:10]];
    
    self.circleFriendTableView.backgroundColor = [UIColor whiteColor];
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"circleCell";
    
    CircleFriendCell *cell = [[CircleFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(CircleFriendCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    cell.indexPath = indexPath;
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    cell.dataModel = self.dataSource[indexPath.row];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.dataSource[indexPath.row];
    
    CGFloat cellHeight = [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"dataModel" cellClass:[CircleFriendCell class] contentViewWidth:[self cellContentViewWith]];
    
    return cellHeight;
    
}

#pragma mark - Public

#pragma mark - Private

- (NSArray *)createModelWithCount:(NSInteger)count
{
    NSArray *iconImageNamesArray = @[@"10.jpg",
                                     @"11.jpg",
                                     @"12.jpg",
                                     @"13.jpg",
                                     @"14.jpg",
                                     ];
    
    NSArray *namesArray = @[@"张三",
                            @"风口上的猪",
                            @"当今世界网名都不好起了",
                            @"我叫刘继芬",
                            @"Hello Kitty"];
    
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，https://github.com/gsdios/SDAutoLayout大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，https://github.com/gsdios/SDAutoLayout等于把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    NSArray *commentsArray = @[@"社会主义好！👌👌👌👌",
                               @"正宗好凉茶，正宗好声音。。。",
                               @"你好，我好，大家好才是真的好",
                               @"有意思",
                               @"你瞅啥？",
                               @"瞅你咋地？？？！！！",
                               @"hello，看我",
                               @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真",
                               @"人艰不拆",
                               @"咯咯哒",
                               @"呵呵~~~~~~~~",
                               @"我勒个去，啥世道啊",
                               @"真有意思啊你💢💢💢"];
    
    NSArray *picImageNamesArray = @[ @"10.jpg",
                                     @"11.jpg",
                                     @"12.jpg",
                                     @"13.jpg",
                                     @"14.jpg",
                                     @"15.jpg",
                                     @"16.jpg",
                                     @"17.jpg",
                                     @"18.jpg"
                                     ];
    
    NSArray *timeArray = @[@"1分钟前"
                           ];
    
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        
        CircleFriendModel *model = [CircleFriendModel new];
        model.avatar = iconImageNamesArray[iconRandomIndex];
        model.username = namesArray[nameRandomIndex];
        model.content = textArray[contentRandomIndex];
        model.time = timeArray[0];
        
        // 模拟“随机图片”
        int random = arc4random_uniform(6);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNameAr = [temp copy];
        }
        
        // 模拟随机评论数据
        int commentRandom = arc4random_uniform(3);
        NSMutableArray *tempComments = [NSMutableArray new];
        for (int i = 0; i < commentRandom; i++) {
            CircleFriendCommentModel *commentItemModel = [CircleFriendCommentModel new];
            int index = arc4random_uniform((int)namesArray.count);
            commentItemModel.commentsUsername = namesArray[index];
            commentItemModel.commentsUserId = @"666";
            if (arc4random_uniform(10) < 5) {
                commentItemModel.toUsername = namesArray[arc4random_uniform((int)namesArray.count)];
                commentItemModel.toUserid = @"888";
            }
            commentItemModel.commentsContent = commentsArray[arc4random_uniform((int)commentsArray.count)];
            [tempComments addObject:commentItemModel];
        }
        model.commentsAr = [tempComments copy];
        
        // 模拟随机点赞数据
        int likeRandom = arc4random_uniform(3);
        NSMutableArray *tempLikes = [NSMutableArray new];
        for (int i = 0; i < likeRandom; i++) {
            CircleFriendLikeModel *model = [CircleFriendLikeModel new];
            int index = arc4random_uniform((int)namesArray.count);
            model.likeUserName = namesArray[index];
            model.userId = namesArray[index];
            [tempLikes addObject:model];
        }
        
        model.likeAr = [tempLikes copy];
        
        [resArr addObject:model];
    }
    return [resArr copy];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

#pragma mark - Getter
- (UITableView *)circleFriendTableView
{
    if (!_circleFriendTableView)
    {
        _circleFriendTableView = [[UITableView alloc] init];
        
        _circleFriendTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _circleFriendTableView.delegate = self;
        
        _circleFriendTableView.dataSource = self;
        
        [self.view addSubview:_circleFriendTableView];
        
        _circleFriendTableView.sd_layout
        .leftEqualToView(self.view)
        .topSpaceToView(self.view, 64)
        .rightEqualToView(self.view)
        .bottomSpaceToView(self.view, 50);
        
    }
    
    return _circleFriendTableView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

#pragma mark - Setter


@end
