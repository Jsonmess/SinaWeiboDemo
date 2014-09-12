//
//  Sqlite3Manager.m
//  sinaweibo
//
//  Created by Json on 14-8-24.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "Sqlite3Manager.h"

@implementation Sqlite3Manager
-(void)OpenDataBaseWithPath:(NSString *)path
{
    sqlite3 *ppdb;
    if (sqlite3_open(path.UTF8String, &ppdb)==SQLITE_OK) {
        
      //  NSLog(@"数据库打开成功");
        
        
    }else
    {
      //  NSLog(@"数据库打开或创建失败！");
    }
    
    handle_database=ppdb;
}
-(void)InsertDataOrTableToDataBaseWithSql:(NSString *)sql
{
 
    char *error;
    
    if (sqlite3_exec(handle_database, sql.UTF8String, NULL, NULL, &error)==SQLITE_OK) {
        NSLog(@"操作成功！%s",error);
    }
    else {
        NSLog(@"操作失败%s",error);
    }

}

-(void)SearchDataFromDataBaseWithSql:(NSString *)sql Success:(SearchSuccess)success Failed:(SearchFailed)failed
{
    sqlite3_stmt *ppStmt;
    if(  sqlite3_prepare_v2(handle_database, sql.UTF8String, -1, &ppStmt, NULL)==SQLITE_OK)
    {
        success(ppStmt);
//        NSLog(@"查询数据成功！");
        
    }
    else
    {
        failed();
    }

     sqlite3_finalize(ppStmt);
}
@end
