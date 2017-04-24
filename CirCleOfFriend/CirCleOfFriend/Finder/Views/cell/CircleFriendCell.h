//
//  CircleFriendCell.h
//  CirCleOfFriend
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleFriendModel.h"

@class CircleFriendModel;

@interface CircleFriendCell : UITableViewCell

@property (nonatomic, strong) CircleFriendModel *dataModel;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
