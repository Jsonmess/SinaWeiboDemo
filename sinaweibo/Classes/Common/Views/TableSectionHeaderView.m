//
//  TableSectionHeaderView.m
//  sinaweibo
//
//  Created by Json on 14-9-7.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "TableSectionHeaderView.h"
#import "UIImage+Json_load_image.h"

@interface TableSectionHeaderView()
{
    UIButton *_ReportBtn;
    UIButton *_CommentBtn;
    UIButton *_Attitute;
    UIImageView *_Line;
    WBContent *_TheStatus;

}
@end
@implementation TableSectionHeaderView

- (id)initWithFrame:(CGRect)frame WithStatus:(WBContent *)Status
{
    self = [super initWithFrame:frame];
    if (self) {
        [self AddButtonWithStatus:Status];

        //设置背景
       // self.backgroundColor=[UIColor whiteColor];
        self.image=[UIImage GetStrechImageWithNomalImageName:@"timeline_retweet_background1.png" WithLeftCapWidth:10.0f topCapHeight:10.0f];
        //开启事件监听
        [self setUserInteractionEnabled:YES];
        
       }
    
    _TheStatus=Status;

    return self;
    
}
-(void)AddButtonWithStatus:(WBContent *)status
{

    _ReportBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _CommentBtn =[UIButton buttonWithType:UIButtonTypeCustom];
     _Attitute =[UIButton buttonWithType:UIButtonTypeCustom];
    //添加分割线
    _Line=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line.png" ]];
    [self addSubview:_Line];
    //设置内容属性
    [self SetButtonTitleFontAndColorWithButton:_ReportBtn];
    [self SetButtonTitleFontAndColorWithButton:_CommentBtn];
    [self SetButtonTitleFontAndColorWithButton:_Attitute];
    //设置内容
    [self SetButtonWithTitle:@"转发" Count:status.repostsCount Button:_ReportBtn];
    [self SetButtonWithTitle:@"评论" Count:status.commentsCount Button:_CommentBtn];
    [self SetButtonWithTitle:@"赞" Count:status.attitudesCount Button:_Attitute];
    //设置评论为默认选中状态
   [_CommentBtn setSelected:YES];
    //添加到视图
    [self addSubview:_ReportBtn];
    [self addSubview:_CommentBtn];
    [self addSubview: _Attitute];
    
    //设置按钮监听方法
    [_ReportBtn addTarget:self action:@selector(ShowRetweet) forControlEvents:UIControlEventTouchUpInside];
    [_CommentBtn addTarget:self action:@selector(ShowComment) forControlEvents:UIControlEventTouchUpInside];
    [_Attitute addTarget:self action:@selector(ShowAttitude) forControlEvents:UIControlEventTouchUpInside];

    [self SetTheFrame];
 
}
-(void)SetButtonTitleFontAndColorWithButton:(UIButton *)sender
{
    [sender setTitleColor:[UIColor colorWithRed:188/255.0f green:188/255.0f blue:188/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [sender.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
}
-(void)SetButtonWithTitle:(NSString *)title Count:(int)count Button:(UIButton *)sender
{
    NSString *str=[NSString stringWithFormat:@"%@ %d",title,count];
   [sender setTitle:str forState:UIControlStateNormal];
  [sender setTitle:str forState:UIControlStateHighlighted];
    
}
-(void)SetTheFrame
{
    [_ReportBtn setFrame:CGRectMake(10.0f, 0, 60.0f, self.bounds.size.height)];
    [_Line setFrame:CGRectMake(74.0f, 0, 1.0f, self.bounds.size.height)];
    [_CommentBtn setFrame:CGRectMake(84, 0, 60.0f, self.bounds.size.height)];
    [_Attitute setFrame:CGRectMake(CGRectGetMaxX(_CommentBtn.frame)+116.0f, 0, 60, self.bounds.size.height)];

   
}
#pragma mark---按钮监听方法
//显示转发
-(void)ShowRetweet
{
    [self.delegate SendTheChoiceID:0];
}
//显示评论
-(void)ShowComment
{
    [self.delegate SendTheChoiceID:1];
}
//显示赞
-(void)ShowAttitude
{
     [self.delegate SendTheChoiceID:2 ];

 
}
@end
