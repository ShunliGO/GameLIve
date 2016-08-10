//
//  TRHeaderCell.h
//  GameLive
//
//  Created by tarena on 16/8/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TRHeaderCell;
@protocol TRHeaderCellDelegate <NSObject>
//头像被点击
- (void)headerIconClickedInHeaderCell:(TRHeaderCell *)headerCell;
@end

@interface TRHeaderCell : UITableViewCell
@property (nonatomic, weak) id<TRHeaderCellDelegate> delegate;
@property (nonatomic) UIImageView *bgIV;

@end












