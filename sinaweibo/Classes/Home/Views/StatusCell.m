//
//  StatusCell.m
//  sinaweibo
//
//  Created by apple on 14-6-6.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "StatusCell.h"
#import "StatusCellFrame.h"
#import "UIImageView+WebCache.h"
#import "IconView.h"
#import "WBImageList.h"
#import "UIImage+Json_load_image.h"

@interface StatusCell()
{
    IconView *_icon; // 头像
    UILabel *_screenName; // 昵称
    UIImageView *_MBIcon;//会员图标
    UILabel *_time; // 时间
    UILabel *_source; // 来源
    UILabel *_text; // 内容
    WBImageList *_image; // 配图
    
    UIImageView *_retweeted; // 被转发微博的父控件
    UILabel *_retweetedScreenName; // 被转发微博作者的昵称
    UILabel *_retweetedText; // 被转发微博的内容
    WBImageList *_retweetedImage; // 被转发微博的配图

}
@end

@implementation StatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加微博本身的子控件
        [self addAllSubviews];
    
        // 2.添加被转发微博的子控件
        [self addReweetedAllSubviews];
        //3.设置cell背景
        [self setBackground];
           }
    return self;
}
//设置背景
-(void)setBackground
{
    self.backgroundView=[[UIImageView alloc]initWithImage: [UIImage GetStrechImageWithNomalImageName:@"common_card_background.png" WithLeftCapWidth:20.0f topCapHeight:20.0f] highlightedImage:[UIImage GetStrechImageWithNomalImageName:@"common_card_background_highlighted.png" WithLeftCapWidth:20.0f topCapHeight:20.0f]];

}

#pragma mark 添加微博本身的子控件
- (void)addAllSubviews
{
    // 1.头像
    _icon = [[IconView alloc] init];
    [self.contentView addSubview:_icon];
    
    // 2.昵称
    _screenName = [[UILabel alloc] init];
    _screenName.font = kScreenNameFont;
    [_screenName setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_screenName];
    
    //会员图标
    _MBIcon =[[UIImageView alloc]init];
    [self.contentView addSubview:_MBIcon];
    // 3.时间
    _time = [[UILabel alloc] init];
    _time.font = kTimeFont;
    [_time setBackgroundColor:[UIColor clearColor]];
    [_time setTextColor:[UIColor colorWithRed:1.0f green:191/255.0f blue:47/255.0f alpha:1.0f]];
    [self.contentView addSubview:_time];
    
    // 4.来源
    _source = [[UILabel alloc] init];
    [_source setTextColor:[UIColor colorWithRed:145/255.0f green:145/255.0f blue:145/255.0f alpha:1.0f]];
    _source.font = kSourceFont;
   [_source  setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_source];
    
    // 5.内容
    _text = [[UILabel alloc] init];
    _text.numberOfLines = 0;
    [_text  setBackgroundColor:[UIColor clearColor]];
    _text.font = kTextFont;
    
    [self.contentView addSubview:_text];
    
    // 6.配图
    _image = [[WBImageList alloc] init];
    [self.contentView addSubview:_image];
    //7.单元格工具栏
    _operationTool =[[StatusDock alloc]init];
    [self.contentView addSubview:_operationTool];

}

