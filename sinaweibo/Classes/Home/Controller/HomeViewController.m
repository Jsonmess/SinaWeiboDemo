//
//  HomeViewController.m
//  sinaweibo
//
//  Created by Json on 14-6-1.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+Json_barbuttonitem.h"
#import "MBProgressHUD.h"
#import "GetWBDataFromSina.h"
#import "Json_weibo_cfg.h"
#import "WBaccount.h"
#import "WBContent.h"
#import "WBUser.h"
#import "Sqlite3Manager.h"
#import "StatusCell.h"
#import "StatusCellFrame.h"
#import "MJRefresh.h"
#import "WBDetialController.h"
#import "Com_navigationController.h"
#import "UIImage+Json_resize_image.h"
#import "CreateWBController.h" //创建微博
#define DockHeight 44.0f

@interface HomeViewController ()
{
    MBProgressHUD *_hud; //指示器
    NSString *_accesstoken; //新浪数据获取令牌
    NSMutableArray *WBContentArray;
    UITableView *tableview;
    NSMutableArray *CellFrames; //记录每一个tablecell的frame;
    
    int PageNum; //微博页数     ---->|
                      //                    --->两者用于区分上拉加载更多，下拉刷新
    BOOL IsAddMore; //是否加载更多?   ----->|
}
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    
    //初始化微博对象数组
    WBContentArray=[NSMutableArray array];
    //设置主界面属性
    [self SetupView];
    CellFrames=[NSMutableArray array];
    [self LoadTableView];
    [self.view setBounds:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-44.0f)];
    [self.view.subviews[0] setBackgroundColor:[UIColor colorWithRed:230.0f/255 green:230.0f/255 blue:230.0f/255 alpha:1.0f]];
    //加载刷新UI
   [self LoadRefreshUI];
    //初始化音效
    [self LoadAudio];
    [super viewDidLoad];

}
#pragma mark--加载刷新UI
-(void)LoadRefreshUI
{
    PageNum=1;
    IsAddMore=NO;
    [self.view.subviews[0] addHeaderWithTarget:self action:@selector(RefreshDataFromSina)];
    [self.view.subviews[0] headerBeginRefreshing];
    [self.view .subviews[0] addFooterWithTarget:self action:@selector(AddMoreDataFromSina)];
 
}

#pragma mark-下拉刷新方法
-(void)RefreshDataFromSina
{
    PageNum=1;
    IsAddMore=NO;
    //处理json数据
      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [ self LoadWeiboDataWithPage:PageNum];
   
}
#pragma mark-上拉加载更多方法
-(void)AddMoreDataFromSina
{
    IsAddMore=YES;
    PageNum++;
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [ self LoadWeiboDataWithPage:PageNum];
   
}

