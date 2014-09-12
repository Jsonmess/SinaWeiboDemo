//
//  ReplyAndCommentCell.m
//  sinaweibo
//
//  Created by Json on 14-9-5.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "ReplyAndCommentCell.h"
#import "WbContent.h"
#import "UIImage+Json_load_image.h"
#import "IconView.h"

@interface ReplyAndCommentCell()
{
    BOOL IsCommentCell; //是否是评论？
    WBContent *_TheWbContent; //微博对象
    //显示内容对象
    IconView *_IconView;//头像
    UILabel *_ScreenName;//昵称
    UIImageView *_MBIcon;//会员图标
    UILabel *_Time; // 时间
    UILabel *_TextContent; //评价内容
}
@end
@implementation ReplyAndCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage GetStrechImageWithNomalImageName:@"timeline_retweet_background1.png" WithLeftCapWidth:10.0f topCapHeight:10.0f]]];
        //添加cell显示内容
        [self AddContent];

    }
    return self;
}
-(void)AddContent
{
    //将内容对象加入到contentview中
   _IconView=[[IconView alloc]init];
    _ScreenName =[[UILabel alloc]init];
    _ScreenName.font = [UIFont systemFontOfSize:11.0f];
    [_ScreenName setBackgroundColor:[UIColor clearColor]];
    
    _MBIcon=[[UIImageView alloc]init];
    _Time=[[UILabel alloc]init];
    _Time.font = [UIFont systemFontOfSize:9.0f];
    [_Time setBackgroundColor:[UIColor clearColor]];
    [_Time setTextColor:[UIColor colorWithRed:1.0f green:191/255.0f blue:47/255.0f alpha:1.0f]];

    _TextContent =[[UILabel alloc]init];
    _TextContent.numberOfLines = 0;
    [_TextContent  setBackgroundColor:[UIColor clearColor]];
    _TextContent .font=[UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:_IconView];
    [self.contentView addSubview:_ScreenName];
    [self.contentView addSubview:_MBIcon];
    [self.contentView addSubview:_Time];
    [self.contentView addSubview:_TextContent];
    
}
#pragma mark--- 设置frame
- (void)setReplyAndCommentcellFrame:(ReplyAndCommentCellFrame *)ReplyAndCommentcellFrame
{
    _ReplyAndCommentcellFrame=ReplyAndCommentcellFrame;
    WBComment *s = ReplyAndCommentcellFrame.status;
    // 1.头像
    [_IconView setTheUser:s.TheUser];
    [_IconView SetIconViewAndVertifyIconWithType:kUserIconSmallType];
    [_IconView CalulateFrameWithPoint:CGPointMake(kTheCellBorderWidth, kTheCellBorderWidth)];
    // 2.昵称
    _ScreenName.frame = ReplyAndCommentcellFrame.screenNameFrame;
    _ScreenName.text = s.TheUser.screenName;
    //如果是会员，则设置昵称颜色为金黄色
    if (s.TheUser.mbtype!=kMBTypeNone) {
        [_ScreenName setTextColor:MBScreenNameColor];
        [_MBIcon setHidden:NO];
        
        [_MBIcon setImage:[UIImage imageNamed:@"common_icon_membership.png"]];
        [_MBIcon setFrame:ReplyAndCommentcellFrame.MBIconFrame];
        
    }else{
        [_ScreenName setTextColor:ScreenNameColorNomal];
        [_MBIcon setHidden:YES];
    }
    // 3.时间
    _Time.frame = ReplyAndCommentcellFrame.timeFrame;
    
    //此处使用get方法，便于Cell动态更新时间
    _Time.text = s.createdAt;
    // 5.内容
    _TextContent.frame = ReplyAndCommentcellFrame.textFrame;
    _TextContent.text = s.text;
    [_TextContent setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{

    [super setSelected:selected animated:animated];

}
-(void)setFrame:(CGRect)frame
{
    frame.size.height+=1.0f;  //图片资源问题，调整图片边框厚度
    
    [super setFrame:frame];
}


@end
