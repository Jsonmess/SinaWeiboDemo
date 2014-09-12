//
//  Oauth_ViewController.m
//  sinaweibo
//
//  Created by Json on 14-8-23.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "Oauth_ViewController.h"
#import "Json_weibo_cfg.h"
#import "MBProgressHUD.h"
#import "MainController.h"
#import "HttpTool.h"
#import "WBaccount.h"
@interface Oauth_ViewController ()<UIWebViewDelegate,MBProgressHUDDelegate>
{
    UIWebView *_webview;
    MBProgressHUD *_mbprogresshud;
}
@end

@implementation Oauth_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height)];
    [self.view addSubview: _webview];
    //请求授权界面
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&display=%@",KregisterUrl,KappKey,Kappredirect_uri,Kdisplay]];
    NSURLRequest *request=[NSURLRequest requestWithURL: url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4.0f];
    [_webview loadRequest:request];
    [_webview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"register_view_bg.jpg"]]];
    [_webview setDelegate:self];
    
}
#pragma mark--UIWebview的代理方法
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //添加指示器
    MBProgressHUD *hud=[[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:hud];
    hud.dimBackground=YES;
    hud.delegate=self;
    hud.labelText=@"加载登陆页面...";
	hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    _mbprogresshud=hud;
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //这里进行拦截--根据request判断是否授权成功
    NSString *back_url=request.URL.absoluteString;
    
    NSRange range=[back_url rangeOfString:@"code="];
    if (range.length!=0) {
        if (!_mbprogresshud.hidden) {
            [_mbprogresshud setHidden:YES];
            MBProgressHUD *hud=[[MBProgressHUD alloc]initWithView:self.view];
            [self.view addSubview:hud];
            hud.dimBackground=YES;
            hud.delegate=self;
            hud.labelText=@"正在登陆...";
            hud.removeFromSuperViewOnHide = YES;
            [hud show:YES];
        }
        //截取字符串
        NSInteger index=range.location+range.length; //起点是‘=’
        NSString *thecode=[back_url substringFromIndex:index];
        
        //用code换取授权后的accesstoken
        [self GetAccessToken:thecode];
        
        
        return NO;
    }
    else
    {
        return YES;
    }

}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (error) {
        if (!_mbprogresshud.hidden) {
            [_mbprogresshud setHidden:YES];
            MBProgressHUD *hud=[[MBProgressHUD alloc]initWithView:self.view];
            [self.view addSubview:hud];
            hud.mode=MBProgressHUDModeText;
            hud.dimBackground=YES;
            hud.delegate=self;
            hud.labelText=@"加载失败";
            hud.detailsLabelText=@"网络故障，请检查";
            hud.removeFromSuperViewOnHide = YES;
            [hud show:YES];
        
        }
    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (!_mbprogresshud.hidden) {
        [_mbprogresshud setHidden:YES];
    }
    
    
}
#pragma mark---获取授权成功后的AccessToken

/**
 *  获取AccessToken
 *
 *  @param thecode 从重定向url中截取的code
 */
-(void)GetAccessToken:(NSString *)thecode
{
    
    [HttpTool HttpSendwithPath:@"https://api.weibo.com" path:@"/oauth2/access_token" Params:@{
                        @"client_id":KappKey,
                        @"client_secret":KappSecret,
                        @"grant_type":@"authorization_code",
                        @"code":thecode,
                        @"redirect_uri":Kappredirect_uri
                        
                        }
                   PostSuccess:^(id Json) {
                      
    //隐藏所有指示器
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //创建账号对象
    WBaccount *account=[WBaccount ShareWBaccount];
    [account SaveAccountToSqlite3WithAccessToken:Json[@"access_token"] Uid:Json[@"uid"]];
    //获取主窗口
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    window.rootViewController=[[MainController alloc]init];
    
    }
                     PostFaild:^(NSError *error) {
                         
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                       
    
    } WithMethod:@"POST"];
    
    
}
@end
