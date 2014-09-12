//
//  WBContent.m
//  sinaweibo
//
//  Created by Json on 14-6-6.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "WBContent.h"

@implementation WBContent
-(id)initWithDictionary:(NSDictionary *)dic
{
    if (self=[super init]) {
    
        self.TheUser=[[WBUser alloc]initWithDictionary:dic[@"user"]];
        
        self.text=dic[@"text"];
        self.picUrls = dic[@"pic_urls"];
        NSDictionary *retweet = dic[@"retweeted_status"];  //可能为空

        if (retweet) {
            self.retweetedStatus = [[WBContent alloc] initWithDictionary:retweet];
        }
        
        self.createdAt = dic[@"created_at"];
        self.source = dic[@"source"];
        
        self.repostsCount = [dic[@"reposts_count"] intValue];
        self.commentsCount = [dic[@"comments_count"] intValue];
        self.attitudesCount = [dic[@"attitudes_count"] intValue];
        self.WbID=[dic[@"id"] longLongValue];
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

/**
 *  设置微博来源
 *注意：调用系统自带的已经使用@property的成员变量的set和get方法时候
 *不可以使用self.成员  会造成死循环
 *  @param source 微博来源
 */
-(void)setSource:(NSString *)source
{
    int begin = (int)([source rangeOfString:@">"].location + 1);
    int end = (int)([source rangeOfString:@"</"].location);
  //  NSLog(@"%@",source);
    _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:NSMakeRange(begin, end - begin)]];
}
@end
