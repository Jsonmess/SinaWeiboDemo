//
//  MainController.m
//  sinaweibo
//
//  Created by Json on 14-5-30.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "MainController.h"
#import "Tabbar_view.h"
//这俩个宏需要指定，一个用于设置选项卡高度，一个设置选项卡中按钮的数量。
#define  Ktabbar_height 44
#define  kbutton_count 5
#import "HomeViewController.h"
#import "MoreController.h"
#import "Com_navigationController.h"
#import "MesssageViewController.h"
@interface MainController ()<UINavigationControllerDelegate>

@property(strong,nonatomic) Tabbar_view *_dock;
//@property(assign,nonatomic) NSInteger Button_Tag_old;
//@property(assign,nonatomic) NSInteger Button_Tag;

@end

@implementation MainController



- (void)viewDidLoad
{
    //初始化所有子控制器
    [self initChildController];
    //添加选项卡
    [self AddTabbar];
    [super viewDidLoad];
}
#pragma mark---添加选项卡
-(void)AddTabbar
{
    
    self._dock=[[Tabbar_view alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height-Ktabbar_height, self.view.frame.size.width, Ktabbar_height)];
#pragma mark---   注意代理最好在初始化设置该代理对象初始化后就设置
    //设置代理
    [self._dock setDelegate:self];
    
    
    //设置选项卡中按钮数目
    self._dock._buttons_count=kbutton_count;
    //设置选项卡背景颜色
    [self._dock setBackground_image:@"tabbar_background.png"];
    [self.view addSubview:self._dock];
    //往选项卡中添加按钮 抽象出添加按钮的(标题、nomal图片、selected图片)便于重用
    [self._dock AddButtonWith:@"首页" NomalImage:@"tabbar_home.png" SelectedImage:@"tabbar_home_selected"];
    [self._dock AddButtonWith:@"消息" NomalImage:@"tabbar_message_center.png" SelectedImage:@"tabbar_message_center_selected.png"];
    [self._dock AddButtonWith:@"广场" NomalImage:@"tabbar_discover.png" SelectedImage:@"tabbar_discover_selected.png" ];
    [self._dock AddButtonWith:@"我" NomalImage:@"tabbar_profile.png" SelectedImage:@"tabbar_profile_selected.png"];
    
    [self._dock AddButtonWith:@"更多" NomalImage:@"tabbar_more.png" SelectedImage:@"tabbar_more_selected.png"];
    
}


#pragma mark---初始化所有子控制器
-(void)initChildController
{
    //创建子控制器
    
    //主页+导航栏
    HomeViewController *home=[[HomeViewController alloc]init];
    Com_navigationController *navh=[[Com_navigationController alloc]initWithRootViewController:home];
    navh.delegate=self;
     [self addChildViewController:navh];
    //消息
    MesssageViewController *mesg=[[MesssageViewController alloc]init];
    Com_navigationController *navm=[[Com_navigationController alloc]initWithRootViewController:mesg];
    [self addChildViewController:navm];

    
    //广场
    UIViewController *square=[[UIViewController alloc]init];
    [self addChildViewController:square];
    [square.view setBackgroundColor:[UIColor brownColor]];
    Com_navigationController *navs=[[Com_navigationController alloc]initWithRootViewController:square];
    [self addChildViewController:navs];
    
    //我
    UIViewController *me=[[UIViewController alloc]init];
    [self addChildViewController:me];
    [me.view setBackgroundColor:[UIColor blueColor]];
    
    //更多
    MoreController *more=[[MoreController alloc]init];
    Com_navigationController *navmore=[[Com_navigationController alloc]initWithRootViewController:more];
    [self addChildViewController:navmore];
  
    
}

#pragma mark---实现选项卡到主视图控制器的协议方法
-(void)SendButtonAction:(NSInteger)oldtag To:(NSInteger)newtag
{
    //    self.Button_Tag=newtag;
    //    self.Button_Tag_old=oldtag;
    //  Debuglog(@"%d-----%d",oldtag,newtag);
    
    
    
    [self RunButionAction:oldtag To:newtag];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---根据按钮选择，实现其方法

-(void)RunButionAction:(NSInteger)oldtag To:(NSInteger)newtag
{
    if (newtag<0||newtag>kbutton_count)return;
    
    //1.取出将要添加到主视图控制器子视图
    UIViewController *current_c=self.childViewControllers[newtag];
    //1.2设置该子控制器的frame
    CGFloat weidth=self.view.frame.size.width;
    CGFloat height=self.view.frame.size.height-Ktabbar_height;
    [current_c.view setFrame:CGRectMake(0, 0, weidth, height)];
    //2.取出已经存在的子视图
    UIViewController *old_c=self.childViewControllers[oldtag];
    
    //3.将主视图控制器中子控制器移除
    [old_c.view removeFromSuperview];
    
    
    //4.添加新的子控制器主视图控制器
    [self.view addSubview:current_c.view];
    
}
//导航控制器代理----用于将导航控制器的视图调整为需要的frame
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *topController=navigationController.viewControllers[0];
    if (topController!=viewController) {
        CGRect frame=navigationController.view.frame;
        frame.size.height=[UIScreen mainScreen].applicationFrame.size.height+20.0f;
        
        navigationController .view.frame=frame;
        
    }else
    {
        CGRect frame=navigationController.view.frame;
        frame.size.height=[UIScreen mainScreen].applicationFrame.size.height-20;
        navigationController .view.frame=frame;
    }
     }
@end
