//
//  CircleFriendCell.m
//  CirCleOfFriend
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CircleFriendCell.h"
#import "UIView+SDAutoLayout.h"

CGFloat maxContentLabelHeight = 0; // 根据具体font而定

@interface CircleFriendCell()
{
    
}
@property (nonatomic, strong)UIImageView *avatar; //头像
@property (nonatomic, strong)UILabel *nameLabel; //名字
@property (nonatomic, strong)UILabel *contentLabel; //内容
@end

@implementation CircleFriendCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        //设置主题
//        [self configTheme];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup
{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

#pragma mark - getter

- (UIImageView *)avatar
{
    if (!_avatar)
    {
        _avatar = [UIImageView new];
        [self.contentView addSubview:_avatar];
        _avatar.sd_layout.leftSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 15)
        .widthIs(40)
        .heightIs(40);
    }
    
    return _avatar;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [UILabel new];
        [self.contentView addSubview:_nameLabel];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
        _nameLabel.sd_layout
        .leftSpaceToView(_avatar, 10)
        .topEqualToView(_avatar)
        .heightIs(18);
        [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    }
    
    return _nameLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [UILabel new];
        [self.contentView addSubview:_contentLabel];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.numberOfLines = 0;
        if (maxContentLabelHeight == 0) {
            maxContentLabelHeight = _contentLabel.font.lineHeight * 3;
        }
        _contentLabel.sd_layout
        .leftEqualToView(_nameLabel)
        .topSpaceToView(_nameLabel, 10)
        .rightSpaceToView(self.contentView, 10)
        .autoHeightRatio(0);
    }
    
    return _contentLabel;
}

#pragma mark - setter

- (void)setDataModel:(CircleFriendModel *)dataModel
{
    _dataModel = dataModel;
    self.avatar.image = [UIImage imageNamed:dataModel.avatar];
    self.nameLabel.text = dataModel.username;
    self.contentLabel.text = dataModel.content;
    
    if (dataModel.shouldShowMoreButton) { // 如果文字高度超过60
//        _moreButton.sd_layout.heightIs(20);
//        _moreButton.hidden = NO;
        self.contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
//        if (dataModel.isOpening) { // 如果需要展开
//            _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
////            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
//        } else {
//            _contentLabel.sd_layout.maxHeightIs(maxContentLabelHeight);
////            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
//        }
    } else {
//        _moreButton.sd_layout.heightIs(0);
//        _moreButton.hidden = YES;
    }
    
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:15];
}
@end
