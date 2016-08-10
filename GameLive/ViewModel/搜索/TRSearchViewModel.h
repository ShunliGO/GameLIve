//
//  TRSearchViewModel.h
//  GameLive
//
//  Created by tarena on 16/8/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "TRNetManager.h"

@interface TRSearchViewModel : BaseViewModel
@property (nonatomic) NSString *keywords;
@property (nonatomic) NSMutableArray<TRSearchItemsModel *> *dataList;
@property (nonatomic) NSInteger page;

@property (nonatomic, readonly) NSInteger rowNumber;
- (NSURL *)iconURLForRow:(NSInteger)row;
- (NSString *)nickForRow:(NSInteger)row;
- (NSString *)titleForRow:(NSInteger)row;
- (NSURL *)videoURLForRow:(NSInteger)row;
- (NSString *)viewForRow:(NSInteger)row;
@end
