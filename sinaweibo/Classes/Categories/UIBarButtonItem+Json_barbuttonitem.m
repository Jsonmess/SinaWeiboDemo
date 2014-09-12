//
//  UIBarButtonItem+Json_barbuttonitem.m
//  sinaweibo
//
//  Created by Json on 14-6-1.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "UIBarButtonItem+Json_barbuttonitem.h"

@implementation UIBarButtonItem (Json_barbuttonitem)
-(id)initWithTarget:(id)target action:(SEL)action Nomal_image:(NSString *)nomal Highlight_image:(NSString *)highlight 
{
    
   //根据传递的图片创建一个导航栏按钮
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *nomalimage=[UIImage imageNamed:nomal];
    [button setImage:nomalimage forState:UIControlStateNormal];
    UIImage *high_light=[UIImage imageNamed:highlight];
    [button setImage:high_light forState:UIControlStateHighlighted];
    button.bounds=(CGRect){CGPointZero,nomalimage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [ self initWithCustomView:button];
}

@end
