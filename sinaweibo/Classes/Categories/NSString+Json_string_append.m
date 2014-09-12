//
//  NSString+Json_string_append.m
//  sinaweibo
//
//  Created by Json on 14-5-31.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "NSString+Json_string_append.h"

@implementation NSString (Json_string_append)
- (NSString *)fileAppend:(NSString *)append
{
    // 1.1.获得文件拓展名
    NSString *ext = [self pathExtension];
    
    // 1.2.删除最后面的扩展名
    NSString *imgName = [self stringByDeletingPathExtension];
    
    // 1.3.拼接-568h@2x
    imgName = [imgName stringByAppendingString:append];
    
    // 1.4.拼接扩展名
    return [imgName stringByAppendingPathExtension:ext];
}
@end
