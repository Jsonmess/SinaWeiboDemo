//
//  NoCommentAndOtherView.m
//  sinaweibo
//
//  Created by Json on 14-9-7.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "NoCommentAndOtherView.h"
#define  FontSize 12.0f
@interface NoCommentAndOtherView()
{
    UIImageView *_img;
    UILabel *_textlabel;
}
@end
@implementation NoCommentAndOtherView

-(id)initWithTheTitle:(NSString *)title WithImageName:(NSString *)imagename
{
    
    self=[super init];
    if (self) {
        //添加图片视图
          _img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imagename]];
        [self addSubview:_img];
        //添加文字
        _textlabel=[[UILabel alloc]init];
        [_textlabel setText:title];
        [_textlabel setTextColor:[UIColor colorWithRed:188/255.0f green:188/255.0f blue:188/255.0f alpha:1.0f]];
        [self addSubview:_textlabel];
        
    }
    return self;
}
//计算当前对象的size
-(CGSize)CaculateTheFrame
{
      [_img setFrame:(CGRect){{26.0f, 10.0f}, {60.0f,65.0f}}];
    [_textlabel setFont:[UIFont systemFontOfSize:FontSize]];
    _textlabel.bounds=(CGRect){{0, 0}, {150.0f,20.0f}};
    [_textlabel setCenter:CGPointMake(_img.bounds.origin.x+_img.bounds.size.width*1.2f , CGRectGetMaxY(_img.frame)+10.0f)];
  
    return CGSizeMake(150.0f, CGRectGetMaxY(_textlabel.frame)+10.0f);
}
@end
