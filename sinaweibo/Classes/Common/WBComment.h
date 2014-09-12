//
//  WBComment.h
//  sinaweibo
//
//  Created by Json on 14-9-9.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUser.h"
@interface WBComment : NSObject
@property (nonatomic,strong)WBUser *TheUser;
@property(nonatomic,copy)NSString *text; //评论或转发文字
@property (nonatomic, copy) NSString *createdAt; // 微博创建时间
-(id)initWithDictionary:(NSDictionary *)dic;
@end
