//
//  CircleFriendCell.m
//  CirCleOfFriend
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CircleFriendCell.h"
#import "UIView+SDAutoLayout.h"
#import "MGPhotoContainerView.h"

CGFloat maxContentLabelHeight = 0; // 根据具体font而定

@interface CircleFriendCell()
{
    
}
@property (nonatomic, strong) UIImageView *avatar; //头像
@property (nonatomic, strong) UILabel *nameLabel; //名字
@property (nonatomic, strong) UILabel *contentLabel; //内容
@property (nonatomic, strong) UIButton *moreButton; //收起展开按钮
@property (nonatomic, strong) MGPhotoContainerView *picContainerView;
@end

@implementation CircleFriendCell

//[[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
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

- (UIButton *)moreButton
{
    if (!_moreButton)
    {
        _moreButton = [UIButton new];
        [self.contentView addSubview:_moreButton];
        [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        [_moreButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        _moreButton.sd_layout
        .leftEqualToView(_contentLabel)
        .topSpaceToView(_contentLabel, 0)
        .widthIs(30);
    }
    
    return _moreButton;

}

- (MGPhotoContainerView *)picContainerView
{
    if (!_picContainerView) {
        
        _picContainerView = [MGPhotoContainerView new];
        
        [self.contentView addSubview:_picContainerView];
        
        _picContainerView.sd_layout
        .leftEqualToView(_contentLabel); // 已经在内部实现宽度和高度自适应所以不需要再设置宽度高度，top值是具体有无图片在setModel方法中设置
    }
    
    return _picContainerView;
    
}

#pragma mark - setter

- (void)setDataModel:(CircleFriendModel *)dataModel
{
    _dataModel = dataModel;
    self.avatar.image = [UIImage imageNamed:dataModel.avatar];
    self.nameLabel.text = dataModel.username;
    self.contentLabel.text = dataModel.content;
    self.picContainerView.picPathStringsArray = dataModel.picNameAr;
    
    if (dataModel.shouldShowMoreButton) { // 如果文字高度超过60
        self.moreButton.sd_layout.heightIs(20);
        _moreButton.hidden = NO;
        
        if (dataModel.isOpening) { // 如果需要展开
            _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            _contentLabel.sd_layout.maxHeightIs(maxContentLabelHeight);
            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    } else {
        self.moreButton.sd_layout.heightIs(0);
        _moreButton.hidden = YES;
    }
    
    CGFloat picContainerTopMargin = 0;
    if (dataModel.picNameAr.count) {
        picContainerTopMargin = 10;
    }
    _picContainerView.sd_layout.topSpaceToView(_moreButton, picContainerTopMargin);
    
    [self setupAutoHeightWithBottomView:_picContainerView bottomMargin:15];
}

#pragma mark - private actions

- (void)moreButtonClicked
{
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock(self.indexPath);
    }
}
@end
