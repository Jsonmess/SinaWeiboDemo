//
//  WBaccount.h
//  sinaweibo
//
//  Created by Json on 14-6-2.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBaccount : NSObject
@property(nonatomic,copy)NSString *accessToken;
@property(nonatomic,copy)NSString *uid;
+(WBaccount *)ShareWBaccount;
-(void)OpenDataBase;
-(WBaccount *)GetAccountFromSqlite3;
-(void)SaveAccountToSqlite3WithAccessToken:(NSString *)accesstoken Uid:(NSString *)uid;
@end
