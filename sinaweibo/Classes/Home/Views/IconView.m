//
//  IconView.m
//  sinaweibo-tableview定制
//
//  Created by Json on 14-8-27.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.
//

#import "IconView.h"
#import "WBUser.h"
#import "UIImageView+WebCache.h"

@interface IconView()
{
    UIImageView *_UserIconView;
    
    UIImageView *_VertifyIcon;
    
    NSString *PlaceImage;
    NSString *VertifyImage_name; //认证图像名称
    UserIconSize the_size;
}
@end
@implementation IconView

-(void)setTheUser:(WBUser *)TheUser
{
    _TheUser=TheUser;
}

-(void)SetIconViewAndVertifyIconWithType:(UserIconType)type
{
    //设置用户图标
      _UserIconView=[[UIImageView alloc]init];
    
    switch (type) {
        case kUserIconSmallType:
            PlaceImage=@"avatar_default_small.png";
            the_size=kUserIconSmallSzie;
            break;
        case kUserIconDefaultType:
            PlaceImage=@"avatar_default.png";
            the_size=kUserIconDefaultSize;
            break;
        case kUserIconBigType:
            PlaceImage=@"avatar_default_big.png";
            the_size=kUserIconBigSize;
            break;
        default:
            break;
    }
#warning 新浪返回头像的大小---在此暂时写死定为微缩图
   [_UserIconView setImageWithURL:[NSURL URLWithString:_TheUser.profileImageUrl] placeholderImage:[UIImage imageNamed:PlaceImage] options:SDWebImageLowPriority|SDWebImageRetryFailed ];
     [self addSubview:_UserIconView];
    
    //设置认证图标
    _VertifyIcon=[[UIImageView alloc]init];

    switch (_TheUser.verifiedType) {
           
        case kVerifiedTypeNone: // 没有认证认证
            _VertifyIcon.hidden = YES;
            break;
        case kVerifiedTypeDaren: // 微博达人
 
            VertifyImage_name = @"avatar_grassroot.png";
            break;
        case kVerifiedTypePersonal: // 个人

            VertifyImage_name = @"avatar_vip.png";
            break;
        default: // 企业认证
            VertifyImage_name = @"avatar_enterprise_vip.png";
            break;
    }
    if (VertifyImage_name) {
        [_VertifyIcon setHidden:NO];
         [_VertifyIcon setImage:[UIImage imageNamed:VertifyImage_name]];
    }
   
    [self addSubview:_VertifyIcon];

}
/**
 *    封装计算用户图标的Frame
 *
 *  @param Origin 指定IconView的起始点
 */
-(void)CalulateFrameWithPoint:(CGPoint)Origin
{
   //计算用户头像
    [_UserIconView setFrame:(CGRect){{0,0},{the_size,the_size}}];
    //计算认证大小
    CGFloat vertify_x=the_size-VertifyIconSize*0.5f;
    CGFloat vertify_y=vertify_x;
    [_VertifyIcon setFrame:CGRectMake(vertify_x, vertify_y, VertifyIconSize, VertifyIconSize)];
    //计算总的IconView的大小
  
  self.frame  = CGRectMake(Origin.x, Origin.y, vertify_x+VertifyIconSize, vertify_y+VertifyIconSize);
   
}
@end
