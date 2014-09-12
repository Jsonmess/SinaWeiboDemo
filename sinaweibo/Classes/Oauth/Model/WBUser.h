//
//  WBUser.h
//  sinaweibo
//
//  Created by Json on 14-6-6.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    kVerifiedTypeNone = -1, // 没有认证
    kVerifiedTypePersonal = 0, // 个人认证
    kVerifiedTypeOrgEnterprice = 2, // 企业官方
    kVerifiedTypeOrgMedia = 3, // 媒体官方
    kVerifiedTypeOrgWebsite = 5, // 网站官方
    kVerifiedTypeDaren = 220 // 微博达人
} VerifiedType;

typedef enum {
    kMBTypeNone = 0, // 没有
    kMBTypeNormal, // 普通
    kMBTypeYear // 年费
} MBType;
//会员昵称颜色
#define MBScreenNameColor [UIColor colorWithRed:245.0f/255.0f green:102.0f/255.0f blue:18.0f/255.0f alpha:1.0f]
#define ScreenNameColorNomal [UIColor colorWithRed:93/255.0f green:93/255.0f blue:93/255.0f alpha:1.0f]
@interface WBUser : NSObject
@property (nonatomic,copy)NSString *screenName; //用户昵称
@property (nonatomic,copy)NSString *location; //用户位置
@property (nonatomic, copy) NSString *profileImageUrl; //微缩图片url
@property (nonatomic, assign) BOOL verified; //是否是微博认证用户，即加V用户
@property (nonatomic, assign) int verifiedType; // 认证类型
@property (nonatomic, assign) int mbrank; // 会员等级
@property (nonatomic, assign) MBType mbtype; // 会员类型
-(id)initWithDictionary :(NSDictionary*)dic;
@end
