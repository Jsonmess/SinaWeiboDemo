//
//  UIImage+Json_load_image.h
//  sinaweibo
//
//  Created by Json on 14-5-31.
//  Copyright (c) 2014年 Json. All rights reserved.
//
/*
 
 本方法用于扩展uiimage的加载图片，以适配4.0的iPhone
 
 */
#import <UIKit/UIKit.h>

@interface UIImage (Json_load_image)
+(UIImage *)Load_Image:(NSString*)ImageName;
/**
 *  用于得到拉伸后的图片
 */
+(UIImage *)GetStrechImageWithNomalImageName:(NSString *)imagename WithLeftCapWidth:(NSInteger)left topCapHeight:(NSInteger)heitht;
@end

