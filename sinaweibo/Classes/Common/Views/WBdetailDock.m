//
//  WBdetailDock.m
//  sinaweibo
//
//  Created by Json on 14-9-4.
//  Copyright (c) 2014年 Json. All rights reserved.
//底部工具栏


#import "WBdetailDock.h"
#import "NSString+Json_string_append.h"
#import "UIImage+Json_load_image.h"
#import "Com_navigationController.h"

#define kBtnTagStart 100

@interface WBdetailDock()<UIAlertViewDelegate>
{
    UIButton *_repost;
    UIButton *_comment;
    UIButton *_attitute;
    UIViewController *_ThesuperController;
}
@end
@implementation WBdetailDock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        // 设置背景
     self.image = [UIImage GetStrechImageWithNomalImageName:@"timeline_card_bottom.png" WithLeftCapWidth:10.0f topCapHeight:10.0f];
       
        // 添加3个按钮
        _repost = [self addBtn:@"转发" icon:@"timeline_icon_retweet.png" bg:@"timeline_card_leftbottom.png" index:0];
        _comment = [self addBtn:@"评论" icon:@"timeline_icon_comment.png" bg:@"timeline_card_middlebottom.png" index:1];
        _attitute = [self addBtn:@"赞" icon:@"timeline_icon_unlike.png" bg:@"timeline_card_rightbottom.png" index:2];
        
        
        //添加按钮方法
        //转发
        [  _repost addTarget:self action:@selector(RepostWB:) forControlEvents:UIControlEventTouchUpInside];
        //评论
        [  _comment addTarget:self action:@selector(CreateComment:) forControlEvents:UIControlEventTouchUpInside];
        //赞
        [  _attitute addTarget:self action:@selector(ShowAttiute:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (UIButton *)addBtn:(NSString *)title icon:(NSString *)icon bg:(NSString *)bg index:(int)index
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 标题
    [btn setTitle:title forState:UIControlStateNormal];
    // 图标
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.clipsToBounds=YES;
    [btn.imageView setContentMode:UIViewContentModeScaleAspectFill];
    // 普通背景
    [btn setBackgroundImage:[UIImage GetStrechImageWithNomalImageName:bg WithLeftCapWidth:10.0f topCapHeight:10.0f] forState:UIControlStateNormal];
    // 高亮背景
    [btn setBackgroundImage:[UIImage GetStrechImageWithNomalImageName:[bg fileAppend:@"_highlighted"] WithLeftCapWidth:10.0f topCapHeight:10.0f ] forState:UIControlStateHighlighted];
    // 文字颜色
    [btn setTitleColor:[UIColor colorWithRed:188/255.0f green:188/255.0f blue:188/255.0f alpha:1.0f] forState:UIControlStateNormal];
    // 字体大小
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    // 设frame
    CGFloat w = self.frame.size.width / 3;
    btn.frame = CGRectMake(index * w, 0, w, StatuDockHeight);
    // 文字左边会空出10的间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self addSubview:btn];
    
    if (index) { // index不等于0，添加分隔线
        UIImage *img = [UIImage imageNamed:@"timeline_card_bottom_line.png"];
        UIImageView *divider = [[UIImageView alloc] initWithImage:img];
        divider.center = CGPointMake(btn.frame.origin.x, StatuDockHeight * 0.5);
        divider.bounds=CGRectMake(0, 0, 1.5f, StatuDockHeight);
        [self addSubview:divider];
    }
    
    return btn;
}

#pragma mark 固定自己的宽高
- (void)setFrame:(CGRect)frame
{
    frame.size.width = [UIScreen mainScreen].bounds.size.width ;
    frame.size.height = StatuDockHeight;
    
    [super setFrame:frame];
}
#pragma mark----按钮按下时，实现方法
//发表评论
-(void)CreateComment:(UIButton *)sender
{
    NSLog(@"评论");
    //进入微博正文
    
}
//转发
-(void)RepostWB:(UIButton *)sender
{
    NSLog(@"转发");
    
}
//赞
-(void)ShowAttiute:(UIButton *)sender
{
   //-----赞接口API未知，故禁止
    UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"抱歉，点赞的API未知，暂不实现！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
//获取viewController
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
