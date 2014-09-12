//
//  MoreController.m
//  sinaweibo
//
//  Created by Json on 14-6-1.
//  Copyright (c) 2014年 Json. All rights reserved.
//
//在本文件中自定义一个button类
@interface Logoutbtn : UIButton

@end
@implementation Logoutbtn
#pragma mark -  实现自定义按钮的方法
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x=10.0f;
    CGFloat y=0;
    CGFloat width=contentRect.size.width-x*2;
    CGFloat height=contentRect.size.height;
    return CGRectMake(x, y, width, height);
}
@end

#import "MoreController.h"
#import "JsonTableCell.h"
#import "UIImage+Json_resize_image.h"
#import "MoreTableView.h"
#import "WBaccount.h"
#import "Oauth_ViewController.h"
#define kTabbar_width 44
@interface MoreController ()<UIAlertViewDelegate>
{
    MoreTableView *tableview;
}
@property (strong,nonatomic)NSArray *Resoure;
@end

@implementation MoreController


- (void)viewDidLoad
{
   //搭建界面
    [self InitView];
    //读取资源文件,并初始化资源
    [self GetresoureFromPlist];

    [super viewDidLoad];
 
}

#pragma mark ----搭建界面
-(void)InitView
{
    self.navigationItem.title=@"更多";
   tableview=[[MoreTableView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width , self.view.bounds.size.height-kTabbar_width) style:UITableViewStyleGrouped];
   [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //1.设置背景颜色，但是前提是必须要将背景图片清空，因为背景图片优先级高于背景颜色
    [tableview setBackgroundView:nil];
    [tableview setBackgroundColor:[UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0f alpha:1.0f]];
   // [tableview setBackgroundColor:[UIColor blackColor]];
    //2.1设置组的头部间距
    tableview.sectionHeaderHeight=5.0f;
    //2.2设置组的底部间距
    tableview.sectionFooterHeight=0.8f;

    
    //3.1在列表底部添加一个按钮
    Logoutbtn *logout=[Logoutbtn buttonWithType:UIButtonTypeCustom];
    UIImage *nomal_btn=[UIImage ResizeThePicture:@"common_button_big_red.png" WithUIEdgeInserts:UIEdgeInsetsMake(20.0f, 7.0f, 20.0f, 7.0f) resizingMode:UIImageResizingModeStretch];
    [logout setImage:nomal_btn forState:UIControlStateNormal];
    UIImage *highligt_btn=[UIImage ResizeThePicture:@"common_button_big_red_highligted.png" WithUIEdgeInserts:UIEdgeInsetsMake(20.0f, 7.0f, 20.0f, 7.0f) resizingMode:UIImageResizingModeStretch];
    [logout setImage:highligt_btn forState:UIControlStateHighlighted];
    //tablefootview的宽度不需要设置，默认就是整个uitableview宽度
    [logout setBounds:CGRectMake(0, 0, 0, 44)];
    [logout setTitle:@"退出当前登陆" forState:UIControlStateNormal];
    
    //设置按钮方法（前提，已经实现新浪账户登录，后来做这个）
    [logout addTarget:self  action:@selector(LogouRegister) forControlEvents:UIControlEventTouchDown];
    [logout.titleLabel setTextAlignment:NSTextAlignmentCenter];
    tableview.tableFooterView=logout;
    [self.view addSubview: tableview];
    [tableview setDelegate:self];
    [tableview setDataSource:self];
    //4.tableview增加额外滚动区域,使得按钮距离底部8.0f。
    tableview.contentInset=UIEdgeInsetsMake(0, 0, 8.0f, 0);
    

}
#pragma mark ----读取资源文件,并初始化资源
-(void)GetresoureFromPlist
{
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"More.plist" withExtension:nil];
    self.Resoure=[NSArray arrayWithContentsOfURL:url];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return self.Resoure.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array=self.Resoure[section];
    return array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyCell";
    JsonTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        
        cell=[[JsonTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
          //设置单元格背景等属性
        [cell SetUpCell:indexPath WithData:self.Resoure];
    }
    //设置右边箭头属性
    NSIndexPath * index=indexPath;
    if (index.section==2) {
        UIView *theview=[[UIView alloc]init];
        theview.bounds=CGRectMake(0, 0, 74, 25);
        UILabel *label=[[UILabel alloc]init];
        label.backgroundColor=[UIColor clearColor];
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor grayColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.frame=CGRectMake(0, 10,60, 20);
        label.text=index.row ? @"有图模式":@"经典模式";
        UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_small_arrow.png"]];
        [image setFrame:CGRectMake(60, 0, 10, 10)];
        [theview addSubview:label];
        [theview addSubview:image];
        cell.accessoryView=theview;
    }
    //取出字典中的数据
    NSDictionary *dic=self.Resoure[indexPath.section][indexPath.row];
    cell.textLabel.text=dic[@"name"];
    cell.accessoryType=UIButtonTypeRoundedRect;
    return cell;
}

#pragma mark - 设置点击某一行后，背景颜色会恢复

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark----设置最后一组的底部间距
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==self.Resoure.count-1) {
        return 8.0f;
    }
    return 0;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section==0) {
//        return -60.0;
//    }
//    else{
//    return 0;
//    }
//}
#pragma mark-------实现账号登出（注销）
-(void)LogouRegister
{
    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定注销当前账户么？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
    [al show];
  
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {

              UIWindow *windw=[UIApplication sharedApplication].keyWindow;
                UIAlertView *as=[[UIAlertView alloc]initWithTitle:@"小提示" message:@"您已经成功注销，请返回登录！" delegate:windw cancelButtonTitle:@"确定" otherButtonTitles: nil];
              [as show];
        [windw setRootViewController:[[Oauth_ViewController alloc]init]];
    }
}
@end
