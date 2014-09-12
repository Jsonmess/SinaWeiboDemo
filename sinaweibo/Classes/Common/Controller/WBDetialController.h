//
//  WBDetialController.h
//  sinaweibo
//
//  Created by Json on 14-9-4.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBContent.h"
#import "StatusCell.h"
#import "StatusCellFrame.h"
@interface WBDetialController : UIViewController
{
     StatusCellFrame *_CellFrame;
}
-(void)GetWBcontentAndWBframe:(WBContent *)wbcontent Frame:(StatusCellFrame*)cellframe;
@end
