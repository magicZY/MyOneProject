//
//  UITableViewCell+Extension.m
//  CirCleOfFriend
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UITableViewCell+Extension.h"

@implementation UITableViewCell (Extension)


#pragma mark --
+ (UINib *)nibWithIdentifier:(NSString *)identifier
{
    return [UINib nibWithNibName:identifier bundle:nil];
}

#pragma mark - Public
+ (void)registerTable:(UITableView *)table
        nibIdentifier:(NSString *)identifier
{
    [table registerNib:[self nibWithIdentifier:identifier] forCellReuseIdentifier:identifier];

}

+ (void)registerTableView:(UITableView *)table registerClass:(Class)cellCalss reuseIdentifier:(NSString *)identifier
{
    [table registerClass:cellCalss forCellReuseIdentifier:identifier];
}


#pragma mark - Rewrite these func in SubClass !
- (void)configure:(UITableViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath
{
    // Rewrite this func in SubClass !
    
}

+ (CGFloat)getCellHeightWithTableView:(UITableView *)table
                            CustomObj:(id)obj
                            indexPath:(NSIndexPath *)indexPath
{
    // Rewrite this func in SubClass if necessary
    if (!obj) {
        return 0.0f ; // if obj is null .
    }
    return 44.0f ; // default cell height
}
@end
