//
//  InPutWBView.m
//  sinaweibo
//
//  Created by Json on 14-9-10.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "InPutWBView.h"
#define Length 120  //根据新浪官方说明，文字小于等于140
@interface InPutWBView()<UITextViewDelegate>
{
    BOOL isFirstEdit;//第一次输入？
    NSInteger TextLength;//文字长度
   
}
@end
@implementation InPutWBView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpView];
        // Initialization code
        isFirstEdit=YES;
        _HaveEdited=NO;
        //设置文字长度
        TextLength=Length;
        _CurrentStr=@"";
    }
    return self;
}

-(void)SetUpView
{
    //设置输入界面
    
    [self setContentSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height-NavigationAndStatusHeight+2.0f)];
    [self setBackgroundColor:[UIColor whiteColor]];//[UIColor colorWithRed:240.0f/255 green:240.0f/255 blue:240.0f/255 alpha:1.0f]];
    [self setScrollEnabled:YES];
    _InputWB =[[UITextView alloc]init];
    [_InputWB setTextColor:[UIColor colorWithRed:186.0f/255.0f green:186.0f/255.0f blue:186.0f/255.0f alpha:1.0f]];
    [_InputWB setFont:InputTextFont];
    [self addSubview:_InputWB];
    [_InputWB setFrame:CGRectMake(10.0f, 10.0f, self.bounds.size.width-2*10.0f, self.bounds.size.height -2*50.0f)];
    [_InputWB setText:@"分享新鲜事..."];
//设置代理
    [_InputWB setDelegate:self];
}
#pragma mark---UITextView代理方法
-(void)textViewDidBeginEditing:(UITextView *)textView
{
  
    //将工具栏往上面移动---利用代理协议
    [self.mdelegate MoveCreateToolDockWithBool:YES];
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [self.mdelegate MoveCreateToolDockWithBool:NO];
}
//用于限制文字长度
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *string = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if ([string length] > TextLength)
    {
        string = [string substringToIndex:TextLength];
        textView.text = string;
        return  NO;
    }
    else return YES;
}
@end
