//
//  MoreTableView.m
//  sinaweibo
//
//  Created by Json on 14-9-8.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "MoreTableView.h"

@implementation MoreTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    NSLog(@"%@",NSStringFromCGRect(frame));
    CGRect fr=frame;
    fr.origin.x=0;
    fr.origin.y-=30.0f;
    fr.size.height+=30.0f;
    [super setFrame:fr];
}
@end
