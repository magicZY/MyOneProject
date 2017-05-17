//
//  GuidePageViewController.m
//  CirCleOfFriend
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#define ScreenWidth [UIApplication sharedApplication].keyWindow.bounds.size.width
#define ScreenHeight [UIApplication sharedApplication].keyWindow.bounds.size.height

#import "GuidePageViewController.h"

@interface GuidePageViewController ()<UIScrollViewDelegate>
{
    CGFloat offsetX;
    
    UIImageView *pageOneImageView;
    UIImageView *pageOneImage1;
    UIImageView *pageOneImage2;
    UIImageView *pageOneImage3;
    UIImageView *pageOneImage4;
    UIImageView *pageOneImage5;
    
    UIImageView *pageTwoImageView;
    UIImageView *pageTwoImage1;
    UIImageView *pageTwoImage2;
    UIImageView *pageTwoImage3;
    UIImageView *pageTwoImage4;
    UIImageView *pageTwoImage5;
    
    UIImageView *pageThreeImageView;
    UIImageView *pageThreeImage1;
    UIImageView *pageThreeImage2;
    UIImageView *pageThreeImage3;
    UIImageView *pageThreeImage4;
    UIImageView *pageThreeImage5;
    
    UIImageView *pageFourImageView;
    UIImageView *pageFourImage1;
    UIImageView *pageFourImage2;
    UIImageView *pageFourImage3;
    UIImageView *pageFourImage4;
    
    UIImageView *runImageView;
}
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *pageScrollView;
@property (nonatomic, strong) UIButton *pushButton;
@end

@implementation GuidePageViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithWhite:0.152 alpha:1.000];
    //初始化视图
    [self setUpView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    offsetX = scrollView.contentOffset.x;
    NSLog(@"%f",offsetX);
    int page = offsetX / scrollView.bounds.size.width + 0.5;
    
     //此处写动画
    if (offsetX <= ScreenWidth/2) {
        [self firstPage];
    }
    else if (offsetX > ScreenWidth/2 && offsetX <= ScreenWidth+ScreenWidth/2) {
        [self secondPage];
    }
    else if (offsetX > ScreenWidth+ScreenWidth/2 && offsetX <= ScreenWidth*2+ScreenWidth/2) {
        [self thirdPage];
    }
    else if (offsetX > ScreenWidth*2+ScreenWidth/2 && offsetX <= ScreenWidth*3+ScreenWidth/2) {
        [self lastPage];
    }
    
    self.pageControl.currentPage = page;
}

#pragma mark - Public

