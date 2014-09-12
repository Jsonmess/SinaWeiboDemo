//
//  NewFeatureController.m
//  sinaweibo
//
//  Created by Json on 14-5-30.
//  Copyright (c) 2014年 Json. All rights reserved.
//  版本新特性界面
/*
    设计：
    1.背景图-----uiimageview
        2.滚动图片----uiscollview
    3.图片页数----uipagecontrol
 
 */

#import "NewFeatureController.h"
#import "UIImage+Json_load_image.h"
#import "Oauth_ViewController.h"
#import "MainController.h"
#define  Kimage_count 4
@interface NewFeatureController ()
{
    UIPageControl *_pagecontrol;
}
@end

@implementation NewFeatureController
//用于自定义视图
-(void)loadView
{
    UIImageView *backimage=[[UIImageView alloc]initWithImage:[UIImage Load_Image:@"new_feature_background.png"]];
    [backimage setFrame:[UIScreen mainScreen].applicationFrame];
    //让其能接收触摸事件，以便将触摸事件传递给子控件（uiscroller等）
    backimage.userInteractionEnabled=YES;
    self.view =backimage;
    
        
}

- (void)viewDidLoad
{
    [super viewDidLoad];
       //滚动视图
    UIScrollView *imageview=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    //去掉（水平/垂直）滚动条
    imageview.showsHorizontalScrollIndicator=NO;
    [imageview setShowsVerticalScrollIndicator:NO];
    [imageview setContentSize:CGSizeMake(self.view.bounds.size.width * Kimage_count,0)];
    imageview .pagingEnabled=YES;
    //添加图片
    CGSize size=imageview.frame.size;
    for (int i=0; i<Kimage_count; i++) {
        UIImage *image=[UIImage Load_Image:[NSString stringWithFormat:@"new_feature_%d.png",i+1]];
        UIImageView *theview=[[UIImageView alloc]initWithImage:image];
        [theview setFrame:CGRectMake(i*size.width, 0, size.width, size.height)];
        if (Kimage_count-1==i) {
            [self setLastImage:theview];
        }
        [imageview addSubview:theview];
    }
    [imageview setDelegate:self];//设置监听代理
   
    [self.view addSubview:imageview];
    //分页视图
  UIPageControl  *pagecontrol=[[UIPageControl alloc]init];
    [pagecontrol setCenter:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height*0.95)];
    [pagecontrol setBounds:CGRectMake(0, 0, 150, 0)];
    [pagecontrol setNumberOfPages:Kimage_count];
    //colorWithPatternImage用于将图片转为颜色使用
    [pagecontrol setCurrentPageIndicatorTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"]]];
    [pagecontrol setPageIndicatorTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point.png"]]];
    [self.view addSubview:pagecontrol];
     _pagecontrol=pagecontrol;

	// Do any additional setup after loading the view.
}
#pragma mark-----设置最后一张图片的视图
-(void)setLastImage:(UIImageView *)lastview
{
    UIButton *start=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *nomal=[UIImage imageNamed:@"new_feature_finish_button.png"];
    [start setBackgroundImage:nomal forState:UIControlStateNormal];
     [start setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted.png"] forState:UIControlStateHighlighted];
    [start setCenter:CGPointMake(lastview.bounds.size.width/2, lastview.bounds.size.height*0.8)];
    [start setBounds:CGRectMake(0, 0, nomal.size.width, nomal.size.height)];
    [start addTarget:self action:@selector(StartToWeibo) forControlEvents:UIControlEventTouchUpInside];
    [lastview addSubview:start];
    //分享按钮
    UIButton *share=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *sharenomal=[UIImage imageNamed:@"new_feature_share_true.png"];
    [share setCenter:CGPointMake(lastview.bounds.size.width/2, lastview.bounds.size.height*0.8-50)];
    [share setBounds:CGRectMake(0, 0, sharenomal.size.width, sharenomal.size.height)];
    [share setBackgroundImage:[UIImage imageNamed:@"new_feature_share_false.png"] forState:UIControlStateNormal];
    [share setBackgroundImage:sharenomal forState:UIControlStateSelected];
    [share setSelected:YES];
    [share addTarget:self action:@selector(ShareTofriends:) forControlEvents:UIControlEventTouchUpInside];
    //设置是否要对高亮状态是否调整图片
    [share setAdjustsImageWhenHighlighted:NO];
    [lastview addSubview:share];
   [lastview setUserInteractionEnabled:YES]; 
}
#pragma mark------滚动代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算滚动到几页
 // NSInteger currentnum= (scrollView.contentOffset.x/scrollView.contentSize.width)*Kimage_count;
    NSInteger currentnum=scrollView.contentOffset.x/scrollView.frame.size.width;
    _pagecontrol.CurrentPage=currentnum;
    
}
#pragma mark------分享给好友方法
-(void)ShareTofriends:(UIButton *)button{

    button.selected=!button.selected;

}
#pragma mark-------直接跳转到微博主界面
-(void)StartToWeibo
{
    Debuglog(@"开始微博");
    //获取程序的窗口
   UIWindow *window= [UIApplication sharedApplication].keyWindow;
    [UIApplication sharedApplication].statusBarHidden =NO;
 #pragma mark--- 替换根控制器时候，view会立即创建，所以与上一行代码不可以交换，否则交换后view的frame会不对。
    window.rootViewController=[[Oauth_ViewController alloc]init];
    
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