#pragma mark 被转发微博的子控件
- (void)addReweetedAllSubviews
{
    // 1.被转发微博的父控件
    _retweeted = [[UIImageView alloc] initWithImage:[UIImage GetStrechImageWithNomalImageName:@"timeline_retweet_background.png" WithLeftCapWidth:30.0f topCapHeight:10.0f] highlightedImage:[UIImage GetStrechImageWithNomalImageName:@"common_card_background_highlighted.png" WithLeftCapWidth:10.0f topCapHeight:10.0f]];
    [self.contentView addSubview:_retweeted];
    
    // 2.被转发微博的昵称
    _retweetedScreenName = [[UILabel alloc] init];
    _retweetedScreenName.font = kRetweetedScreenNameFont;
    [_retweetedScreenName  setBackgroundColor:[UIColor clearColor]];
    [_retweetedScreenName setTextColor:[UIColor colorWithRed:63/255.0f green:104/255.0f blue:161/255.0f alpha:1.0f]];
    [_retweeted addSubview:_retweetedScreenName];
    
    // 3.被转发微博的内容
    _retweetedText = [[UILabel alloc] init];
    _retweetedText.numberOfLines = 0;
    [_retweetedText  setBackgroundColor:[UIColor clearColor]];
    _retweetedText.font = kRetweetedTextFont;
    [_retweeted addSubview:_retweetedText];
    
    // 4.被转发微博的配图
    _retweetedImage = [[WBImageList alloc] init];
    [_retweeted addSubview:_retweetedImage];
}
#pragma mark 根据cellFrame设置自定义cell的内容以及frame---频繁调用
- (void)setStatusCellFrame:(StatusCellFrame *)statusCellFrame
{
    _statusCellFrame = statusCellFrame;
    
    WBContent *s = statusCellFrame.status;
    
    // 1.头像
    [_icon setTheUser:s.TheUser];
    [_icon SetIconViewAndVertifyIconWithType:kUserIconSmallType];
    [_icon CalulateFrameWithPoint:CGPointMake(kCellBorderWidth, kCellBorderWidth)];

    
    // 2.昵称
    _screenName.frame = statusCellFrame.screenNameFrame;
    _screenName.text = s.TheUser.screenName;
    //如果是会员，则设置昵称颜色为金黄色
    if (s.TheUser.mbtype!=kMBTypeNone) {
        [_screenName setTextColor:MBScreenNameColor];
        [_MBIcon setHidden:NO];
        
        [_MBIcon setImage:[UIImage imageNamed:@"common_icon_membership.png"]];
        [_MBIcon setFrame:statusCellFrame.MBIconFrame];
        
    }else{
        [_screenName setTextColor:ScreenNameColorNomal];
        [_MBIcon setHidden:YES];
    }
    
    
    // 3.时间
    _time.frame = statusCellFrame.timeFrame;
    
    //此处使用get方法，便于Cell动态更新时间
    _time.text = s.createdAt;
    
    
    // 4.来源
    _source.frame = statusCellFrame.sourceFrame;
    _source.text = s.source;
    
    // 5.内容
    _text.frame = statusCellFrame.textFrame;
    _text.text = s.text;
    [_text setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    // 6.配图
    if (s.picUrls.count) {
        _image.hidden = NO;
        _image.frame = statusCellFrame.imageFrame;

        _image.ImageUrlList=s.picUrls;
    } else {
        _image.hidden = YES;
    }
    
    // 7.被转发微博
    if (s.retweetedStatus) {
        _retweeted.hidden = NO;
        
        _retweeted.frame = statusCellFrame.retweetedFrame;
        
        
        // 8.昵称
        _retweetedScreenName.frame = statusCellFrame.retweetedScreenNameFrame;
        _retweetedScreenName.text = [NSString stringWithFormat:@"@%@",  s.retweetedStatus.TheUser.screenName];
        
        // 9.内容
        _retweetedText.frame = statusCellFrame.retweetedTextFrame;
        _retweetedText.text = s.retweetedStatus.text;
        
        
        // 10.配图
        if (s.retweetedStatus.picUrls.count) {
            _retweetedImage.hidden = NO;
            
            _retweetedImage.frame = statusCellFrame.retweetedImageFrame;
            
            _retweetedImage.ImageUrlList=s.retweetedStatus.picUrls;
            
        } else {
            _retweetedImage.hidden = YES;
        }
    } else {
        _retweeted.hidden = YES;
    }

        //11.设置单元格底部工具栏
    if (!statusCellFrame.IsWBdetail) {
        _operationTool.frame=statusCellFrame.OperationToolFrame;
        [_operationTool setStatus:s];
    } 
    
}
-(void)setFrame:(CGRect)frame
{
    if (!self.statusCellFrame.IsWBdetail) {
        //重写cellframe,此方法在加载uitableviewcell使用
        frame.origin.x=CellContentWidth;
        frame.size.width-=CellContentWidth*2;
        frame.origin.y+=CellContentHeight;
        frame.size.height-=CellContentHeight;
    }
    
    [super setFrame:frame];
}

@end
