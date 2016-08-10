//
//  TRSearchViewModel.m
//  GameLive
//
//  Created by tarena on 16/8/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRSearchViewModel.h"

@implementation TRSearchViewModel
- (NSMutableArray<TRSearchItemsModel *> *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}

- (void)getDataWithMode:(RequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler{
    NSInteger tmpPage = 0;
    if (requestMode == RequestModeMore) {
        tmpPage = _page + 1;
    }
    self.dataTask = [TRNetManager search:_keywords page:tmpPage completionHandler:^(TRSearchModel *model, NSError *error) {
        if (!error) {
            if (requestMode == RequestModeRefresh) {
                [self.dataList removeAllObjects];
            }
            [self.dataList addObjectsFromArray:model.items];
            _page = tmpPage;
        }
        !completionHandler?:completionHandler(error);
    }];
}

- (NSInteger)rowNumber{
    return self.dataList.count;
}
- (NSURL *)iconURLForRow:(NSInteger)row{
    return self.dataList[row].thumb.yx_URL;
}
- (NSString *)nickForRow:(NSInteger)row{
    return self.dataList[row].nick;
}
- (NSString *)titleForRow:(NSInteger)row{
    return self.dataList[row].title;
}
- (NSURL *)videoURLForRow:(NSInteger)row{
    //uid是数字类型
    return @(self.dataList[row].uid).stringValue.yx_VideoURL;
}
- (NSString *)viewForRow:(NSInteger)row{
    NSInteger num = self.dataList[row].view.integerValue;
    if (num >= 10000) {
        return [NSString stringWithFormat:@"%.1f万", num/10000.0];
    }else{
        return self.dataList[row].view;
    }
}










@end
