//
//  ToolDockView.h
//  sinaweibo
//
//  Created by Json on 14-9-10.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendButtonTouchEvent.h"
#import "ToolButtonLocate.h"
#import "ToolButtonPublic.h"
@interface ToolDockView : UIImageView
@property (nonatomic,strong)ToolButtonLocate *Locate;//位置
@property (nonatomic,strong)ToolButtonPublic *IsOpen;//微博开放程度

@property (nonatomic,strong)UIImageView *Tools; //工具dock
@property (nonatomic,strong)UIButton *SelectPic;//选择图片
@property (nonatomic,strong)UIButton *HistoryOfFriend;//最近联系人
@property (nonatomic,strong)UIButton *SearchTopic;//找话题
@property (nonatomic,strong)UIButton *EmotionKeyBoard;//表情键盘
@property (nonatomic,strong)UIButton *CloseKeyBoard;//关闭/打开键盘
@property(nonatomic,strong)id<SendButtonTouchEvent>BtnDelegate;
- (id)initToolDockView;
-(CGSize)SetSubContentsFrame;
@end
