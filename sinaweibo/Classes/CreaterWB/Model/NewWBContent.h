//
//  NewWBContent.h
//  sinaweibo
//
//  Created by Json on 14-9-12.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewWBContent : NSObject
@property(nonatomic,strong)NSString * WBtext;//微博内容
@property(nonatomic,strong)NSData * WBim;//微博图片
@property(nonatomic,assign)NSInteger WBOpenProperty;//微博开发属性
@property(nonatomic,assign)CGFloat Lat;//用户所在经度;
@property(nonatomic,assign)CGFloat Long;//用户所在纬度;
@end