#pragma mark - Private
- (void)setUpView
{
    CGFloat imageW = self.pageScrollView.bounds.size.width;
    CGFloat imageH = self.pageScrollView.bounds.size.height;
    
    pageOneImageView = [UIImageView new];
    pageOneImageView.frame = CGRectMake(0*imageW, 0, imageW, imageH);
    [self.pageScrollView addSubview:pageOneImageView];
    
    pageTwoImageView = [UIImageView new];
    pageTwoImageView.frame = CGRectMake(1*imageW, 0, imageW, imageH);
    [self.pageScrollView addSubview:pageTwoImageView];
    
    pageThreeImageView = [UIImageView new];
    pageThreeImageView.frame = CGRectMake(2*imageW, 0, imageW, imageH);
    [self.pageScrollView addSubview:pageThreeImageView];
    
    pageFourImageView = [UIImageView new];
    pageFourImageView.frame = CGRectMake(3*imageW, 0, imageW, imageH);
    [self.pageScrollView addSubview:pageFourImageView];
    
    [self.pushButton setTitle:@"进入APP" forState:UIControlStateNormal];
    
    self.pageControl.backgroundColor = [UIColor clearColor];
    
    //1
    pageOneImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, imageW, 30)];
    pageOneImage1.image = [UIImage imageNamed:@"1_01"];
    [pageOneImageView addSubview:pageOneImage1];
    
    pageOneImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, imageW, imageW)];
    pageOneImage2.image = [UIImage imageNamed:@"1_02"];
    [pageOneImageView addSubview:pageOneImage2];
    
    pageOneImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 120, imageW, imageW/4)];
    pageOneImage3.image = [UIImage imageNamed:@"1_03"];
    [pageOneImageView addSubview:pageOneImage3];
    
    pageOneImage4 = [[UIImageView alloc]initWithFrame:CGRectMake(imageW/6, CGRectGetMaxY(pageOneImage2.frame)+10, imageW*2/3, 50)];
    pageOneImage4.image = [UIImage imageNamed:@"1_04"];
    [pageOneImageView addSubview:pageOneImage4];
    
    pageOneImage5 = [[UIImageView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(pageOneImage4.frame)+10, imageW-80, 40)];
    pageOneImage5.image = [UIImage imageNamed:@"1_05"];
    [pageOneImageView addSubview:pageOneImage5];
    
    //2
    pageOneImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, imageW, 30)];
    pageOneImage1.image = [UIImage imageNamed:@"1_01"];
    [pageTwoImageView addSubview:pageOneImage1];
    
    pageTwoImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(-imageW/2, 100-imageW/2, imageW*2, imageW*2)];
    pageTwoImage1.image = [UIImage imageNamed:@"2_01"];
    [pageTwoImageView addSubview:pageTwoImage1];
    
    pageTwoImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(pageTwoImage1.frame)+10, imageW, 60)];
    pageTwoImage2.image = [UIImage imageNamed:@"2_02"];
    [pageTwoImageView addSubview:pageTwoImage2];
    
    pageTwoImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(pageTwoImage2.frame)+10, imageW, 30)];
    pageTwoImage3.image = [UIImage imageNamed:@"2_03"];
    [pageTwoImageView addSubview:pageTwoImage3];
    
    //3
    pageOneImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, imageW, 30)];
    pageOneImage1.image = [UIImage imageNamed:@"1_01"];
    [pageThreeImageView addSubview:pageOneImage1];
    
    pageThreeImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, imageW, imageW*31/36)];
    pageThreeImage1.image = [UIImage imageNamed:@"3_01"];
    [pageThreeImageView addSubview:pageThreeImage1];
    
    pageThreeImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(imageW, 100, imageW, imageW*31/36)];
    pageThreeImage2.image = [UIImage imageNamed:@"3_02"];
    [pageThreeImageView addSubview:pageThreeImage2];
    
    pageThreeImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(imageW/2, 100, imageW, imageW*31/36)];
    pageThreeImage3.image = [UIImage imageNamed:@"3_03"];
    [pageThreeImageView addSubview:pageThreeImage3];
    
    pageThreeImage4 = [[UIImageView alloc]initWithFrame:CGRectMake(10, imageH, imageW-20, 60)];
    pageThreeImage4.image = [UIImage imageNamed:@"3_04"];
    pageThreeImage4.alpha = 0;
    [pageThreeImageView addSubview:pageThreeImage4];
    
    pageThreeImage5 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(pageThreeImage4.frame)+15, imageW, 40)];
    pageThreeImage5.image = [UIImage imageNamed:@"3_05"];
    pageThreeImage5.alpha = 0;
    [pageThreeImageView addSubview:pageThreeImage5];
    
    //4
    pageFourImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 50-300, imageW-30, 70)];
    pageFourImage1.image = [UIImage imageNamed:@"5_01"];
    [pageFourImageView addSubview:pageFourImage1];
    
    pageFourImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(55, CGRectGetMaxY(pageFourImage1.frame)+10-300, imageW-110, 10)];
    pageFourImage2.image = [UIImage imageNamed:@"5_02"];
    pageFourImage2.alpha = 0;
    [pageFourImageView addSubview:pageFourImage2];
    
    pageFourImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(imageW/4, imageH-imageW/2-60+300, imageW/2, imageW/4)];
    pageFourImage3.image = [UIImage imageNamed:@"5_03"];
    pageFourImage3.alpha = 0;
    [pageFourImageView addSubview:pageFourImage3];
    
    pageFourImage4 = [[UIImageView alloc]initWithFrame:CGRectMake(-imageW/2, imageH-imageW*5/4, imageW*4, imageW*4)];
    pageFourImage4.image = [UIImage imageNamed:@"5_05"];
    pageFourImage4.alpha = 0;
    [self rotate360DegreeWithImageView:pageFourImage4];
    [pageFourImageView addSubview:pageFourImage4];
    
    runImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, imageH-imageW*4/5, 30-30, 30-30)];
    [self tomAnimationWithName:@"run" count:9];
    runImageView.alpha = 0;
    [pageFourImageView addSubview:runImageView];
}

