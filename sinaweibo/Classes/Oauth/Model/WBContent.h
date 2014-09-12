//
//  WBContent.h
//  sinaweibo
//
//  Created by Json on 14-6-6.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUser.h"
@interface WBContent : NSObject

@property (nonatomic,strong)WBUser *TheUser;
@property(nonatomic,copy)NSString *text; //微博文字
@property (nonatomic, strong) NSArray *picUrls; // 微博配图
@property (nonatomic, strong) WBContent *retweetedStatus; // 被转发的微博

@property (nonatomic, copy) NSString *createdAt; // 微博创建时间
@property (nonatomic, assign) int repostsCount; // 转发数
@property (nonatomic, assign) int commentsCount; // 评论数
@property (nonatomic, assign) int attitudesCount; // 表态数(被赞)
@property (nonatomic, copy) NSString *source; // 微博来源
@property (nonatomic, assign) long long WbID;

-(id)initWithDictionary:(NSDictionary *)dic;
@end
