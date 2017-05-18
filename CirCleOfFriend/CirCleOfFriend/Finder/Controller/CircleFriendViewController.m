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

//新加入
#import "MGTableViewDelegate.h"
#import "UITableViewCell+Extension.h"

@interface CircleFriendViewController ()

@property (nonatomic, strong) UITableView *circleFriendTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) MGTableViewDelegate *tableHander;
@end

@implementation CircleFriendViewController


#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigationBar:@"朋友圈"];
    
    [self.dataSource addObjectsFromArray:[self createModelWithCount:10]];
    
    [self setupTableView];
}

#pragma mark - Public

#pragma mark - Private

//初始化tableview
- (void)setupTableView
{
    self.circleFriendTableView.backgroundColor = [UIColor whiteColor];
    
    TableViewCellConfigureBlock configureCell = ^(NSIndexPath *indexPath, CircleFriendModel *obj, UITableViewCell *cell) {
        [cell configure:cell customObj:obj indexPath:indexPath];
    } ;
    
    CellHeightBlock heightBlock = ^CGFloat(NSIndexPath *indexPath, id item) {
        return [CircleFriendCell getCellHeightWithTableView:self.circleFriendTableView CustomObj:item indexPath:indexPath];
    };
    
    DidSelectCellBlock selectedBlock = ^(NSIndexPath *indexPath, id item) {
        NSLog(@"click row : %@",@(indexPath.row)) ;
    } ;
    
    self.tableHander = [[MGTableViewDelegate alloc] initWithItems:self.dataSource cellIdentifier:@"circleCell" configureCellBlick:configureCell cellHeightBlock:heightBlock didSelectBlock:selectedBlock];
    
    [self.tableHander handleTableViewDatasourceAndDelegate:self.circleFriendTableView];
}

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
                            @"哇哈哈",
                            @"我叫刘继芬",
                            @"Hello Kitty"];
    
    NSArray *textArray = @[@"　清扫心灵是一种挣扎与奋斗的过程。人生是一个不断挥手的旅程，少年要告别家乡，伤心人要告别伤心地，雄鹰要告别安逸，快乐要告别悲伤。没有告别，就没有成长，要坚强，就要勇于转身，离别是为了更好地相聚。",
                           @"成功的人不要怕挨骂，因为只要你做事，就会出错，就会触动一些人，就会引起某些人的不满。事实上，能有50%的人赞成你就很不错了，世上极少有百分之百的事情，越美的东东西越容易打碎。要锻炼自己正确对待反对的能力，要勇敢地主动去征询反对意见。不要抱怨反对者，他完全可以有他的看法，这是他的自由，与你无关。不必费力气去和他争辩，赶路要紧。",
                           @"“你不可能因为给人一个微笑而丧失什么，因为它永远会再回来”。东西怎么出去，就会怎么回来。没有人不喜欢微笑。但问题是使人微笑的事物往往不在身边，而令你烦躁、不安的事物却往往挥之不去。不能与自己喜欢的人和事在一起，是许多人不快乐的根本原因，因为你没有快乐的来源。曾经有段日子，我很惆怅，我喜欢的女孩不在乎我，我精心做的稿子被改来改去，我的身体也出了问题，感冒不时地光顾我，我的生活一塌糊涂。这时我的好朋友对我说：“输什么也不能输了心情，有些事情放了吧”。我决定改变。我不再找那个女孩，那篇稿子我立即投往别处，我也告别了一度懒散而无规律的生活，每天开始打球和跑步。结果，我的身体变得健美起来，我的那篇稿子很快被发表，而且还得了奖，我不再“在乎”了的那个女孩开始在乎起了我……一个人或事能令你不舒服是一定有着什么原因的，有的原因要过很久你才有可能知道，而有些原因你永远都不会知道，但这些都并不重要，重要的是它使你不舒服，他会影响你的心情，影响到你的判断，也影响到你的时间。给别人一个重新认识你的机会，给自己一个认识更广阔世界的机会，有什么不好？",
                           @"你可曾有这样的实验：当你在等一辆计程车时，它就是不出现？而且等其他的东西似乎也总是如此。因此俗彦有云：“时时掀盖来，煮水久不开。",
                           @"为了活到现在，我们该扩张自己的感官，体会现在这每一刻的种种美妙之处。每一分，每一秒，每个人都可以自由的选择，是否要真正生活到现在，吸收周围的一切，让自己受感动，受影响。"
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

#pragma mark - Getter
- (UITableView *)circleFriendTableView
{
    if (!_circleFriendTableView)
    {
        _circleFriendTableView = [[UITableView alloc] init];
        
        _circleFriendTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
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
