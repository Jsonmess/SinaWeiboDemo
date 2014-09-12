//
//  WBImageList.h
//  sinaweibo-tableview定制
//
//  Created by Json on 14-8-29.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBImageList : UIImageView
@property(nonatomic,retain )NSArray *ImageUrlList;
@property(nonatomic,assign )CGRect ImageListFrame;
@property(nonatomic,retain )NSArray *ImageArrayList;
+ (CGSize)imageListSizeWithCount:(int)count;
@end