- (void)firstPage
{
    NSLog(@"1");
    pageOneImageView.alpha = 1;
    pageTwoImageView.alpha = 0;
    
    pageOneImage2.alpha = (ScreenWidth/2-offsetX)/(ScreenWidth/2);
    
    pageOneImage3.frame = CGRectMake(0+ScreenWidth*offsetX/ScreenWidth, 120+ScreenWidth/2*offsetX/ScreenWidth, ScreenWidth-ScreenWidth*offsetX/(ScreenWidth/2), ScreenWidth/4-ScreenWidth/4*offsetX/(ScreenWidth/2));
    pageOneImage3.alpha = (ScreenWidth/2-offsetX)/(ScreenWidth/2);
    
    pageOneImage4.frame = CGRectMake(ScreenWidth/6+ScreenWidth*offsetX/ScreenWidth, CGRectGetMaxY(pageOneImage2.frame)+10+ScreenHeight/2*offsetX/ScreenWidth, ScreenWidth*2/3, 50);
    pageOneImage4.alpha = (ScreenWidth/2-offsetX)/(ScreenWidth/2);
    
    pageOneImage5.frame = CGRectMake(40+ScreenWidth*offsetX/ScreenWidth, CGRectGetMaxY(pageOneImage4.frame)+10+10*offsetX/ScreenWidth, ScreenWidth-80, 40);
    pageOneImage5.alpha = (ScreenWidth/2-offsetX)/(ScreenWidth/2);
}

- (void)secondPage
{
    NSLog(@"2");
    pageOneImageView.alpha = 0;
    pageTwoImageView.alpha = (offsetX-ScreenWidth/2)/(ScreenWidth/2);
    
    if (offsetX <= ScreenWidth) {
        pageTwoImage1.frame = CGRectMake(-ScreenWidth/2+ScreenWidth/2*offsetX/ScreenWidth, 100-ScreenWidth/2+ScreenWidth/2*offsetX/ScreenWidth, ScreenWidth*2-ScreenWidth*offsetX/ScreenWidth, ScreenWidth*2-ScreenWidth*offsetX/ScreenWidth);
        pageTwoImage2.frame = CGRectMake(0, CGRectGetMaxY(pageTwoImage1.frame)+10, ScreenWidth, 60);
        pageTwoImage3.frame = CGRectMake(0, CGRectGetMaxY(pageTwoImage2.frame)+10, ScreenWidth, 30);
    }
    else{
        pageTwoImage1.frame = CGRectMake(
                                         ScreenWidth*(offsetX-ScreenWidth)/ScreenWidth+(ScreenWidth/4+13)*(offsetX-ScreenWidth)/ScreenWidth,
                                         
                                         100+ScreenWidth/10*(offsetX-ScreenWidth)/ScreenWidth,
                                         
                                         ScreenWidth-(ScreenWidth/2+25)*(offsetX-ScreenWidth)/ScreenWidth,
                                         
                                         ScreenWidth-(ScreenWidth/2+25)*(offsetX-ScreenWidth)/ScreenWidth
                                         );
        pageTwoImage2.frame = CGRectMake(0, CGRectGetMaxY(pageTwoImage1.frame)+10, ScreenWidth, 60);
        pageTwoImage2.alpha = 1-(offsetX-ScreenWidth)/(ScreenWidth/2);
        pageTwoImage3.frame = CGRectMake(0, CGRectGetMaxY(pageTwoImage2.frame)+10, ScreenWidth, 30);
        pageTwoImage3.alpha = 1-(offsetX-ScreenWidth)/(ScreenWidth/2);
    }
}

