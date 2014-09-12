//
//  Sqlite3Manager.h
//  sinaweibo
//
//  Created by Json on 14-8-24.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
typedef  void (^SearchSuccess)(sqlite3_stmt *stmt);
typedef  void (^SearchFailed)();
@interface Sqlite3Manager : NSObject
{
    sqlite3 *handle_database;
 
}

-(void)SearchDataFromDataBaseWithSql:(NSString *)sql Success:(SearchSuccess)success Failed:(SearchFailed)failed;
-(void)OpenDataBaseWithPath:(NSString *)path;
-(void)InsertDataOrTableToDataBaseWithSql:(NSString *)sql;
@end
