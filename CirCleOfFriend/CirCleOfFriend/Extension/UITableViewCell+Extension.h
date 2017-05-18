//
//  UITableViewCell+Extension.h
//  CirCleOfFriend
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Extension)

//xib使用
+ (void)registerTable:(UITableView *)table
        nibIdentifier:(NSString *)identifier ;

//代码使用
+ (void)registerTableView:(UITableView *)table registerClass:(Class)cellCalss reuseIdentifier:(NSString *)identifier;

- (void)configure:(UITableViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath ;

+ (CGFloat)getCellHeightWithTableView:(UITableView *)table
                            CustomObj:(id)obj
                            indexPath:(NSIndexPath *)indexPath;
@end
