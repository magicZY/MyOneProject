//
//  MGTableViewDelegate.h
//  CirCleOfFriend
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

//此类用于将UITableViewDelegate，UITableViewDataSource中的方法抽象出来，从而对viewcontroller进行“瘦身”
//采用block来回调tableview代理


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//注册cell回调
typedef void (^TableViewCellConfigureBlock)(NSIndexPath *indexPath, id item, UITableViewCell *cell);;

//cell高度回调
typedef CGFloat (^CellHeightBlock)(NSIndexPath *indexPath, id item);

//cell点击回调
typedef void (^DidSelectCellBlock)(NSIndexPath *indexPath, id item);

@interface MGTableViewDelegate : NSObject <UITableViewDelegate,UITableViewDataSource>

// 初始化方法: 传数据源, cellIdentifier, 三个block分别对应配置, 行高, 点击 .
- (id)initWithItems:(NSArray *)items
      cellIdentifier:(NSString *)cellIdentifier
      configureCellBlick:(TableViewCellConfigureBlock)ConfigureCellBlock
      cellHeightBlock:(CellHeightBlock)HeightBlock
      didSelectBlock:(DidSelectCellBlock)didselectBlock;

//将UITableViewDataSource和UITableViewDelegate设于MGTableViewDelegate
- (void)handleTableViewDatasourceAndDelegate:(UITableView *)table;

//默认indexPath.row对应每个dataSource .相应返回item
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
@end
