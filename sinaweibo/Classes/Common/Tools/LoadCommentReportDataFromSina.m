//
//  LoadCommentReportDataFromSina.m
//  sinaweibo
//
//  Created by Json on 14-9-9.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "LoadCommentReportDataFromSina.h"
#import "HttpTool.h"
@interface LoadCommentReportDataFromSina()
{
    NSMutableArray *_WBArray;
}
@end
@implementation LoadCommentReportDataFromSina
+(void)GetWBDataWithPath:(NSString *)baseURL path:(NSString *)path Params:(NSDictionary *)param WithGetSuccess:(GetWBDataSuccess)success GetFailed:(GetWBDataFailed)failed  WithMethod:(NSString *)method WithKeyWord:(NSString*)keyword
{
    NSMutableArray * _WBArray=[NSMutableArray array];
    [HttpTool HttpSendwithPath:baseURL path:path Params:param PostSuccess:^(id Json) {
        
        NSArray * wbcontents=Json[keyword];
        for (NSDictionary *dic in wbcontents) {
            WBComment *wb=[[WBComment alloc]initWithDictionary:dic];
           // NSLog(@"文字：%@,创建时间：%@,用户名：%@",wb.text,wb.createdAt,wb.TheUser.screenName);
            
            [ _WBArray addObject:wb];
        }
        
        success(_WBArray);
        
    } PostFaild:^(NSError *error) {
        
        failed(error);
    } WithMethod:method];
    
    
}

@end
