//
//  BaseViewController.m
//  CirCleOfFriend
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController


#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    //设置基类初始属性
    [self settingsViewControllerAttribute];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 设置基类加载属性
    [self SetTheLoadProperties];
}

#pragma mark - Public

- (void)setNavigationBar:(NSString *)titleStr
{
    self.title = titleStr;
}

/**
 *  左滑返回手势
 */
- (void)MGBaseOpenTheLeftBackSkip
{
    // 获取系统自带滑动手势的target对象.
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法.
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发.
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势.
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势.
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}


/**
 *  数据请求
 */
- (void)MGBaseRequestData
{
    
}

/**
 *  添加右按钮
 *
 *  @param image 图片
 */
- (void)MGBaseAddRightBtnWithImage:(UIImage *)image
{
    UIButton *baseRightImageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [baseRightImageButton setBackgroundImage:image forState:UIControlStateNormal];
    [baseRightImageButton addTarget:self action:@selector(MGBaseClickBaseRightImageBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:baseRightImageButton];
}

/**
 *  基类右图片按钮触发方法
 *
 *  @param sender UIButton
 */
- (void)MGBaseClickBaseRightImageBtn:(UIButton * )sender
{

}

/**
 *  添加右按钮
 *
 *  @param type 系统风格
 */
- (void)MGBaseAddRightBtnWithType:(UIBarButtonSystemItem)type
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:type target:self action:@selector(MGBaseClickBaseRightTypeBtn:)];
}

- (void)MGBaseClickBaseRightTypeBtn:(UIBarButtonItem *)sender
{
}

- (void)MGBaseAddTitleLableWithTitle:(NSString *)title
{
}

/**
 *  弹出警告框
 *
 *  @param message 警告信息
 */
- (void)axcBasePopUpWarningAlertViewWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    if (_MGBasePrintLog) {
        NSLog(@"BaseViewController:\n弹出弹出警告框\t方法名：axcBasePopUpWarningAlertViewWithMessage:\t当前message:%@\n",message);
    }
    [alertView show];
}

/**
 *  弹出提示框
 *
 *  @param message 提示信息
 *  @param target  代理
 */
- (void)axcBasePopUpPromptAlertViewWithMessage:(NSString *)message addTarget:(nullable id)target
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:target cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    if (_MGBasePrintLog) {
        NSLog(@"BaseViewController:\n弹出提示框\t方法名：axcBasePopUpPromptAlertViewWithMessage:addTarget\t当前message:%@\n",message);
    }
    [alertView show];
}


#pragma mark - Private

- (void)settingsViewControllerAttribute
{
    
    // 设置每个子类的背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置子类的NavBar上的渲染颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // 改变NavBar底层View的颜色
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    // 改变NavBar顶层View的颜色
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    // 设置子类的Tabbar风格
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    // 设置取消ScrollerView自适应属性
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置tabbar选中的渲染颜色
    [self.navigationController.tabBarController.tabBar setTintColor:COLOR(220, 9, 64, 1)];
    // 选择打印当前日志
    [self performSelector:@selector(printNSLog) withObject:nil afterDelay:1.0f];
}

- (void)SetTheLoadProperties
{
    // 将默认关闭全继承左滑返回手势
    if (_MGOpenTheLeftBackOfAll)
    {
        if (_MGBasePrintLog)
        {
            NSLog(@"BaseViewController:\n开启了全继承左滑返回手势\n");
        }
        [self MGBaseOpenTheLeftBackSkip];
    }
}


/**
 *  返回手势代理
 *
 *  @param gestureRecognizer gestureRecognizer
 *
 *  @return BOOL
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势
        return NO;
    }
    return YES;
}
/**
 *  返回方法
 *
 */
- (void)handleNavigationTransition:(UIPanGestureRecognizer *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)printNSLog
{
    if (_MGBasePrintLog)
    {
        printf("\n----------------=开始设置当前界面属性默认值=----------------\n");
        NSLog(@"BaseViewController:\n设置当前子类的背景颜色为：\t白色\n");
        NSLog(@"BaseViewController:\n设置当前子类的NavBar上的渲染颜色为：\t白色\n");
        NSLog(@"BaseViewController:\n设置当前的Tabbar风格为：\tUIBarStyleBlack\n");
        NSLog(@"BaseViewController:\n设置当前取消ScrollerView自适应属性：\tautomaticallyAdjustsScrollViewInsets = NO\n");
        NSLog(@"BaseViewController:\n设置当前tabbar选中的渲染颜色：\t红色：RGBA：220，9，64，1\n");
        printf("----------------=当前界面属性的默认值设置完毕=----------------\n\n");
    }
}

#pragma mark - Getter

/**
 *  懒加载赋值屏幕高
 *
 *  @return 屏幕高
 */
- (CGFloat)MGScreenHight
{
    if (_MGScreenHight == 0) {
        _MGScreenHight = [UIScreen mainScreen].bounds.size.height;
    }
    return _MGScreenHight;
}
/**
 *  懒加载赋值屏幕宽
 *
 *  @return 屏幕宽
 */
- (CGFloat)MGScreenWidth
{
    if (_MGScreenWidth == 0) {
        _MGScreenWidth = [UIScreen mainScreen].bounds.size.width;
    }
    return _MGScreenWidth;
}

#pragma mark - Setter

@end
