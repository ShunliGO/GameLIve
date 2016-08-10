//
//  TRHeaderCell.m
//  GameLive
//
//  Created by tarena on 16/8/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRHeaderCell.h"

@interface TRHeaderCell ()

@end

@implementation TRHeaderCell

#pragma mark -

#pragma mark - lazy
- (UIImageView *)bgIV{
    if (!_bgIV) {
        _bgIV = [UIImageView new];
        _bgIV.image = [UIImage imageNamed:@"ios个人中心背景"];
        [self.contentView addSubview:_bgIV];
        [_bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(0);
            make.bottom.equalTo(-75);
        }];
    }
    return _bgIV;
}

#pragma mark - life
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self bgIV];
        [self addBottomBtns];
        [self addOtherBtn];
    }
    return self;
}

- (void)addOtherBtn{
    //开始直播
    UIButton *beginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.contentView addSubview:beginBtn];
    beginBtn.backgroundColor = [UIColor blueColor];
    beginBtn.layer.cornerRadius = 14;
    [beginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.bottom.equalTo(self.bgIV.mas_bottom).equalTo(14);
        make.width.equalTo(kScreenW/2);
    }];
    [beginBtn setTitle:@"开启直播" forState:UIControlStateNormal];
    [beginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [beginBtn bk_addEventHandler:^(id sender) {
        NSLog(@"开启直播");
    } forControlEvents:UIControlEventTouchUpInside];
    
    //左上角新消息
    UIButton *msgBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.contentView addSubview:msgBtn];
    [msgBtn bk_addEventHandler:^(id sender) {
        NSLog(@"查看新消息");
    } forControlEvents:UIControlEventTouchUpInside];
    [msgBtn setBackgroundImage:[UIImage imageNamed:@"个人中心消息（新消息）"] forState:UIControlStateNormal];
    [msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.top.equalTo(25);
    }];
    
    //右上角编辑按钮
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.contentView addSubview:editBtn];
    [editBtn bk_addEventHandler:^(id sender) {
        NSLog(@"编辑按钮");
    } forControlEvents:UIControlEventTouchUpInside];
    [editBtn setBackgroundImage:[UIImage imageNamed:@"个人中心编辑图标"] forState:UIControlStateNormal];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-20);
        make.top.equalTo(25);
    }];
    
    //头像
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.contentView addSubview:headerBtn];
    [headerBtn setBackgroundImage:[UIImage imageNamed:@"组-6"] forState:UIControlStateNormal];
    [headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(70);
        make.centerX.equalTo(0);
        make.top.equalTo(30);
    }];
    [headerBtn bk_addEventHandler:^(id sender) {
        NSLog(@"头像");
        if ([_delegate respondsToSelector:@selector(headerIconClickedInHeaderCell:)]) {
            [_delegate headerIconClickedInHeaderCell:self];
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    //鱼丸鱼翅
    UILabel *moneyLb = [UILabel new];
    [self.contentView addSubview:moneyLb];
    moneyLb.font = [UIFont systemFontOfSize:12];
    [moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.bottom.equalTo(beginBtn.mas_top).equalTo(-10);
    }];
    moneyLb.text = @"鱼丸81 | 鱼翅0";
    moneyLb.textColor = [UIColor whiteColor];
    
    
    //用户名
    UILabel *userLb = [UILabel new];
    [self.contentView addSubview:userLb];
    [userLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(-25);
        make.bottom.equalTo(moneyLb.mas_top).equalTo(-5);
    }];
    userLb.textColor = [UIColor whiteColor];
    userLb.font = [UIFont systemFontOfSize:14];
    userLb.text = @"srwrrss";
    
    UIImageView *iconIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"认证"]];
    [self.contentView addSubview:iconIV];
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userLb.mas_right).equalTo(5);
        make.centerY.equalTo(userLb);
    }];
}

- (void)addBottomBtns{
    UIView *lastV = nil;
    NSArray *titles = @[@"观看历史", @"关注管理", @"鱼丸任务", @"鱼翅充值"];
    NSArray *imageNames = @[@"观看历史", @"我的关注", @"鱼丸任务", @"鱼翅充值"];
    for (int i = 0; i < 4; i++) {
        UIControl *c = [UIControl new];
        [self.contentView addSubview:c];
        [c mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(0);
            make.top.equalTo(self.bgIV.mas_bottom).equalTo(20);
            if (i == 0) {
                make.left.equalTo(0);
            }else{
                make.width.equalTo(lastV);
                make.left.equalTo(lastV.mas_right);
                if (i == 3) {
                    make.right.equalTo(0);
                }
            }
        }];
        lastV = c;
        
        UILabel *titleLb = [UILabel new];
        titleLb.font = [UIFont systemFontOfSize:14];
        titleLb.text = titles[i];
        [c addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.bottom.equalTo(-5);
        }];
        
        UIImageView *iv = [UIImageView new];
        iv.image = [UIImage imageNamed:imageNames[i]];
        [c addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(titleLb);
            make.bottom.equalTo(titleLb.mas_top).equalTo(-5);
        }];
        
        c.tag = 100 + i;
        [c bk_addEventHandler:^(UIControl *sender) {
            switch (sender.tag) {
                case 100:
                    NSLog(@"观看历史");
                    break;
                case 101:
                    NSLog(@"关注管理");
                    break;
                case 102:
                    NSLog(@"鱼丸任务");
                    break;
                case 103:
                    NSLog(@"鱼翅充值");
                    break;
                default:
                    break;
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
