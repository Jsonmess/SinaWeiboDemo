//
//  LoadCommentReportDataFromSina.h
//  sinaweibo
//
//  Created by Json on 14-9-9.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBComment.h"
typedef void(^GetWBDataSuccess)(NSMutableArray *wbcomments);
typedef void (^GetWBDataFailed)(NSError *error);
@interface LoadCommentReportDataFromSina : NSObject
+(void)GetWBDataWithPath:(NSString *)baseURL path:(NSString *)path Params:(NSDictionary *)param WithGetSuccess:(GetWBDataSuccess)success GetFailed:(GetWBDataFailed)failed  WithMethod:(NSString *)method WithKeyWord:(NSString*)keyword;
@end
