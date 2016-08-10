//
//  TRSearchModel.m
//  GameLive
//
//  Created by tarena on 16/8/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRSearchModel.h"

@implementation TRSearchModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"items": @"data.items",
             @"total": @"data.total",
             @"pageNb": @"data.pageNb"
             };
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"items": [TRSearchItemsModel class]};
}
@end

@implementation TRSearchItemsModel



@end










