//
//  TableSectionHeaderView.h
//  sinaweibo
//
//  Created by Json on 14-9-7.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBContent.h"
#import "SendTheChoice.h"
@interface TableSectionHeaderView : UIImageView
@property (nonatomic,strong)id<SendTheChoice>delegate;
- (id)initWithFrame:(CGRect)frame WithStatus:(WBContent *)Status;

@end
