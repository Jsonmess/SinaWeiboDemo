//
//  ToolDockView.m
//  sinaweibo
//
//  Created by Json on 14-9-10.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "ToolDockView.h"
#import "UIImage+Json_resize_image.h"
#import "UIImage+Json_load_image.h"
#define DockTextFont   [UIFont systemFontOfSize:12.0f] //文字大小
#define Loc_OpenHeight 20.0f //设置位置和微博公开按钮的高度
#define IsOpenWidth  45.0f //设置微博公开按钮的宽度
#define ToolsHeight 40.0f //设置工具dock高度
#define ToolsButtonWidth 30.0f //设置工具dock按钮宽度
#define ToolsBorderCellWidth 19.0f //设置工具dock边框宽度
#define ToolsBorderWidth 33.0f //设置工具dock按钮X轴间距

@implementation ToolDockView

- (id)initToolDockView
{
    
    self = [super init];
    if (self) {
        // Initialization code
        [self AddSubContents];
        [self SetSubContent];
        //清除背景色
        [self setBackgroundColor:[UIColor clearColor]];
        //开启接收用户事件
        [self setUserInteractionEnabled:YES];
    }
    return self;
}
-(void)AddSubContents
{
    //添加子控件
    _Locate=[ToolButtonLocate buttonWithType:UIButtonTypeCustom];
    _IsOpen=[ToolButtonPublic buttonWithType:UIButtonTypeCustom];
    _Tools =[[UIImageView alloc]init];
    [self addSubview:_Locate];
    [self addSubview:_IsOpen];
    [self addSubview:_Tools];
    //添加底部工具dock子控件
    _SelectPic=[UIButton buttonWithType:UIButtonTypeCustom];
    _HistoryOfFriend=[UIButton buttonWithType:UIButtonTypeCustom];
    _SearchTopic=[UIButton buttonWithType:UIButtonTypeCustom];
    _EmotionKeyBoard=[UIButton buttonWithType:UIButtonTypeCustom];
    _CloseKeyBoard=[UIButton buttonWithType:UIButtonTypeCustom];
    [_Tools addSubview:_SelectPic];
    [_Tools addSubview:_HistoryOfFriend];
    [_Tools addSubview:_SearchTopic];
    [_Tools addSubview:_EmotionKeyBoard];
    [_Tools addSubview:_CloseKeyBoard];
    
}
#pragma mark---计算各个子控件的内容
-(void)SetSubContent
{
    //位置
    [_Locate setImage:[UIImage imageNamed:@"activity_card_locate@2x.png"] forState:UIControlStateNormal];
    [_Locate setTitle:@"关闭定位" forState:UIControlStateNormal];
    [_Locate setImage:[UIImage imageNamed:@"activity_card_locate@2x.png"]  forState:UIControlStateHighlighted];
    [_Locate setTitle:@"关闭定位" forState:UIControlStateHighlighted];
    [_Locate.titleLabel setFont:  DockTextFont];
    [_Locate setTitleColor:[UIColor colorWithRed:208.0f/255 green:208.0f/255 blue:208.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    [_Locate setTitleColor:[UIColor colorWithRed:78.0f/255 green:112.0f/255 blue:117.0f/255 alpha:1.0f] forState:UIControlStateHighlighted];
    [_Locate addTarget:self action:@selector(GetUserLocation) forControlEvents:UIControlEventTouchUpInside];

    //微博开放程度
    [_IsOpen setImage:[UIImage imageNamed:@"compose_publicbutton@2x.png"] forState:UIControlStateNormal];
    [_IsOpen setTitle:@"公开" forState:UIControlStateNormal];
    [_IsOpen setImage:[UIImage imageNamed:@"compose_publicbutton@2x.png"] forState:UIControlStateHighlighted];
    [_IsOpen setTitle:@"公开" forState:UIControlStateHighlighted];
    [_IsOpen.titleLabel setFont:  DockTextFont];
    [_IsOpen setTitleColor:[UIColor colorWithRed:208.0f/255 green:208.0f/255 blue:208.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    [_IsOpen setTitleColor:[UIColor colorWithRed:78.0f/255 green:112.0f/255 blue:117.0f/255 alpha:1.0f] forState:UIControlStateHighlighted];
    [_IsOpen addTarget:self action:@selector(SetWBProperty) forControlEvents:UIControlEventTouchUpInside];
    //工具
    [_Tools setImage:[UIImage GetStrechImageWithNomalImageName:@"common_button_white_highlighted@2x.png" WithLeftCapWidth:5.0f topCapHeight:20.0f]];
    [_Tools setUserInteractionEnabled:YES];
    //工具dock子控件
    //选择图片
    [_SelectPic setImage:[UIImage imageNamed: @"compose_toolbar_picture@2x.png"] forState:UIControlStateNormal];
    [_SelectPic setImage:[UIImage imageNamed: @"compose_toolbar_picture_highlighted@2x.png"] forState:UIControlStateHighlighted];
    [_SelectPic addTarget:self action:@selector(OpenPickerController) forControlEvents:UIControlEventTouchUpInside];
    //最近联系人
    [_HistoryOfFriend setImage:[UIImage imageNamed: @"compose_mentionbutton_background@2x.png"] forState:UIControlStateNormal];
    [_HistoryOfFriend setImage:[UIImage imageNamed: @"compose_mentionbutton_background_highlighted@2x.png"] forState:UIControlStateHighlighted];
    //找话题
    [_SearchTopic setImage:[UIImage imageNamed: @"compose_trendbutton_background@2x.png"] forState:UIControlStateNormal];
    [_SearchTopic setImage:[UIImage imageNamed: @"compose_trendbutton_background_highlighted@2x.png"] forState:UIControlStateHighlighted];
    //表情键盘
    [_EmotionKeyBoard setImage:[UIImage imageNamed: @"compose_emoticonbutton_background@2x.png"] forState:UIControlStateNormal];
    [_EmotionKeyBoard setImage:[UIImage imageNamed: @"compose_emoticonbutton_background_highlighted@2x.png"] forState:UIControlStateHighlighted];
    //关闭/打开键盘
    [_CloseKeyBoard setImage:[UIImage imageNamed: @"compose_keyboardbutton_background@2x.png"] forState:UIControlStateNormal];
    [_CloseKeyBoard setImage:[UIImage imageNamed: @"compose_keyboardbutton_background_highlighted@2x.png"] forState:UIControlStateHighlighted];
    
    [_CloseKeyBoard addTarget:self action:@selector(SwitchTheKeyBoard) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark---计算各个子控件的frame
-(CGSize)SetSubContentsFrame
{
    CGSize size=CGSizeZero;
    //位置
    CGSize loc_size=[_Locate.titleLabel.text sizeWithFont:DockTextFont constrainedToSize:CGSizeMake(240.0f, Loc_OpenHeight)];
    
    [_Locate setFrame:(CGRect){ {10.0f, 2.0f}, {IsOpenWidth+loc_size.width,Loc_OpenHeight}}];
    
    //微博开放程度
    CGSize Open_size=[_IsOpen.titleLabel.text sizeWithFont:DockTextFont constrainedToSize:CGSizeMake(240.0f, Loc_OpenHeight)];
    [_IsOpen setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-Open_size.width-40.0f, 2.0f,IsOpenWidth+Open_size.width, Loc_OpenHeight)];
    
    
    //选择图片
    [_SelectPic setFrame:CGRectMake( ToolsBorderCellWidth, 7.5f, ToolsButtonWidth, ToolsHeight-10.0f)];
    //最近联系人
    [_HistoryOfFriend setFrame:CGRectMake(CGRectGetMaxX(_SelectPic.frame)+ToolsBorderWidth, 7.5f, ToolsButtonWidth, ToolsHeight-10.0f)];
    //找话题
    [_SearchTopic setFrame:CGRectMake(CGRectGetMaxX(_HistoryOfFriend.frame)+ToolsBorderWidth, 7.5f, ToolsButtonWidth, ToolsHeight-10.0f)];
    //表情键盘
    [_EmotionKeyBoard setFrame:CGRectMake(CGRectGetMaxX(_SearchTopic.frame)+ToolsBorderWidth, 7.5f, ToolsButtonWidth, ToolsHeight-10.0f)];
    //关闭/打开键盘
    [_CloseKeyBoard setFrame:CGRectMake(CGRectGetMaxX(_EmotionKeyBoard.frame)+ToolsBorderWidth, 7.5f, ToolsButtonWidth, ToolsHeight-10.0f)];
    //工具dock
    [_Tools setFrame:CGRectMake(0, CGRectGetMaxY(_Locate.frame)+2.0f,[UIScreen mainScreen].bounds.size.width, ToolsHeight+5.0f)];
    
    size=(CGSize){[UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(_Tools.frame)};
    
    return size;
}
#pragma mark----监听按钮事件
//关闭/打开键盘
-(void)SwitchTheKeyBoard
{
    [self.BtnDelegate SendButtonTouchEventWithID:4];
}
-(void)OpenPickerController
{
    [self.BtnDelegate SendButtonTouchEventWithID:0];
}
//开启定位
-(void)GetUserLocation
{
    [self.BtnDelegate SendButtonTouchEventWithID:5];
    NSString *btntitle= [_Locate.titleLabel.text isEqualToString:@"关闭定位"]?@"开启定位":@"关闭定位";
    [_Locate setTitle:btntitle forState:UIControlStateNormal];
    [_Locate setTitle:btntitle forState:UIControlStateHighlighted];
}
//设置微博开放程度
-(void)SetWBProperty
{
    [self.BtnDelegate SendButtonTouchEventWithID:6];
    NSString *btntitle= [_IsOpen.titleLabel.text isEqualToString:@"公开"]?@"保密":@"公开";
    [_IsOpen setTitle:btntitle forState:UIControlStateNormal];
    [_IsOpen setTitle:btntitle forState:UIControlStateHighlighted];
}
@end
