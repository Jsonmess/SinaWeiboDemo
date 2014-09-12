

//
//  WBDetialController.m
//  sinaweibo
//
//  Created by Json on 14-9-4.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "WBDetialController.h"
#import "UIBarButtonItem+Json_barbuttonitem.h"
#import "Tabbar_view.h"
#import "WBdetailDock.h"
#import "ReplyAndCommentCell.h"
#import "TableSectionHeaderView.h"
#import "SendTheChoice.h"
#import "WBaccount.h"
#import "NoCommentAndOtherView.h"
#import "NoReplyCell.h"
#import "Json_weibo_cfg.h"
#import "MJRefresh.h"
#import "LoadCommentReportDataFromSina.h"
#define NavigationHeightAndStatusHeight 64.0f //状态栏和导航栏高度
#define TableViewGroupHeadHeight    30.0f  //表格头高度
#define NoReplyHeight  200.0f  //没有任何针对微博的回复评论赞，cell的高度
@interface WBDetialController ()<UITableViewDataSource,UITableViewDelegate,SendTheChoice>
{
    UITableView *TableView;
    WBContent *_WBcontent;
    NSInteger _GetChoice;
    NSMutableArray *WBComentArray;
    NSString *_accesstoken; //新浪令牌
     NSMutableArray *CCellFrames; //记录每一个tablecell的frame;
    int PageNum; //评论微博页数
    NSInteger WBCommentCount;//评论数量
//    
    NSMutableArray *WBReportArray;
    NSMutableArray *CCellFrames_R; //记录每一个tablecell的frame;
    int R_PageNum; //转发微博页数
    NSInteger WBCommentCount_R;//转发数量
}
@end
@implementation WBDetialController

