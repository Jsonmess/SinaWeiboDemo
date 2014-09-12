//
//  CreateWBController.m
//  sinaweibo
//
//  Created by Json on 14-9-8.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "CreateWBController.h"
#import "InPutWBView.h"
#import "ToolDockView.h"
#import "WBImageList.h"
#import "MoreController.h"
#import "NewWBContent.h"
#import "SendNewWBToSina.h"
#import "MBProgressHUD.h"
#import "SendNewWBStatus.h"
@interface CreateWBController ()<MoveCreateToolDock,SendButtonTouchEvent,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SendNewWBStatus,MBProgressHUDDelegate>
{
    InPutWBView*_InPutWBView;//输入视图
    ToolDockView *_ToolDockView; //dock视图
    BOOL _KeyboardHidden;
    NSMutableArray *Images;//图片数组
    WBImageList *_ShowTheChoseImage;//显示所选择的图片;
    NewWBContent *_NewWBcontent;//要发送的微博对象;
    BOOL _IsWbOpen;//微博是否开放
    BOOL _IsAllowLocate;//是否允许定位
    MBProgressHUD *_hud;//指示器
}
@end

@implementation CreateWBController


- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置视图
    [self SetUpView];
    //设置代理
    [_InPutWBView setMdelegate:self];
    [_ToolDockView setBtnDelegate:self];

    //初始化_SwitchtheKeyboard
    _KeyboardHidden=NO;
    _IsAllowLocate=NO;
    _IsWbOpen=YES;
    Images=[NSMutableArray array];
    //初始化要发送微博的对象
    _NewWBcontent=[[NewWBContent alloc]init];
