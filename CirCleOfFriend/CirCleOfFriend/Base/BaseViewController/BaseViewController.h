//
//  BaseViewController.h
//  CirCleOfFriend
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  宏指针定义 __nonnull 类型
 *
 */
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

/**
 *  打印日志情况默认YES
 */
@property(nonatomic, assign)BOOL MGBasePrintLog;

/**
 *  是否开启全继承左滑返回手势 默认NO
 */
@property(nonatomic, assign)BOOL MGOpenTheLeftBackOfAll;

/**
 *  屏幕高
 */
@property(nonatomic, assign)CGFloat MGScreenHight;

/**
 *  屏幕宽
 */
@property(nonatomic, assign)CGFloat MGScreenWidth;

/**
 *  基类请求数据
 */
- (void)MGBaseRequestData;

/**
 *  设置导航条
 *
 *  @param titleStr 导航标题
 */
- (void)setNavigationBar:(NSString *)titleStr;

/**
 *  基类添加右图片按钮
 *
 *  @param image image类型
 */
- (void)MGBaseAddRightBtnWithImage:(UIImage * )image;

/**
 *  基类右图片按钮触发方法
 *
 *  @param sender UIButton
 */
- (void)MGBaseClickBaseRightImageBtn:(UIButton * )sender;

/**
 *  基类添加右系统风格按钮
 *
 *  @param type UIBarButtonSystemItem类型
 */
- (void)MGBaseAddRightBtnWithType:(UIBarButtonSystemItem)type;

/**
 *  基类右图片按钮触发方法
 *
 *  @param sender UIBarButtonItem
 */
- (void)MGBaseClickBaseRightTypeBtn:(UIBarButtonItem * )sender;

/**
 *  AlertView警告框
 *
 *  @param message 警告消息
 */
- (void)MGBasePopUpWarningAlertViewWithMessage:(NSString * )message;

/**
 *  AlertView提示框
 *
 *  @param message 提示信息
 *  @param target  代理
 */
- (void)MGBasePopUpPromptAlertViewWithMessage:(NSString * )message addTarget:(nullable id)target;

/**
 *  开启左滑返回上一页手势(当OpenTheLeftBackOfAll失效时可以调用，特殊情况需要在viewDidAppear:(BOOL)animated中加入    [super viewDidAppear:animated] 方法即可
 */
- (void)MGBaseOpenTheLeftBackSkip;

@end

/**
 *  宏指针定义下文
 */
NS_ASSUME_NONNULL_END
