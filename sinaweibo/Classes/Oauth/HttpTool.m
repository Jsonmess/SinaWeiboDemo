 //
//  HttpTool.m
//  sinaweibo
//
//  Created by Json on 14-6-5.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"

@implementation HttpTool
+(void)HttpSendwithPath:(NSString *)baseURL path:(NSString *)path Params:(NSDictionary *)param PostSuccess:(HttpSuccessBlock)success PostFaild:(HttpFaildBlock)faild WithMethod:(NSString *)method
{
    //创建post请求   BaseURL只能包含协议头和主机名
    AFHTTPClient *client=[AFHTTPClient  clientWithBaseURL:[NSURL URLWithString:baseURL]];
    NSURLRequest *url_request= [client requestWithMethod:method path:path parameters:param];
    
    //利用AFN框架创建nsurlrequest
    AFJSONRequestOperation *json_op=[AFJSONRequestOperation JSONRequestOperationWithRequest:url_request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
       
        success(JSON);
      //  NSLog(@"%@",JSON);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        faild(error);
        
    }];
    //开始发送
    [json_op start];

    
}
@end
