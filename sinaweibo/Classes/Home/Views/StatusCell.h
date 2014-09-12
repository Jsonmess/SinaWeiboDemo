//
//  StatusCell.h
//  sinaweibo
//
//  Created by apple on 14-6-6.
//  Copyright (c) 2014年 Json. All rights reserved.
//  展示一条微博

#import <UIKit/UIKit.h>
#import "WBUser.h"
#import "WBContent.h"
#import "StatusDock.h"
@class StatusCellFrame;
@interface StatusCell : UITableViewCell

@property (nonatomic, strong)  StatusDock *operationTool; //单元格工具栏

@property (nonatomic, strong) StatusCellFrame *statusCellFrame;

@end
