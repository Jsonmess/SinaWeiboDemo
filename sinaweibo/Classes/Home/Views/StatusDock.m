//
//  StatusDock.m
//  sinaweibo
//
//  Created by apple on 14-6-6.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "StatusDock.h"
#import "NSString+Json_string_append.h"
#import "UIImage+Json_load_image.h"
#import "WBContent.h"
#import "WBDetialController.h"
#import "Com_navigationController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "HttpTool.h"
#import "WBaccount.h"
#import "Json_weibo_cfg.h"
//#define kBtnTagStart 100

@interface StatusDock()
{
    UIButton *_repost;
    UIButton *_comment;
    UIButton *_attitute;
    UIViewController *_ThesuperController;
}
@end

@implementation StatusDock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
       // self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
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
//    btn.tag = index + kBtnTagStart;
    // 图标
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    // 普通背景
    [btn setBackgroundImage:[UIImage GetStrechImageWithNomalImageName:bg WithLeftCapWidth:10.0f topCapHeight:10.0f] forState:UIControlStateNormal];
    // 高亮背景
    [btn setBackgroundImage:[UIImage GetStrechImageWithNomalImageName:[bg fileAppend:@"_highlighted"] WithLeftCapWidth:10.0f topCapHeight:10.0f ] forState:UIControlStateHighlighted];
    // 文字颜色
    [btn setTitleColor:[UIColor colorWithRed:188/255.0f green:188/255.0f blue:188/255.0f alpha:1.0f] forState:UIControlStateNormal];
    // 字体大小
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    // 设frame
    CGFloat w = self.frame.size.width / 3;
    btn.frame = CGRectMake(index * w, 0, w, StatusDockHeight);
    // 文字左边会空出10的间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self addSubview:btn];
    
    if (index) { // index不等于0，添加分隔线
        UIImage *img = [UIImage imageNamed:@"timeline_card_bottom_line.png"];
        UIImageView *divider = [[UIImageView alloc] initWithImage:img];
        divider.center = CGPointMake(btn.frame.origin.x, StatusDockHeight * 0.5);
        [self addSubview:divider];
    }
    
    return btn;
}

#pragma mark 固定自己的宽高
- (void)setFrame:(CGRect)frame
{
    frame.size.width = [UIScreen mainScreen].bounds.size.width - 2 * 10.0f;
    frame.size.height = StatusDockHeight;
    
    [super setFrame:frame];
}

- (void)setStatus:(WBContent *)status
{
    _status = status;
    
    // 1.转发
    [self setBtn:_repost title:@"转发" count:status.repostsCount];
    // 2.评论
    [self setBtn:_comment title:@"评论" count:status.commentsCount];
    // 3.赞
    [self setBtn:_attitute title:@"赞" count:status.attitudesCount];
}

#pragma mark 设置按钮文字
- (void)setBtn:(UIButton *)btn title:(NSString *)title count:(int)count
{
    if (count >= 10000) { // 过万
        CGFloat final = count / 10000.0;
        NSString *title = [NSString stringWithFormat:@"%.1f万", final];
        // 替换.0为空串
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [btn setTitle:title forState:UIControlStateNormal];
    } else if (count > 0) { // 一万以内
        NSString *title = [NSString stringWithFormat:@"%d", count];
        [btn setTitle:title forState:UIControlStateNormal];
    } else { // 没有
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
}
//加载音效
-(SystemSoundID)LoadAudio
{
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"pull.wav" ofType:nil]];
    
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundId);
    return soundId;
}
#pragma mark----按钮按下时，实现方法
//发表评论
-(void)CreateComment:(UIButton *)sender
{
    NSLog(@"评论");
    //进入微博正文
    WBDetialController *wbdetial=[[WBDetialController alloc]init];
    StatusCell *cell=[self statuscell];
    [wbdetial GetWBcontentAndWBframe:self.status Frame: cell.statusCellFrame ];
    _ThesuperController=[self viewController];
    [_ThesuperController.navigationController pushViewController:wbdetial animated:YES];
    AudioServicesPlaySystemSound([self LoadAudio]);
}
//转发
-(void)RepostWB:(UIButton *)sender
{
    NSLog(@"转发");
    
}
//赞
-(void)ShowAttiute:(UIButton *)sender
{
    NSString *accesstoken=[[WBaccount ShareWBaccount]GetAccountFromSqlite3].accessToken;
    [sender setImage:[UIImage imageNamed:@"timeline_icon_like.png"] forState:UIControlStateNormal];
    //同步到新浪服务器
    //https://api.weibo.cn/2/like/set_like.json?source=APPKEY&access_token=ACCESS_TOKEN&id=MID
    [HttpTool HttpSendwithPath:@"https://api.weibo.cn" path:@"/2/like/set_like.json" Params:@{
                                                                               
                                                                               @"source":@"3867508027",
                                                                                @"access_token":accesstoken,
                                                                                @"id":[NSString stringWithFormat:@"%lld",_status.WbID ]
                                          } PostSuccess:^(id Json) {

    } PostFaild:^(NSError *error) {
       
    } WithMethod:@"POST"];
    
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


//获取父视图StatusCell
-(StatusCell *)statuscell {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[StatusCell class]]) {
            return (StatusCell *)nextResponder;
        }
    }
    return nil;
}
@end