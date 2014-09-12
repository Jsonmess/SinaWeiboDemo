//
//  ToolButtonPublic.m
//  sinaweibo
//
//  Created by Json on 14-9-12.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "ToolButtonPublic.h"

@implementation ToolButtonPublic

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(5.0f, -5.0f, 30.0f, 27.0f);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(CGRectGetMaxX(self.imageView.frame), 2.0f,contentRect.size.width, contentRect.size.height);
}

@end
