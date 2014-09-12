//
//  WBUser.m
//  sinaweibo
//
//  Created by Json on 14-6-6.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "WBUser.h"

@implementation WBUser
-(id)initWithDictionary:(NSDictionary *)dic
{
    if (self=[super init]) {
        
        self.location=dic[@"location"];
        self.screenName=dic[@"screen_name"];
        self.profileImageUrl = dic[@"profile_image_url"];
        
        self.verified = [dic[@"verified"] boolValue];
        self.verifiedType = [dic[@"verified_type"] intValue];
        self.mbrank = [dic[@"mbrank"] intValue];
        
        switch ([dic[@"mbtype"] intValue]) {
            case 0:
                self.mbtype = kMBTypeNone;
                break;
            case 1:
                self.mbtype = kMBTypeNormal;
                break;
            case 2:
                self.mbtype = kMBTypeYear;
                break;
            default:
                break;
        }
    
        
    }
    return self;
}
@end
