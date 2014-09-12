//
//  SendNewWBToSina.m
//  sinaweibo
//
//  Created by Json on 14-9-11.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "SendNewWBToSina.h"
#import "MBProgressHUD.h"
@interface SendNewWBToSina()
{
    NSString *_accesstoken;
    NewWBContent *_NewContent;

}
@end
@implementation SendNewWBToSina

-(id)initWithNewContent:(NewWBContent*)content
{
    self =[super init];
    if (self) {
        _NewContent=content;
      //获取accesstoken
        _accesstoken=[[WBaccount ShareWBaccount]GetAccountFromSqlite3].accessToken;
    }
    return self;
}
-(void)SendNewWBToSinaOnlyWithText
{

    [GetWBDataFromSina GetWBDataWithPath:KbaseUrl path:@"/2/statuses/update.json" Params:@{
                                    @"access_token":_accesstoken,
                                    @"status": _NewContent.WBtext,
                                    @"visible":[NSString stringWithFormat:@"%d", (int)_NewContent.WBOpenProperty]//,
//                                    @"lat":[NSString stringWithFormat:@"%f", _NewContent.Lat],
//                                    @"long":[NSString stringWithFormat:@"%f", _NewContent.Long]
                                    }
 WithGetSuccess:^(NSMutableArray *wbcontents) {
     [self.senddelegate ShowTheSendStatusWithBool:YES];
} GetFailed:^(NSError *error) {
    [self.senddelegate ShowTheSendStatusWithBool:NO];
} WithMethod:@"POST"];
}


@end
