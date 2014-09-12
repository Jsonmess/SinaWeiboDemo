//
//  UIImage+Json_load_image.m
//  sinaweibo
//
//  Created by Json on 14-5-31.
//  Copyright (c) 2014年 Json. All rights reserved.
//


/*
 
 本方法用于扩展uiimage的加载图片，以适配4.0的iPhone
 
 */
#import "UIImage+Json_load_image.h"
#import "NSString+Json_string_append.h"
@implementation UIImage (Json_load_image)

+(UIImage *)Load_Image:(NSString*)ImageName{
   //判断是否是4.0屏幕iphone
    if (iPhone5_and_later ) {
       
        ImageName = [ImageName fileAppend:@"-568h@2x"];
        
        return [self imageNamed:ImageName];
    }
    
    
    return [self imageNamed:ImageName];

}
+(UIImage *)GetStrechImageWithNomalImageName:(NSString *)imagename WithLeftCapWidth:(NSInteger)left topCapHeight:(NSInteger)heitht
{
    UIImage *image=[UIImage imageNamed:imagename];
    image=[image stretchableImageWithLeftCapWidth:left topCapHeight:heitht];
    return image;
}
@end
