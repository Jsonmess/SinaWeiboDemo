//
//  UIImage+Json_resize_image.h
//  sinaweibo
//
//  Created by Json on 14-6-2.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Json_resize_image)
+(id)ResizeThePicture:(NSString *)ImageName WithUIEdgeInserts:(UIEdgeInsets)insets resizingMode:(UIImageResizingMode)Mode;
@end