- (void)thirdPage
{
    NSLog(@"3");
    pageFourImageView.alpha = 0;
    
    if (offsetX <= ScreenWidth*2) {
        pageTwoImage1.frame = CGRectMake(ScreenWidth*(offsetX-ScreenWidth)/ScreenWidth+(ScreenWidth/4+13)*(offsetX-ScreenWidth)/ScreenWidth, 100+ScreenWidth/10*(offsetX-ScreenWidth)/ScreenWidth, ScreenWidth-(ScreenWidth/2+25)*(offsetX-ScreenWidth)/ScreenWidth, ScreenWidth-(ScreenWidth/2+25)*(offsetX-ScreenWidth)/ScreenWidth);
        
        pageThreeImage2.frame = CGRectMake(ScreenWidth-offsetX+ScreenWidth, 100, ScreenWidth, ScreenWidth*31/36);
        
        pageThreeImage3.frame = CGRectMake(ScreenWidth-offsetX+ScreenWidth, 100, ScreenWidth, ScreenWidth*31/36);
        
        pageThreeImage4.frame = CGRectMake(10, ScreenHeight-200*(offsetX-ScreenWidth)/ScreenWidth, ScreenWidth-20, 60);
        pageThreeImage4.alpha = (offsetX-ScreenWidth*3/2)/(ScreenWidth/2);
        
        pageThreeImage5.frame = CGRectMake(0, CGRectGetMaxY(pageThreeImage4.frame)+15, ScreenWidth, 40);
        pageThreeImage5.alpha = (offsetX-ScreenWidth*3/2)/(ScreenWidth/2);
    }
    else{
        pageTwoImage1.frame = CGRectMake(
                                         (offsetX-ScreenWidth)+(ScreenWidth/4+13)*(offsetX-ScreenWidth)/ScreenWidth,
                                         
                                         100+ScreenWidth/10*(offsetX-ScreenWidth)/ScreenWidth,
                                         
                                         ScreenWidth-(ScreenWidth/2+25)*(offsetX-ScreenWidth)/ScreenWidth,
                                         
                                         ScreenWidth-(ScreenWidth/2+25)*(offsetX-ScreenWidth)/ScreenWidth
                                         );
        pageTwoImage1.alpha = 1-(offsetX-ScreenWidth*2)/(ScreenWidth/2);
        
        pageThreeImage1.frame = CGRectMake((offsetX-ScreenWidth*2)+(ScreenWidth/2)*(offsetX-ScreenWidth*2)/ScreenWidth, 100+(ScreenWidth/4+13)*(offsetX-ScreenWidth*2)/ScreenHeight, ScreenWidth*(1-(offsetX-ScreenWidth*2)/ScreenWidth), ScreenWidth*31/36*(1-(offsetX-ScreenWidth*2)/ScreenWidth));
        
        pageThreeImage2.frame = CGRectMake((offsetX-ScreenWidth*2)+(ScreenWidth/2)*(offsetX-ScreenWidth*2)/ScreenWidth, 100+(ScreenWidth/4+13)*(offsetX-ScreenWidth*2)/ScreenHeight, ScreenWidth*(1-(offsetX-ScreenWidth*2)/ScreenWidth), ScreenWidth*31/36*(1-(offsetX-ScreenWidth*2)/ScreenWidth));
        
        pageThreeImage3.frame = CGRectMake((offsetX-ScreenWidth*2)+(ScreenWidth/2)*(offsetX-ScreenWidth*2)/ScreenWidth, 100+(ScreenWidth/4+13)*(offsetX-ScreenWidth*2)/ScreenHeight, ScreenWidth*(1-(offsetX-ScreenWidth*2)/ScreenWidth), ScreenWidth*31/36*(1-(offsetX-ScreenWidth*2)/ScreenWidth));
        
        pageThreeImage4.frame = CGRectMake(10+(offsetX-ScreenWidth*2)+(ScreenWidth/2)*(offsetX-ScreenWidth*2)/ScreenWidth, ScreenHeight-200+(ScreenWidth/4+13)*(offsetX-ScreenWidth*2)/ScreenHeight, (ScreenWidth-20)*(1-(offsetX-ScreenWidth*2)/ScreenWidth), 60*(1-(offsetX-ScreenWidth*2)/ScreenWidth));
        
        pageThreeImage5.frame = CGRectMake((offsetX-ScreenWidth*2)+(ScreenWidth/2)*(offsetX-ScreenWidth*2)/ScreenWidth, CGRectGetMaxY(pageThreeImage4.frame)+15, ScreenWidth*(1-(offsetX-ScreenWidth*2)/ScreenWidth), 40*(1-(offsetX-ScreenWidth*2)/ScreenWidth));
        
        pageThreeImageView.alpha = 1-(offsetX-ScreenWidth*2)/(ScreenWidth/2);
    }
}

- (void)lastPage
{
    NSLog(@"5");
    pageThreeImageView.alpha = 0;
    pageFourImageView.alpha = 1;
    
    pageFourImage1.frame = CGRectMake(15+ScreenWidth*(offsetX-ScreenWidth*3)/ScreenWidth, 50-300*(ScreenWidth*3-offsetX)/ScreenWidth, ScreenWidth-30, 70);
    pageFourImage1.alpha = (offsetX-ScreenWidth*2-ScreenWidth/2)/(ScreenWidth/2);
    
    pageFourImage2.frame = CGRectMake(55+ScreenWidth*(offsetX-ScreenWidth*3)/ScreenWidth, CGRectGetMaxY(pageFourImage1.frame)+10-10*(ScreenWidth*3-offsetX)/ScreenWidth, ScreenWidth-110, 10);
    pageFourImage2.alpha = (offsetX-ScreenWidth*2-ScreenWidth/2)/(ScreenWidth/2);
    
    pageFourImage3.frame = CGRectMake(ScreenWidth/4+ScreenWidth*(offsetX-ScreenWidth*3)/ScreenWidth, ScreenHeight-ScreenWidth/2-60-300*(offsetX-ScreenWidth*3)/ScreenWidth, ScreenWidth/2, ScreenWidth/4);
    pageFourImage1.alpha = (offsetX-ScreenWidth*2-ScreenWidth/2)/(ScreenWidth/2);
    
    pageFourImage4.frame = CGRectMake(-ScreenWidth/2+ScreenWidth*2*(offsetX-ScreenWidth*3)/ScreenWidth, ScreenHeight-ScreenWidth*5/4, ScreenWidth*4-ScreenWidth*2*(offsetX-ScreenWidth*2)/ScreenWidth, ScreenWidth*4-ScreenWidth*2*(offsetX-ScreenWidth*2)/ScreenWidth);
    pageFourImage4.alpha = (offsetX-ScreenWidth*2-ScreenWidth/2)/(ScreenWidth/2);
    
    runImageView.frame = CGRectMake(50+(offsetX-ScreenWidth*3), ScreenHeight-ScreenWidth*4/5, 30+30*(offsetX-ScreenWidth*3)/ScreenWidth, 30+30*(offsetX-ScreenWidth*3)/ScreenWidth);
    runImageView.alpha = (offsetX-ScreenWidth*2-ScreenWidth/2)/(ScreenWidth/2);
    
    [pageFourImageView bringSubviewToFront:_pushButton];
}

