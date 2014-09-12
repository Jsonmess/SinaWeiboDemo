//
//  GetWBDataFromSina.h
//  sinaweibo
//
//  Created by Json on 14-8-26.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBContent.h"
typedef void(^GetWBDataSuccess)(NSMutableArray *wbcontents);

typedef void (^GetWBDataFailed)(NSError *error);
@interface GetWBDataFromSina : NSObject
+(void)GetWBDataWithPath:(NSString *)baseURL path:(NSString *)path Params:(NSDictionary *)param WithGetSuccess:(GetWBDataSuccess)success GetFailed:(GetWBDataFailed)failed WithMethod:(NSString *)method;
@end

