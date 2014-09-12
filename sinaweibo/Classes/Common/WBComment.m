//
//  WBComment.m
//  sinaweibo
//
//  Created by Json on 14-9-9.
//  Copyright (c) 2014年 Json. All rights reserved.
//
//评论和转发内容----抽象为对象
#import "WBComment.h"

@implementation WBComment
-(id)initWithDictionary:(NSDictionary *)dic
{
    if (self=[super init]) {
        
        self.TheUser=[[WBUser alloc]initWithDictionary:dic[@"user"]];
        
        self.text=dic[@"text"];
        self.createdAt = dic[@"created_at"];

    }
    
    return self;
    
}
/**
 *  设置微博的创建时间，此处需要定制返回时间字符串
 *
 *  @param createdAt 微博创建时间
 */
-(NSString *)createdAt
{
    NSDateFormatter *frm=[[NSDateFormatter alloc]init];
    frm.dateFormat=@"EEE MMM dd HH:mm:ss zzzz yyyy";
    frm.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *create=[frm dateFromString:_createdAt];
    
    NSDate *NowDate=[NSDate date];
    
    NSTimeInterval length=[NowDate timeIntervalSinceDate:create];
    if (length < 60) { // 1分钟内
        return @"一分钟内";
    } else if (length < 60 * 60) { // 1小时内
        return [NSString stringWithFormat:@"%.f分钟前", length/60];
    } else if (length < 60 * 60 * 24) { // 1天内
        return [NSString stringWithFormat:@"%.f小时前", length/60/60];
    } else {
        frm.dateFormat = @"MM-dd HH:mm";
        return [frm stringFromDate:create];
    }
}
@end
