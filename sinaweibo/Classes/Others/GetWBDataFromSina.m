//
//  GetWBDataFromSina.m
//  sinaweibo
//
//  Created by Json on 14-8-26.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "GetWBDataFromSina.h"
#import "HttpTool.h"
@interface GetWBDataFromSina()
{
    NSMutableArray *_WBArray;
}
@end
@implementation GetWBDataFromSina
+(void)GetWBDataWithPath:(NSString *)baseURL path:(NSString *)path Params:(NSDictionary *)param WithGetSuccess:(GetWBDataSuccess)success GetFailed:(GetWBDataFailed)failed  WithMethod:(NSString *)method
{
    NSMutableArray * _WBArray=[NSMutableArray array];
    [HttpTool HttpSendwithPath:baseURL path:path Params:param PostSuccess:^(id Json) {
        
        NSArray * wbcontents=Json[@"statuses"];
        for (NSDictionary *dic in wbcontents) {
            WBContent *wb=[[WBContent alloc]initWithDictionary:dic];
        
           
            [ _WBArray addObject:wb];
        }
        
        success(_WBArray);
        
    } PostFaild:^(NSError *error) {
        
        failed(error);
    } WithMethod:method];
    
    
}

@end
