//
//  WBaccount.m
//  sinaweibo
//
//  Created by Json on 14-6-2.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "WBaccount.h"
#import <sqlite3.h>
#import "Sqlite3Manager.h"
@interface WBaccount()
{
    Sqlite3Manager *_manager;
}
@end
@implementation WBaccount

-(void)OpenDataBase
{
    _manager=[[Sqlite3Manager alloc]init];
    //在程序document目录下建立数据库，直接在主目录下得数据存在只读权限
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path=[path stringByAppendingPathComponent:@"Sinaweibo.sqlite3"];
    [_manager OpenDataBaseWithPath:path];

   
}
-(void)SaveAccount:(NSString *)accesstoken Uid:(NSString *)uid
{
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO Account (accessToken,uid) values('%@','%@')",accesstoken,uid];
    [_manager InsertDataOrTableToDataBaseWithSql:sql];
}
-(void)CreateTableWithSql:(NSString *)sql
{
    [_manager InsertDataOrTableToDataBaseWithSql:sql];
}
-(void)SaveAccountToSqlite3WithAccessToken:(NSString *)accesstoken Uid:(NSString *)uid
{
   //打开数据库并保存账户信息
    [self OpenDataBase];
    //创建账户表
    [self CreateTableWithSql:@"CREATE TABLE IF NOT EXISTS Account (accessToken text NOT NULL PRIMARY KEY,uid text NOT NULL)"];
    [self SaveAccount:accesstoken Uid:uid];
 
}
-(WBaccount *)GetAccountFromSqlite3
{
  // WBaccount *wbaccount=[WBaccount ShareWBaccount];
    NSString *sql=@"SELECT accessToken,uid FROM Account";
  
    [_manager SearchDataFromDataBaseWithSql:sql Success:^(sqlite3_stmt *stmt) {

        while   ( SQLITE_ROW==  sqlite3_step(stmt))
                 {
           
           
          self.accessToken=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
         self.uid=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];

                     
              }

    } Failed:^{
        
    }];


    return self;
}

static WBaccount *_instance;
#pragma mark----创建账户单例

+(id)allocWithZone:(NSZone *)zone
{
    //防止多个线程运行时候，创建多个对象
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[super allocWithZone:zone];
    });
    return _instance;
}
+(WBaccount *)ShareWBaccount
{
    if (_instance ==nil) {
        _instance=[[self alloc]init];//这个会默认调用allocWithZone
        
    }
    return _instance;
 
}

@end
