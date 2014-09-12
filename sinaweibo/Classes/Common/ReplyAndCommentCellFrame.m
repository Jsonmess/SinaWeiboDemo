//
//  ReplyAndCommentCellFrame.m
//  sinaweibo
//
//  Created by Json on 14-9-9.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "ReplyAndCommentCellFrame.h"

@implementation ReplyAndCommentCellFrame
-(void)setStatus:(WBComment *)comment
{
    _status = comment;
    // 利用微博数据，计算所有子控件的frame
    
     CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width-2.0f; //cell整体的宽度
   
    // 1.头像
    //头像frame由IconView对象内部设置
    CGFloat iconX = kTheCellBorderWidth;
    
    CGFloat iconY = iconX;
    // 2.昵称
    CGFloat screenNameX = 2* kTheCellBorderWidth +kUserIconSmallSzie+kTheCellBorderWidth*0.5f;
    CGFloat screenNameY = iconY;
    CGSize screenNameSize = [comment.TheUser.screenName sizeWithFont:kTheScreenNameFont];
    _screenNameFrame = (CGRect){{screenNameX, screenNameY}, screenNameSize};
    
    if (comment.TheUser.mbtype!=kMBTypeNone) {
        
        _MBIconFrame =CGRectMake(CGRectGetMaxX(_screenNameFrame)+kTheCellBorderWidth, screenNameY+((_screenNameFrame.size.height-kTheMBIconSize)*0.5f), kTheMBIconSize, kTheMBIconSize);
    }
    
    // 3.时间
    CGFloat timeX = screenNameX+kTheCellBorderWidth*0.5f;
    CGFloat timeY = CGRectGetMaxY(_screenNameFrame) + kTheCellBorderWidth*0.5f;
    CGSize timeSize = [comment.createdAt sizeWithFont:[UIFont systemFontOfSize:9.0f]];
    _timeFrame = (CGRect){{timeX, timeY}, {timeSize.width+20.0f,timeSize.height}};
    //4.内容
    CGFloat textX =screenNameX ;
    CGFloat textY = CGRectGetMaxY(_timeFrame) + kTheCellBorderWidth;
    CGSize textSize = [comment.text sizeWithFont:TheTextFont constrainedToSize:CGSizeMake(cellWidth - 2 * kTheCellBorderWidth-textX, MAXFLOAT)];
    _textFrame = (CGRect){{textX, textY}, textSize};
    //整体cell的高度
     _cellHeight = kTheCellBorderWidth;
    
    _cellHeight += CGRectGetMaxY(_textFrame);
    
}
@end
