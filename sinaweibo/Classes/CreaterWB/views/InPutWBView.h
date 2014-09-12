//
//  InPutWBView.h
//  sinaweibo
//
//  Created by Json on 14-9-10.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoveCreateToolDock.h"
#define NavigationAndStatusHeight 64.0f //导航栏高度
#define InputToolHeight 40.0f//输入工具栏高度
#define InputTextFont [UIFont systemFontOfSize:14.0f]
@interface InPutWBView : UIScrollView
@property (nonatomic,copy) NSString *CurrentStr;//结束编辑前的文字
@property (nonatomic,strong)id<MoveCreateToolDock>mdelegate;
@property (nonatomic,strong)  UITextView *InputWB;//输入框
@property (nonatomic,assign)  BOOL HaveEdited;//是否已经编辑
@end
