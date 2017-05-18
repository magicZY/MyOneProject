//
//  MGTableViewDelegate.m
//  CirCleOfFriend
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MGTableViewDelegate.h"
#import "CircleFriendCell.h"
#import "UITableViewCell+Extension.h"
#import "SDAutoLayout.h"

@interface MGTableViewDelegate ()<CircleFriendCellDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    CGFloat keybordHeight;
    NSIndexPath *_currentEditingIndexthPath;
    BOOL _isReplayingComment;
    NSString *_commentToUser;
    NSString *_commentToUserId;
}
@property (nonatomic, strong) NSArray *Items;
@property (nonatomic, strong) UITableView *currentTable;
@property (nonatomic, strong) UITextField *commentTextField;
@property (nonatomic, copy) NSString *MGCellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;
@property (nonatomic, copy) CellHeightBlock heightBlock;
@property (nonatomic, copy) DidSelectCellBlock DidselectBlock;

@end

@implementation MGTableViewDelegate

- (id)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlick:(TableViewCellConfigureBlock)ConfigureCellBlock cellHeightBlock:(CellHeightBlock)HeightBlock didSelectBlock:(DidSelectCellBlock)didselectBlock
{
    self = [super init];
    if (self) {
        
        self.Items = items;
        self.MGCellIdentifier = cellIdentifier;
        self.configureCellBlock = ConfigureCellBlock;
        self.heightBlock = HeightBlock;
        self.DidselectBlock = didselectBlock;
        
        [self addNSNotificationCenter];

    }
    
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.Items[(int)indexPath.row];
}

- (void)handleTableViewDatasourceAndDelegate:(UITableView *)table
{
    self.currentTable = table;
    table.delegate = self;
    table.dataSource = self;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.Items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;
    CircleFriendCell *cell = [[CircleFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.MGCellIdentifier];
//    [tableView dequeueReusableCellWithIdentifier:self.MGCellIdentifier];

    if (!cell) {
        [UITableViewCell registerTableView:tableView registerClass:[CircleFriendCell class] reuseIdentifier:self.MGCellIdentifier];
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.MGCellIdentifier];

    }
    self.configureCellBlock(indexPath,item,cell);
    return cell ;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(CircleFriendCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    cell.indexPath = indexPath;

    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            CircleFriendModel *model = weakSelf.Items[indexPath.row];
            model.isOpening = !model.isOpening;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];

        cell.delegate = self;
    }

    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;
    return self.heightBlock(indexPath,item) ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;
    self.DidselectBlock(indexPath,item) ;
}

#pragma mark - CircleFriendCellDelegate
- (void)didClickLikeInCell:(UITableViewCell *)cell
{
    NSLog(@"-----like");
    
    NSIndexPath *indexPath = [self.currentTable indexPathForCell:cell];
    CircleFriendModel *model = self.Items[indexPath.row];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:model.likeAr];
    
    if (!model.isLiked) {
        
        CircleFriendLikeModel *likeModel = [CircleFriendLikeModel new];
        likeModel.likeUserName = @"金三胖";
        likeModel.userId = @"MG_iOS";
        [temp addObject:likeModel];
        model.liked = YES;
    }else {
        CircleFriendLikeModel *tempLikeModel = nil;
        for (CircleFriendLikeModel *likeModel in model.likeAr) {
            if ([likeModel.userId isEqualToString:@"MG_iOS"]) {
                tempLikeModel = likeModel;
                break;
            }
        }
        [temp removeObject:tempLikeModel];
        model.liked = NO;
    }
    
    model.likeAr = [temp copy];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.currentTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    });
}

- (void)didClickcCommentInCell:(UITableViewCell *)cell
{
    NSLog(@"-----comment");
    [self.commentTextField becomeFirstResponder];

    _currentEditingIndexthPath = [self.currentTable indexPathForCell:cell];

    [self adjustTableViewToFitKeyboard];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"beaginScorller");
    [self.commentTextField resignFirstResponder];
}

#pragma mark - Private
- (void)addNSNotificationCenter
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGRect textFieldRect = CGRectMake(0, rect.origin.y - 40, rect.size.width, 40);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = rect;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _commentTextField.frame = textFieldRect;
    }];
    
    CGFloat h = rect.size.height + 40;
    if (keybordHeight != h) {
        keybordHeight = h;
        [self adjustTableViewToFitKeyboard];
    }
}

- (void)adjustTableViewToFitKeyboard
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITableViewCell *cell = [_currentTable cellForRowAtIndexPath:_currentEditingIndexthPath];
    CGRect rect = [cell.superview convertRect:cell.frame toView:window];
    [self adjustTableViewToFitKeyboardWithRect:rect];
}

- (void)adjustTableViewToFitKeyboardWithRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat delta = CGRectGetMaxY(rect) - (window.bounds.size.height - keybordHeight);
    
    CGPoint offset = _currentTable.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    
    [_currentTable setContentOffset:offset animated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        [self.commentTextField resignFirstResponder];
        
        CircleFriendModel *model = self.Items[_currentEditingIndexthPath.row];
        NSMutableArray *temp = [NSMutableArray new];
        [temp addObjectsFromArray:model.commentsAr];
        CircleFriendCommentModel *commentItemModel = [CircleFriendCommentModel new];
        
        if (_isReplayingComment) {
            commentItemModel.commentsUsername = @"金三胖";
            commentItemModel.commentsUserId = @"MG_iOS";
            commentItemModel.toUsername = _commentToUser;
            commentItemModel.toUserid = _commentToUserId;
            commentItemModel.commentsContent = textField.text;
            
            _isReplayingComment = NO;
        } else {
            commentItemModel.commentsUsername = @"金三胖";
            commentItemModel.commentsContent = textField.text;
            commentItemModel.commentsUserId = @"MG_iOS";
        }
        [temp addObject:commentItemModel];
        model.commentsAr = [temp copy];
        [self.currentTable reloadRowsAtIndexPaths:@[_currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone];
        
        _commentTextField.text = @"";
        _commentTextField.placeholder = nil;
        
        return YES;
    }
    return NO;
}


#pragma mark - getter
- (UITextField *)commentTextField
{
    if (!_commentTextField) {
        
        _commentTextField = [UITextField new];
        _commentTextField.returnKeyType = UIReturnKeyDone;
        _commentTextField.delegate = self;
        _commentTextField.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8].CGColor;
        _commentTextField.layer.borderWidth = 1;
        _commentTextField.backgroundColor = [UIColor grayColor];
        
        _commentTextField.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 40);
        
        [[UIApplication sharedApplication].keyWindow addSubview:_commentTextField];
        
        [_commentTextField becomeFirstResponder];
        [_commentTextField resignFirstResponder];
        
    }
    
    return _commentTextField;
}
@end
