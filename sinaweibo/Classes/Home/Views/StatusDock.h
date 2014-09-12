//
//  StatusDock.h
//  sinaweibo
//
//  Created by apple on 14-6-6.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <UIKit/UIKit.h>
#define StatusDockHeight  30.0f
@class WBContent;
@class StatusCell;
@interface StatusDock : UIImageView
@property (nonatomic, strong) WBContent *status;
@end
