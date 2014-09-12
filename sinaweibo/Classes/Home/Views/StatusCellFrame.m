//
//  StatusCellFrame.m
//  sinaweibo
//
//  Created by apple on 14-6-6.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "StatusCellFrame.h"
#import "WBContent.h"
#import "WBUser.h"
#import "IconView.h"


@implementation StatusCellFrame
-(id)init
{
    self=[super init];
    if (self) {
        //初始化微博正文判断
        self.IsWBdetail=NO;
    }
    return self;
}
-(void)setStatus:(WBContent *)status
{
    _status = status;
    // 利用微博数据，计算所有子控件的frame
    
    // 整个cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width-2*CellContentWidth;
    
    // 1.头像
    //头像frame由IconView对象内部设置
    CGFloat iconX = kCellBorderWidth;
    CGFloat iconY = kCellBorderWidth;
    
    // 2.昵称
    CGFloat screenNameX = 2* kCellBorderWidth +kUserIconSmallSzie;
    CGFloat screenNameY = iconY;
    CGSize screenNameSize = [status.TheUser.screenName sizeWithFont:kScreenNameFont];
    _screenNameFrame = (CGRect){{screenNameX, screenNameY}, screenNameSize};
    
    if (status.TheUser.mbtype!=kMBTypeNone) {
      
        _MBIconFrame =CGRectMake(CGRectGetMaxX(_screenNameFrame)+kCellBorderWidth, screenNameY+((_screenNameFrame.size.height-kMBIconSize)*0.5f), kMBIconSize, kMBIconSize);
    }

    // 3.时间
    CGFloat timeX = screenNameX+kCellBorderWidth*0.5f;
    CGFloat timeY = CGRectGetMaxY(_screenNameFrame) + kCellBorderWidth*0.5f;
    CGSize timeSize = [status.createdAt sizeWithFont:kTimeFont];
    _timeFrame = (CGRect){{timeX, timeY}, {timeSize.width+TimeSizeAdd,timeSize.height}};
    
    // 4.来源
    CGFloat sourceX = CGRectGetMaxX(_timeFrame) ;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:kSourceFont];
    _sourceFrame = (CGRect) {{sourceX, sourceY}, sourceSize};
    
    // 5.内容
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(_sourceFrame) + kCellBorderWidth;
    CGSize textSize = [status.text sizeWithFont:kTextFont constrainedToSize:CGSizeMake(cellWidth - 2 * kCellBorderWidth, MAXFLOAT)];
    _textFrame = (CGRect){{textX, textY}, textSize};
    
    if (status.picUrls.count) { // 6.有配图
        CGFloat imageX = textX;
        CGFloat imageY = CGRectGetMaxY(_textFrame) + kCellBorderWidth;
        _imageFrame = (CGRect){{imageX, imageY},  [WBImageList imageListSizeWithCount:(int)status.picUrls.count]};
        
    } else if (status.retweetedStatus) { // 7.有转发的微博
        // 被转发微博整体
        CGFloat retweetX = textX;
        CGFloat retweetY = CGRectGetMaxY(_textFrame) + kCellBorderWidth;
        CGFloat retweetWidth = cellWidth - 2 * kCellBorderWidth;
        CGFloat retweetHeight = kCellBorderWidth;
        
        // 8.被转发微博的昵称
        CGFloat retweetedScreenNameX = kCellBorderWidth;
        CGFloat retweetedScreenNameY = kCellBorderWidth;
      
        CGSize retweetedScreenNameSize = [ [ NSString stringWithFormat:@"@%@",status.retweetedStatus.TheUser.screenName] sizeWithFont:kRetweetedScreenNameFont];
        _retweetedScreenNameFrame = (CGRect){{retweetedScreenNameX, retweetedScreenNameY}, retweetedScreenNameSize};
        
        // 9.被转发微博的内容
        CGFloat retweetedTextX = retweetedScreenNameX;
        CGFloat retweetedTextY = CGRectGetMaxY(_retweetedScreenNameFrame) + kCellBorderWidth;
        CGSize retweetedTextSize = [status.retweetedStatus.text sizeWithFont:kRetweetedTextFont constrainedToSize:CGSizeMake(retweetWidth - 2 * kCellBorderWidth, MAXFLOAT)];
        _retweetedTextFrame = (CGRect){{retweetedTextX, retweetedTextY}, retweetedTextSize};
        
        // 10.被转发微博的配图
        if (status.retweetedStatus.picUrls.count) {
            CGFloat retweetedImageX = retweetedTextX;
            CGFloat retweetedImageY = CGRectGetMaxY(_retweetedTextFrame) + kCellBorderWidth;
            _retweetedImageFrame = (CGRect){{retweetedImageX, retweetedImageY}, [WBImageList imageListSizeWithCount:(int)status.retweetedStatus.picUrls.count]};
            
            retweetHeight += CGRectGetMaxY(_retweetedImageFrame);
        } else {
            retweetHeight += CGRectGetMaxY(_retweetedTextFrame);
        }
        
        _retweetedFrame = CGRectMake(retweetX, retweetY, retweetWidth, retweetHeight);
    }
    
    // 11.整个cell的高度
    _cellHeight = kCellBorderWidth+2*CellContentHeight;
    if (status.picUrls.count) {
        _cellHeight += CGRectGetMaxY(_imageFrame);
    } else if (status.retweetedStatus) {
        _cellHeight += CGRectGetMaxY(_retweetedFrame);
    } else {
        _cellHeight += CGRectGetMaxY(_textFrame);
    }

   //12.单元格工具栏的frame
    if (!self.IsWBdetail) {
        _OperationToolFrame=CGRectMake(0, _cellHeight-StatusDockHeight+kCellBorderWidth, cellWidth, WBOperationToolHeight);
        _cellHeight +=2*kCellBorderWidth;
    }
  
}

@end
