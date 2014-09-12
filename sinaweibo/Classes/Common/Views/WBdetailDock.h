//
//  WBdetailDock.h
//  sinaweibo
//
//  Created by Json on 14-9-4.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <UIKit/UIKit.h>
#define StatuDockHeight  40.0f
@class WBContent;

@interface WBdetailDock : UIImageView
@property (nonatomic, strong) WBContent *status;
@end
