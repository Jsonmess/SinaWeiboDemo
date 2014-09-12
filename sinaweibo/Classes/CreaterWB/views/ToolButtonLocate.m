//
//  ToolButton.m
//  sinaweibo
//
//  Created by Json on 14-9-12.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "ToolButtonLocate.h"

@implementation ToolButtonLocate

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
    return CGRectMake(5.0f, 2.0f, 18.0f, 18.0f);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(CGRectGetMaxX(self.imageView.frame)+3.0F, 2.0f,contentRect.size.width, contentRect.size.height);
}
@end
