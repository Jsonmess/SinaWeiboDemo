//
//  HttpTool.h
//  sinaweibo
//
//  Created by Json on 14-6-5.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <Foundation/Foundation.h>
//定义两个block 用于返回值
typedef void (^HttpSuccessBlock)(id Json);
typedef void (^HttpFaildBlock)(NSError *error);
@interface HttpTool : NSObject
+(void)HttpSendwithPath:(NSString *)baseURL path:(NSString *)path  Params:(NSDictionary *)param
PostSuccess:(HttpSuccessBlock)success PostFaild:(HttpFaildBlock)faild WithMethod :(NSString *)method;
@end
