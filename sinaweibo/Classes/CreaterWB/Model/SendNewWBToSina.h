//
//  SendNewWBToSina.h
//  sinaweibo
//
//  Created by Json on 14-9-11.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Json_weibo_cfg.h"
#import "WBaccount.h"
#import "NewWBContent.h"
#import "GetWBDataFromSina.h"
#import "SendNewWBStatus.h"
@interface SendNewWBToSina : NSObject
-(id)initWithNewContent:(NewWBContent*)content;
-(void)SendNewWBToSinaOnlyWithText;
@property(nonatomic,strong)id<SendNewWBStatus>senddelegate;
@end
