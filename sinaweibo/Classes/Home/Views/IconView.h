//
//  IconView.h
//  sinaweibo-tableview定制
//
//  Created by Json on 14-8-27.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VertifyIconSize 18.0f
typedef enum
{
    kUserIconDefaultSize=50, //中等图标大小
    kUserIconSmallSzie=34, //小图标大小
    kUserIconBigSize=85 //大图标大小
}UserIconSize;
typedef enum {
    kIconTypeSmall,
    kIconTypeDefault,
    kIconTypeBig
} IconType;
typedef enum{
    
    kUserIconSmallType, //用户小图标
    kUserIconDefaultType, //用户中图标
    kUserIconBigType //用户大图标
    
}UserIconType; //头像类型
@class WBUser;
@interface IconView : UIImageView
@property(nonatomic,retain)WBUser *TheUser;
@property (nonatomic,assign)IconType type;
-(void)SetIconViewAndVertifyIconWithType:(UserIconType)type;
-(void)CalulateFrameWithPoint:(CGPoint)Origin;
-(void)setTheUser:(WBUser *)TheUser;
@end