//添加指示器
    _hud=[[MBProgressHUD alloc]initWithView:self.view];
    [_hud setLabelText:@"发送成功"];
    [_hud setRemoveFromSuperViewOnHide:YES];
    [_hud setDelegate:self];
    _hud.margin = 10.f;
	_hud.yOffset = 150.f;
    [_hud setDimBackground:YES];
    // Do any additional setup after loading the view.
}
-(void)SetUpView
{
   self.title=@"发微博";
    [self.view setBackgroundColor:[UIColor colorWithRed:240.0f/255 green:240.0f/255 blue:240.0f/255 alpha:1.0f]];

//设置导航栏
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self SetNaviButtonWithTitle:@"取消" WithSender:leftbtn];
    [leftbtn addTarget:self  action:@selector(ChangeToCreateWB) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    
    UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //初始化设置为不可用
    [rightbtn setEnabled:NO];
    [self SetNaviButtonWithTitle:@"发送" WithSender:rightbtn];
    [rightbtn addTarget:self action:@selector(SendTheNewWbToSina) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    [self.navigationItem setLeftBarButtonItem:left];
    [self.navigationItem setRightBarButtonItem:right];
    //设置输入界面
    _InPutWBView =[[InPutWBView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height-InputToolHeight)];
    //进入界面就开启输入模式
    [_InPutWBView.InputWB becomeFirstResponder];
    [self.view addSubview:_InPutWBView];
    
    //设置Dock工具栏
    _ToolDockView =[[ToolDockView alloc]initToolDockView];
    CGSize size=  [_ToolDockView SetSubContentsFrame];

 
    [_ToolDockView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-66.0f, size.width, size.height)];
 
    [self.view addSubview:_ToolDockView];
    //添加显示图片视图
    _ShowTheChoseImage=[[WBImageList alloc]init];
    //[_ShowTheChoseImage setHidden:YES];
    [self.view addSubview:_ShowTheChoseImage];
    
}
-(void)SetNaviButtonWithTitle:(NSString *)title WithSender:(UIButton *)sender
{
    [sender setTitle:title forState:UIControlStateNormal];
    [sender setTitle:title forState:UIControlStateHighlighted];
    [sender setFrame:CGRectMake(0, 0, 32, 30)];
    [sender setTitleColor:[UIColor colorWithRed:245.0f/255.0f green:102.0f/255.0f blue:18.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    sender.titleLabel.font=[UIFont systemFontOfSize:16.0f];
}
-(void)ChangeToCreateWB
{
    [_InPutWBView.InputWB resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)SendTheNewWbToSina
{
    if (_InPutWBView.InputWB.text.length<1) {
        UIAlertView *EmptyContent=[[UIAlertView alloc]initWithTitle:@"哎呀，亲" message:@"你啥也没有写呢！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [EmptyContent show];
        [_InPutWBView.InputWB becomeFirstResponder];
    }
    else
    {
        //实现微博对象
           _NewWBcontent.WBtext= _InPutWBView.InputWB.text;
        SendNewWBToSina *sendwb=[[SendNewWBToSina alloc]initWithNewContent:_NewWBcontent];
        [sendwb setSenddelegate:self];
        [sendwb SendNewWBToSinaOnlyWithText];

    }
}

#pragma mark---实现代理协议方法
-(void)MoveCreateToolDockWithBool:(BOOL)IsOpenKeyBoard
{
    if (IsOpenKeyBoard) {
        //移动ToolDockView
        [UIView animateWithDuration:0.23f animations:^{
          //移动代码
            if ([[UIDevice currentDevice]systemVersion].intValue<=7) {
                _ToolDockView.transform=CGAffineTransformMakeTranslation(0, -215.0f);
            }else
               _ToolDockView.transform=CGAffineTransformMakeTranslation(0, -255.0f);
           
        } completion:nil];
    }else
    {
        [UIView animateWithDuration:0.2f animations:^{
            //复还代码
            _ToolDockView.transform=CGAffineTransformIdentity;
        } completion:nil];
    }
}
-(void)ShowTheSendStatusWithBool:(BOOL)Status
{
    if (!Status) {
            [_hud show:YES];
        //[_hud hide:YES afterDelay:1.0f];
        NSLog(@"yes");
    }else
    {
        NSLog(@"no");
    }
}
//部分_ToolDock按钮对应功能API未知，故不实现
-(void)SendButtonTouchEventWithID:(int)BtnID
{
    if ([_InPutWBView.InputWB isFirstResponder]) {
        _KeyboardHidden=NO;
    }
    switch (BtnID) {
            case 0:
            [self OpenPicturePicker];
           _InPutWBView.CurrentStr= _InPutWBView.InputWB.text;
            
            break;
        case 4:
            if(!_KeyboardHidden)
            {
                [_InPutWBView.InputWB resignFirstResponder];
                _KeyboardHidden=YES;
            }else
            {
                [_InPutWBView.InputWB becomeFirstResponder];
                _KeyboardHidden=NO;
            }
            
            break;
        case 5: //定位

            
            break;
        case 6://开放度
            _IsWbOpen=(_IsWbOpen==YES)?NO:YES;
            if (_IsWbOpen) {
                _NewWBcontent.WBOpenProperty=0;
                
            }else
            {
                _NewWBcontent.WBOpenProperty=1;
            }
            break;
        default:
            break;
    }
}

#pragma mark---打开图片选择器
-(void)OpenPicturePicker
{
    UIImagePickerController *pickercontroller=[[UIImagePickerController alloc]init];
    [pickercontroller setDelegate:self];
    [pickercontroller setAllowsEditing:YES];
    [pickercontroller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:pickercontroller animated:YES completion:nil];
}
//图片选择器协议
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [_InPutWBView.InputWB becomeFirstResponder];
        _InPutWBView.InputWB.text=_InPutWBView.CurrentStr;
        _KeyboardHidden=NO;
    }];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker.sourceType==UIImagePickerControllerSourceTypePhotoLibrary) {
        UIImage *image=info[@"UIImagePickerControllerEditedImage"];
        
        if (Images.count<1) {
            [Images addObject:image];
        }else
        {
            UIAlertView *EmptyContent=[[UIAlertView alloc]initWithTitle:@"抱歉，未知新浪批量上传图片API" message:@"应用暂时只添加1张图片，多添加的图片将忽略！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [EmptyContent show];
        }
    }

    [picker dismissViewControllerAnimated:YES completion:^{
        [_InPutWBView.InputWB becomeFirstResponder];
        _InPutWBView.InputWB.text=_InPutWBView.CurrentStr;
         _KeyboardHidden=NO;
    }];
    if (Images.count>0) {
          //显示选择的图片
        [_ShowTheChoseImage setHidden:NO];
      CGSize size=  [WBImageList imageListSizeWithCount:(int)Images.count];
        [_ShowTheChoseImage setFrame:CGRectMake(10.0f, 190.0f, size.width, size.height)];
        _ShowTheChoseImage.ImageArrayList=Images;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
