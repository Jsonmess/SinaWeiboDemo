//
//  UIImage+Json_resize_image.m
//  sinaweibo
//
//  Created by Json on 14-6-2.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "UIImage+Json_resize_image.h"

@implementation UIImage (Json_resize_image)
+(id)ResizeThePicture:(NSString *)ImageName WithUIEdgeInserts:(UIEdgeInsets)insets resizingMode:(UIImageResizingMode)Mode
{
    UIImage *image =[UIImage imageNamed:ImageName];
    image=[image resizableImageWithCapInsets:insets resizingMode:Mode];
    return image;   
}
@end