- (void)viewDidLoad
{
    //初始化微博对象数组
    WBComentArray=[NSMutableArray array];
    CCellFrames=[NSMutableArray array];
    WBReportArray=[NSMutableArray array];
    CCellFrames_R=[NSMutableArray array];
    [self SetUpView];
    [self LoadTableView];
    [self AddDock];
    //初始化选择--默认是评论
    _GetChoice=1;
    [self LoadRefreshUI]; //上拉刷新
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark--加载刷新UI
-(void)LoadRefreshUI
{
    PageNum=0;
    R_PageNum=0;
    [TableView addFooterWithTarget:self action:@selector(AddMoreDataFromSina)];
    [TableView footerBeginRefreshing];
    
}
#pragma mark-上拉加载更多方法
-(void)AddMoreDataFromSina
{
    //第一次刷新
    switch (_GetChoice) {
        case 0:
            if (WBCommentCount_R<10&&R_PageNum==0) {
                R_PageNum=1;
                TableView.footerHidden=YES;
            }else
            {
                R_PageNum+=1;
                WBCommentCount_R-=10;
                if (WBCommentCount_R>0) {
                    TableView.footerHidden=NO;
                }else
                {
                    TableView.footerHidden=YES;
                }
            }
            [ self GetWBReportDataFromSinaWithPage:R_PageNum];
            break;
        case 1:
            if (WBCommentCount<10&&PageNum==0) {
                PageNum=1;
                TableView.footerHidden=YES;
            }else
            {
                PageNum+=1;
                WBCommentCount-=10;
                if (WBCommentCount>0) {
                    TableView.footerHidden=NO;
                }else
                {
                    TableView.footerHidden=YES;
                }
            }
            [ self GetWBcommentDataFromSinaWithPage:PageNum];
            break;
            
        default:
            [TableView footerEndRefreshing];
            break;
    }
    
   
}
-(void)SetUpView
{
    self.title =@"微博正文";
    UIBarButtonItem *backitem=[[UIBarButtonItem alloc]initWithTarget:self action:@selector(BackToHomeView) Nomal_image:@"navigationbar_back.png" Highlight_image:@"navigationbar_back_highlighted.png"];
    UIBarButtonItem *Shareitem=[[UIBarButtonItem alloc]initWithTarget:self action:@selector(ShareToOther) Nomal_image:@"navigationbar_more.png" Highlight_image:@"navigationbar_more_highlighted.png"];
    self.navigationItem.leftBarButtonItem=backitem;
    self.navigationItem.rightBarButtonItem=Shareitem;
    Tabbar_view *tab=[Tabbar_view ShareTabbar_view];
   [tab setHidden:YES];
    
    //查询数据库，获取用户的令牌
     _accesstoken=[[WBaccount ShareWBaccount]GetAccountFromSqlite3].accessToken;
}
//添加表格
-(void)LoadTableView
{
   TableView =[[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height-StatuDockHeight) style:UITableViewStylePlain];
    [TableView setDelegate:self];
    [TableView setBackgroundColor:[UIColor colorWithRed:230.0f/255 green:230.0f/255 blue:230.0f/255 alpha:1.0f]];
    [TableView setDataSource:self];
    [TableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    TableView .allowsSelection=NO;
    //开启表格Header事件监听方式
    [TableView.tableHeaderView setUserInteractionEnabled:YES];
    [self.view addSubview:TableView];
    
}
-(void)AddDock
{
    WBdetailDock *thedock=[[WBdetailDock alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(TableView.frame), self.view.bounds.size.width,StatuDockHeight)];
    
    [self.view addSubview:thedock];
}
#pragma mark---取得微博对象以及其frame
-(void)GetWBcontentAndWBframe:(WBContent *)wbcontent Frame:(StatusCellFrame*)cellframe
{
    _CellFrame=cellframe;
    //设置微博正文为yes
    [_CellFrame setIsWBdetail:YES];
   
    _WBcontent=wbcontent;
    //评论数量初始化
    WBCommentCount=_WBcontent.commentsCount;
    WBCommentCount_R=_WBcontent.repostsCount;
    [_CellFrame setStatus:_WBcontent];
 
}
#pragma mark---导航栏按钮监听方法
//分享
-(void)ShareToOther
{
    
}
//返回
-(void)BackToHomeView
{
    [self.navigationController popViewControllerAnimated:YES];
    Tabbar_view *tab=[Tabbar_view ShareTabbar_view];
    [tab setHidden:NO];

}
#pragma mark---表格代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger RowInsction = 0;
    if (section==0) {
        RowInsction=1;
    }
    else
    { 
        switch (_GetChoice) {
            case 0:
                if (_WBcontent.repostsCount!=0) {
                    RowInsction= CCellFrames_R.count;
                    
                }
                else RowInsction= 1;
                break;
                
            case 1:
                if (_WBcontent.commentsCount!=0) {
                    
                    RowInsction= CCellFrames.count;
                    
                }
                else
                    RowInsction= 1;
                break;
            case 2:
                
                if (_WBcontent.attitudesCount!=0) {
#warning --赞api未知
                RowInsction=1; //暂时返回1行
                }
                else RowInsction= 1;
                break;
                default:
                break;
                }

    }
    return RowInsction;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat HeightForRow=0;
    if (indexPath.section==0) {
        HeightForRow= _CellFrame.cellHeight;
    }
    else
    {
        ReplyAndCommentCellFrame *frame;
        ReplyAndCommentCellFrame *rframe;
        switch (_GetChoice) {
            case 0:
                if (CCellFrames_R.count!=0) {
                    rframe=CCellFrames_R[indexPath.row];
                }
                if (_WBcontent.repostsCount==0) {
                    HeightForRow= 200.0f;
                    
                }
                else HeightForRow= rframe.cellHeight;
                break;
                
            case 1:
                if (CCellFrames.count!=0) {
                    frame=CCellFrames[indexPath.row];
                }
                if (_WBcontent.commentsCount==0) {
                    HeightForRow= 200.0f;
                    
                }
                else HeightForRow= frame.cellHeight;
                break;
            case 2:
                
                if (_WBcontent.attitudesCount==0) {
                    HeightForRow= 200.0f;
                    
                }
                else HeightForRow= 30.0f;//赞api未知，暂时写30
                break;
            default:
                break;
        }

      
    }
    return HeightForRow;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ReusedString0 =@"DetailCell";
   
    StatusCell *cell=[TableView dequeueReusableCellWithIdentifier:ReusedString0];
    if (indexPath.section==0) {
        if (cell==nil) {
            cell=[[StatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReusedString0];
        }
        [cell setStatusCellFrame:_CellFrame];
        //隐藏cell底部的工具栏
        [cell.operationTool setHidden:YES];
        return cell;
    }
    else{
        
      return [self SetReplyAndCommentCellWithTableView:tableView IndexPath:indexPath];
    }
}
//设置有评论等视图
-(id)SetReplyAndCommentCellWithTableView:(UITableView *)tableview IndexPath:(NSIndexPath *)indexPath
{
static NSString *ReusedString1 =@"ReplyAndCommentCell";
   // static NSString *ReusedString2 =@"Replycell";
    ReplyAndCommentCell *ReplyAndCommentcell=[tableview dequeueReusableCellWithIdentifier:ReusedString1];
     //ReplyAndCommentCell *ReplyAndCommentcell1=[tableview dequeueReusableCellWithIdentifier:ReusedString1];
        switch (_GetChoice) {
            case 0:
                if (_WBcontent.repostsCount!=0) {
                   if (ReplyAndCommentcell==nil) {
                    ReplyAndCommentcell=[[ReplyAndCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReusedString1];
                   }
                     [ReplyAndCommentcell setReplyAndCommentcellFrame:CCellFrames_R[indexPath.row]];
                    return ReplyAndCommentcell;
                }else
                    return [self SetNoReplyCells];
               
                break;
                
            case 1:
                if (_WBcontent.commentsCount!=0) {
                    if (ReplyAndCommentcell==nil) {
                        ReplyAndCommentcell=[[ReplyAndCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReusedString1];
                    }
                    [ReplyAndCommentcell setReplyAndCommentcellFrame:CCellFrames[indexPath.row]];
                    return ReplyAndCommentcell;
                }else
                    return [self SetNoReplyCells];
              
                break;
            case 2:
               
                if (_WBcontent.attitudesCount!=0) {
                   
                        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                    [cell.textLabel setText:@"抱歉，获取赞用户列表API未知，暂不能实现！"];
                    [cell.textLabel setFont:[UIFont systemFontOfSize:12.0f]];
                    [cell.textLabel setTextColor:[UIColor grayColor]];
                    [TableView footerEndRefreshing];
                    return cell;
                }else
                    return [self SetNoReplyCells];
                break;
                 [ReplyAndCommentcell setReplyAndCommentcellFrame:CCellFrames[indexPath.row]];
            default:
                return ReplyAndCommentcell;
                break;
        }

}

//设置无评论等得视图
-(NoReplyCell*)SetNoReplyCells
{
  return [[NoReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil WithContentView:[self SetViewByChoice] WithChoice:_GetChoice];
}

#pragma mark----设置表格head
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {

        TableSectionHeaderView *theview=[[TableSectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, TableViewGroupHeadHeight)WithStatus:_WBcontent];
        [theview setDelegate:self];

        return theview;
        
    }
    return nil;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 2.0f;
    }
    else
    {
        return 30.0f;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;

}

#pragma mark---代理协议方法实现-----赞接口API未知，故禁止
-(void)SendTheChoiceID:(int)theId
{
    
    _GetChoice=theId;
  [TableView reloadData];
    //-----赞接口API未知，故禁止
 [TableView footerBeginRefreshing];

   
}
#pragma mark---用于根据选择转发，回复赞按钮 对应加载视图（数量为0）
-(UIImageView *)SetViewByChoice
{
    NoCommentAndOtherView *NoRepostView;
    if (_WBcontent.repostsCount==0&&_GetChoice==0) {
        //加载无转发视图
        NoRepostView=[[NoCommentAndOtherView alloc]initWithTheTitle:@"亲，暂无任何转发喔!" WithImageName:@"statusdetail_icon_empty_retweet.png"];

        
    }else if(_WBcontent.commentsCount==0&&_GetChoice==1)
    {
        NoRepostView=[[NoCommentAndOtherView alloc]initWithTheTitle:@"亲，还没有啥评论喔!" WithImageName:@"statusdetail_icon_empty_comment.png"];
   
        
    }else if (_WBcontent.attitudesCount==0&&_GetChoice==2)
    {
        NoRepostView=[[NoCommentAndOtherView alloc]initWithTheTitle:@"亲，还没有人赞过喔！" WithImageName:@"statusdetail_icon_empty_like.png"];
     
    }

    return NoRepostView;
}

#pragma mark---获取新浪对应id的微博的评论内容
-(void)GetWBcommentDataFromSinaWithPage:(int)Page
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [LoadCommentReportDataFromSina GetWBDataWithPath:KbaseUrl path:@"/2/comments/show.json" Params:@{
                          @"access_token":_accesstoken,
                        @"id":[NSString stringWithFormat:@"%lld",_WBcontent.WbID ],
                            @"page":[NSString stringWithFormat:@"%d",Page],
                          @"count":[NSString stringWithFormat:@"%d",10]
                         }
                                      WithGetSuccess:^(NSMutableArray *wbcomments) {
                                          [WBComentArray removeAllObjects];
                                          WBComentArray=wbcomments;
                                          //计算微博cell的frame---在此处计算frame，能保证是计算的最新数据
                                          for (WBComment *con in wbcomments) {
                                             // NSLog(@"%@",con.text);
                                               ReplyAndCommentCellFrame *frame=[[ReplyAndCommentCellFrame alloc]init];
                                              [frame setStatus:con];
                                            [CCellFrames addObject:frame];
                                          }
                                          //刷新表格数据
                                          [TableView reloadData];
                                          //结束刷新
                                          [TableView footerEndRefreshing];
                                          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                      } GetFailed:^(NSError *error) {
                                          
                                       //错误处理------------
                                          
                                           NSLog(@"%@",error.localizedDescription);
                                          //结束刷新
                                        [TableView footerEndRefreshing];
                                          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                      } WithMethod:@"GET" WithKeyWord:@"comments"];
    
}
#pragma mark---获取新浪对应id的微博的转发内容
-(void)GetWBReportDataFromSinaWithPage:(int)Page
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
[LoadCommentReportDataFromSina GetWBDataWithPath:KbaseUrl path:@"/2/statuses/repost_timeline.json" Params:@{
                                                                                                 @"access_token":_accesstoken,
                                                                                                 @"id":[NSString stringWithFormat:@"%lld",_WBcontent.WbID ],
                                                                                                 @"page":[NSString stringWithFormat:@"%d",Page],
                                                                                                 @"count":[NSString stringWithFormat:@"%d",10]
                                                                                                 }
                                  WithGetSuccess:^(NSMutableArray *wbcomments) {
                                      [WBComentArray removeAllObjects];
                                      WBReportArray=wbcomments;
                                      //计算微博cell的frame---在此处计算frame，能保证是计算的最新数据
                                      for (WBComment *con in wbcomments) {
                                          ReplyAndCommentCellFrame *frame=[[ReplyAndCommentCellFrame alloc]init];
                                          [frame setStatus:con];
                                          [CCellFrames_R addObject:frame];
                                      }
                                      //刷新表格数据
                                      [TableView reloadData];
                                      //结束刷新
                                      [TableView footerEndRefreshing];
                                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                  } GetFailed:^(NSError *error) {
                                      
                                      //错误处理------------
                                      
                                      NSLog(@"%@",error.localizedDescription);
                                      //结束刷新
                                      [TableView footerEndRefreshing];
                                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                  } WithMethod:@"GET" WithKeyWord:@"reposts"];

}
@end
