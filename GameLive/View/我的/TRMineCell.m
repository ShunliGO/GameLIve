//
//  TRMineCell.m
//  GameLive
//
//  Created by tarena on 16/8/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRMineCell.h"

@implementation TRMineCell

#pragma mark - lazy
- (UIImageView *)iconIV{
    if (!_iconIV) {
        _iconIV = [UIImageView new];
        [self.contentView addSubview:_iconIV];
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.centerX.equalTo(-kScreenW/2 + 50);
            //make.width.height.equalTo(18);
        }];
    }
    return _iconIV;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(50);
        }];
    }
    return _titleLb;
}

#pragma mark - life
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = 1; //右箭头
    }
    return self;
}

@end
