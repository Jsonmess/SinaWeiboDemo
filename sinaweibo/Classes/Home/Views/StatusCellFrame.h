//
//  StatusCellFrame.h
//  sinaweibo
//
//  Created by apple on 14-6-6.
//  Copyright (c) 2014年 Json. All rights reserved.
//  一个StatusCellFrame对象 能 描述 一个StatusCell内部所有子控件的frame
#define kCellBorderWidth 10  //cell边框大小
#define kMBIconSize 14       //会员图标大小
#define TimeSizeAdd 20.0f  //由于提高statusCell的效率 防止重复计算frame，故而进行手工添加微博创建大小
#define kScreenNameFont [UIFont systemFontOfSize:17]
#define kTimeFont [UIFont systemFontOfSize:13]
#define kSourceFont kTimeFont
#define kTextFont [UIFont systemFontOfSize:15]
#define kRetweetedTextFont [UIFont systemFontOfSize:16]
#define kRetweetedScreenNameFont [UIFont systemFontOfSize:16]
#define CellContentWidth 10.0f //调整单元格距离屏幕边缘的大小
#define CellContentHeight 10.0f //调整单元格距离上边屏幕边缘的大小

#import <Foundation/Foundation.h>
#import "WBImageList.h"
#import "StatusDock.h"
@class WBContent;
@interface StatusCellFrame : NSObject

@property (nonatomic, strong) WBContent *status;

@property (nonatomic, readonly) CGFloat cellHeight; // Cell的高度

@property (nonatomic, readonly) CGRect screenNameFrame; // 昵称
@property (nonatomic, readonly) CGRect MBIconFrame;  //会员图标
@property (nonatomic, readonly) CGRect timeFrame; // 时间
@property (nonatomic, readonly) CGRect sourceFrame; // 来源
@property (nonatomic, readonly) CGRect textFrame; // 内容
@property (nonatomic, readonly) CGRect imageFrame; // 配图

@property (nonatomic, readonly) CGRect retweetedFrame; // 被转发微博的父控件
@property (nonatomic, readonly) CGRect retweetedScreenNameFrame; // 被转发微博作者的昵称
@property (nonatomic, readonly) CGRect retweetedTextFrame; // 被转发微博的内容
@property (nonatomic, readonly) CGRect retweetedImageFrame; // 被转发微博的配图
@property (nonatomic, readonly) CGRect OperationToolFrame; // 单元格工具栏
@property (nonatomic, assign) BOOL IsWBdetail;   //是否是微博正文
@end
