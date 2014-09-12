//
//  ReplyAndCommentCellFrame.h
//  sinaweibo
//
//  Created by Json on 14-9-9.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IconView.h"
#import "WBComment.h"
#import "WBUser.h"

#define kTheCellBorderWidth 10.0f  //cell边框大小
#define kTheScreenNameFont [UIFont systemFontOfSize:11]
#define kTheMBIconSize 11.0f       //会员图标大小
#define TheTextFont [UIFont systemFontOfSize:12.0f]//转发内容或评论内容字体大小

@class WBComment;
@interface ReplyAndCommentCellFrame : NSObject
@property (nonatomic, strong) WBComment *status;

@property (nonatomic, readonly) CGFloat cellHeight; // Cell的高度

@property (nonatomic, readonly) CGRect screenNameFrame; // 昵称
@property (nonatomic, readonly) CGRect MBIconFrame;  //会员图标
@property (nonatomic, readonly) CGRect timeFrame; // 时间
@property (nonatomic, readonly) CGRect textFrame; // 内容
@property (nonatomic, readonly) CGRect IconViewFrame; // 头像
@end
