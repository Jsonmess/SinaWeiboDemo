//
//  MesssageViewController.m
//  sinaweibo
//
//  Created by Json on 14-9-7.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "MesssageViewController.h"
#import "TableSectionHeaderView.h"
#import "ToolDockView.h"
@interface MesssageViewController ()

@end

@implementation MesssageViewController


- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [super viewDidLoad];
    ToolDockView *t=[[ToolDockView alloc]initToolDockView];
 CGSize size=   [t SetSubContentsFrame];
    [t setFrame:CGRectMake(0, 200, size.width, size.height)];
    [self.view addSubview:t];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