#pragma mark--加载刷新完成后音效
-(void)LoadAudio
{
    _pullId=[self loadSoundId:@"pull.wav"];
    _refreshingId=[self loadSoundId:@"refreshing.wav"];
    _endRefreshId=[self loadSoundId:@"end_refreshing.wav"];
    _normalId=[self loadSoundId:@"normal.wav"];
}
- (SystemSoundID)loadSoundId:(NSString *)soundFile
{
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:soundFile ofType:nil]];

    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundId);
    
    return soundId;
}
#pragma mark 展示最新微博的数目
- (void)showNewStatus
{
    // 1.创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.enabled = NO;
    btn.adjustsImageWhenDisabled = NO;
    
    [btn setBackgroundImage:[UIImage ResizeThePicture:@"timeline_new_status_background.png" WithUIEdgeInserts:UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    CGFloat w = self.view.frame.size.width;
    CGFloat h = 35;
    btn.frame = CGRectMake(-self.view.bounds.size.width, 64, w, h);
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [ btn setTitle:@"微博数据已刷新" forState:UIControlStateDisabled];
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 2.开始执行动画
    CGFloat duration = 0.4f;
    [UIView animateWithDuration:duration animations:^{
        btn.transform = CGAffineTransformMakeTranslation(self.view.bounds.size.width, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformMakeTranslation(2*self.view.bounds.size.width, 0);
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
}

#pragma mark----设置主界面属性
-(void)SetupView
{
    //1.设置标题
    self.title=@"首页";
    
    // 2.设置左按钮
    UIBarButtonItem *left=[[UIBarButtonItem alloc ]initWithTarget:self action:@selector(WriteWB) Nomal_image:@"navigationbar_compose.png" Highlight_image:@"navigationbar_compose_highlighted.png" ];
    
    self.navigationItem.leftBarButtonItem=left;
    
    //3.设置右边按钮
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTarget:self action:@selector(PopMenu) Nomal_image:@"navigationbar_pop.png" Highlight_image:@"navigationbar_pop_highlighted.png"];
    
    self.navigationItem.rightBarButtonItem=right;
    //查询数据库，得到accesstoken
  _accesstoken=[[WBaccount ShareWBaccount]GetAccountFromSqlite3].accessToken;

}

-(void)LoadTableView
{
    //初始化tableview
    tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    //取消分割线
    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [tableview setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-DockHeight)];
    [self.view addSubview:tableview];
    //设置代理
    [tableview setDelegate:self];
    [tableview setDataSource:self];

}

/**
 *  请求用户以及关注的人的微博数据
 */
-(void)LoadWeiboDataWithPage:(int)Page
{
  
    [GetWBDataFromSina GetWBDataWithPath:KbaseUrl path:@"/2/statuses/home_timeline.json" Params:@{
                                                            @"access_token":_accesstoken,
                                                            @"page":[NSString stringWithFormat:@"%d",Page]
                                                       
                                              }
                WithGetSuccess:^(NSMutableArray *wbcontents) {
                    
                    //隐藏指示器
                    [_hud hide:YES];
                
                    if (IsAddMore) {
                       [WBContentArray addObjectsFromArray:wbcontents];
                    }else
                    {
                        [WBContentArray removeAllObjects];
                        WBContentArray=wbcontents;
                    }
                   
                    //清楚微博数组内的所有对象
                    if (!IsAddMore) {
                        [CellFrames removeAllObjects];
                    }
                    //计算微博cell的frame---在此处计算frame，能保证是计算的最新数据
                    for (WBContent *con in wbcontents) {
                        
                        StatusCellFrame  *frame=[[StatusCellFrame alloc]init];
                        [frame setStatus:con];
                        [CellFrames addObject:frame];
  
                    }
                    //刷新表格数据
                    [tableview reloadData];
                    //结束刷新
                    [self.view.subviews[0] headerEndRefreshing];
                    [self.view.subviews[0] footerEndRefreshing];
                    if (!IsAddMore) {
                         AudioServicesPlaySystemSound(_endRefreshId);
                    }else  AudioServicesPlaySystemSound(_pullId);
                        
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                     if (!IsAddMore) {
                    [self showNewStatus];
                     }
                } GetFailed:^(NSError *error) {
                    
                    if (![_hud isHidden]) {
                        [_hud hide:YES];
                        //添加错误提示
                        _hud =[[MBProgressHUD alloc]init];
                        [_hud setMode:MBProgressHUDModeText];
                        [_hud setLabelText:@"网络出错"];
                        [_hud setDetailsLabelText:@"貌似您没有联网，或者网络质量差"];
                        [_hud setDimBackground:YES];
                        [self.view addSubview:_hud];
                        [_hud show:YES];
                    }
                   
                   // NSLog(@"%@",error.localizedDescription);
                    //结束刷新
                    [self.view.subviews[0] headerEndRefreshing];
                    [self.view.subviews[0] footerEndRefreshing];
                  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                } WithMethod:@"GET"];
    
    
  }
#pragma mark--------导航栏按钮Action
-(void)WriteWB
{
    Debuglog(@"写微博");
    CreateWBController *CreateWB=[[CreateWBController alloc]init];
    UINavigationController *CreateWBNav=[[UINavigationController alloc]initWithRootViewController:CreateWB];
    [self presentViewController:CreateWBNav animated:YES completion:nil];
    
}
-(void)PopMenu
{
    Debuglog(@"弹出菜单");
}


#pragma  mark  uitableview的代理方法
/**
 *  代理方法
 */

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return WBContentArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ReuseIdentifier=@"WeiboCell";
    StatusCell *cell=[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (cell==nil) {
        cell=[[StatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ReuseIdentifier];
        
    }
    [cell setStatusCellFrame:CellFrames[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBDetialController *wbdetail=[[WBDetialController alloc]init];
    
    //设置选择哪一行的微博内容以及其cellframe
    WBContent *content=WBContentArray[indexPath.row];
    StatusCellFrame *frame=CellFrames[indexPath.row];
    [wbdetail GetWBcontentAndWBframe:content Frame:frame];
    
    [self.navigationController pushViewController:wbdetail animated:YES];
    AudioServicesPlaySystemSound(_pullId);
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    StatusCellFrame  *frame=CellFrames[indexPath.row];

    return frame.cellHeight;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end