//
//  MGBaseTabBarController.m
//  CirCleOfFriend
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MGBaseTabBarController.h"
#import "MGTabBar.h"
#import "CircleFriendViewController.h"
#import "MGMineViewController.h"

@interface MGBaseTabBarController ()<MGTabBarDelegate>

/** 所有子控制器的tabBarItem*/
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation MGBaseTabBarController


#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加自控制器
    [self setUpAllChildViewController];
    
    
    // 设置tabBar
    [self setUpTabBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自带的tabBarButton
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if (![tabBarButton isKindOfClass:[MGTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
    }
}

#pragma mark - Public

#pragma mark - Private

- (void)setUpAllChildViewController {
    
    UIViewController *news = [[UIViewController alloc] init];
    news.view.backgroundColor = [UIColor redColor];
    [self setOneChildViewController:news withImage:[UIImage imageNamed:@"tabbar1"] selectedImage:[UIImage imageNamed:@"tabbar1_selected"] title:@"圈子"];
    
    UIViewController *friends = [[UIViewController alloc] init];
    friends.view.backgroundColor = [UIColor whiteColor];
    [self setOneChildViewController:friends withImage:[UIImage imageNamed:@"tabbar2"] selectedImage:[UIImage imageNamed:@"tabbar2_selected"] title:@"活动"];
    
    CircleFriendViewController *quiz = [[CircleFriendViewController alloc] init];
    quiz.view.backgroundColor = [UIColor purpleColor];
    [self setOneChildViewController:quiz withImage:[UIImage imageNamed:@"tabbar3"] selectedImage:[UIImage imageNamed:@"tabbar3_selected"] title:@"发现"];
    
    MGMineViewController *more = [[MGMineViewController alloc] init];
    [self setOneChildViewController:more withImage:[UIImage imageNamed:@"tabbar4"] selectedImage:[UIImage imageNamed:@"tabbar4_selected"] title:@"我的"];

}

- (void)setOneChildViewController:(UIViewController *)viewController withImage:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
//    viewController.title = title;
    
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = image;
    viewController.tabBarItem.selectedImage = selectedImage;
    
    [self.items addObject:viewController.tabBarItem];
    
    UINavigationController *nvg = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self addChildViewController:nvg];
    
}

- (void)setUpTabBar
{
    MGTabBar *tabBar = [[MGTabBar alloc] initWithFrame:self.tabBar.bounds AnimationStyle:MGTabBarAnimationStyleTranslation];

    tabBar.delegate = self;

    tabBar.items = self.items;

    [self.tabBar addSubview:tabBar];
    
}

#pragma mark - Getter

- (NSMutableArray *)items {

    if (!_items) {
        
        _items = [NSMutableArray array];
    }
    
    return _items;
}

#pragma mark - Setter

#pragma mark - MGTabBarDelegate

- (void)tabBar:(MGTabBar *)tabBar didSelectedItemFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}

@end