// UIImageView显示gif动画
- (void)tomAnimationWithName:(NSString *)name count:(NSInteger)count
{
    // 如果正在动画，直接退出
    if ([runImageView isAnimating]) return;
    // 动画图片的数组
    NSMutableArray *arrayM = [NSMutableArray array];
    // 添加动画播放的图片
    for (int i = 0; i < count; i++) {
        // 图像名称
        NSString *imageName = [NSString stringWithFormat:@"%@%d.png", name, i+1];
        // ContentsOfFile需要全路径
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [arrayM addObject:image];
    }
    // 设置动画数组
    runImageView.animationImages = arrayM;
    // 重复1次
    runImageView.animationRepeatCount = 0;
    // 动画时长
    runImageView.animationDuration = runImageView.animationImages.count * 0.05;
    // 开始动画
    [runImageView startAnimating];
}

// 旋转动画
- (void)rotate360DegreeWithImageView:(UIImageView *)imageView
{
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:
                         CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0) ];
    animation.duration = 5;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    //在图片边缘添加一个像素的透明区域，去图片锯齿
    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
    UIGraphicsBeginImageContext(imageRrect.size);
    [imageView.image drawInRect:CGRectMake(1,1,imageView.frame.size.width-2,imageView.frame.size.height-2)];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [imageView.layer addAnimation:animation forKey:nil];
}

#pragma mark - Private Action

/**
 *  跳转控制器
 */
- (void)getstart
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGEROOTVC" object:nil];
}
#pragma mark - Getter
- (UIScrollView *)pageScrollView
{
    if (!_pageScrollView) {
    
        _pageScrollView = [UIScrollView new];
        [self.view addSubview:_pageScrollView];
        _pageScrollView.delegate = self;
        _pageScrollView.frame = self.view.bounds;
        _pageScrollView.contentSize = CGSizeMake(self.view.bounds.size.width*4, 0);
        _pageScrollView.pagingEnabled = YES;
        _pageScrollView.bounces = NO;
        _pageScrollView.showsHorizontalScrollIndicator = NO;
    }
    
    return _pageScrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        
        _pageControl = [UIPageControl new];
        [self.view addSubview:_pageControl];
        _pageControl.numberOfPages = 4;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:189.0/255.0 green:189.0/255.0 blue:189.0/255.0 alpha:1];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:241/255.0 green:99/255.0 blue:43/255.0 alpha:1];
        _pageControl.bounds = CGRectMake(0, 0, 100, 30);
        _pageControl.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height-20);
        _pageControl.userInteractionEnabled = NO;

    }
    
    return _pageControl;
}

- (UIButton *)pushButton
{
    if (!_pushButton) {
        _pushButton = [UIButton new];
        [pageFourImageView addSubview:_pushButton];
        _pushButton.frame = CGRectMake(0, 0, 150, 30);
        _pushButton.layer.borderWidth = 1.0;
        _pushButton.layer.borderColor = [UIColor colorWithWhite:0.915 alpha:1.000].CGColor;
        _pushButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_pushButton addTarget:self action:@selector(getstart) forControlEvents:UIControlEventTouchUpInside];
        CGFloat centerX = pageFourImageView.bounds.size.width * 0.5;
        CGFloat centerY = pageFourImageView.bounds.size.height - 88;
        _pushButton.center = CGPointMake(centerX, centerY);
        pageFourImageView.userInteractionEnabled = YES;
    }
    
    return _pushButton;
}
#pragma mark - Setter

@end
