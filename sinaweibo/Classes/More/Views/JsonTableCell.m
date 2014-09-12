//
//  JsonTableCell.m
//  sinaweibo
//
//  Created by Json on 14-6-2.
//  Copyright (c) 2014年 Json. All rights reserved.
//
#import "JsonTableCell.h"
#import "UIImage+Json_resize_image.h"
@implementation JsonTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
#pragma mark---设置单元格
-(void)SetUpCell:(NSIndexPath *)index WithData:(NSArray *)resoure
{
    //1.单个组中只有一行单元格

    NSArray *array=resoure[index.section];
    if (array.count==1) {
        //设置背景图片，并且将图片拉伸 在UIImage+Json_resize_image.h中
        UIImage *nomal=[UIImage ResizeThePicture:@"common_card_background.png" WithUIEdgeInserts:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
        UIImage *selected=[UIImage ResizeThePicture:@"common_card_background_highlighted.png" WithUIEdgeInserts:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
        
       self.selectedBackgroundView=[[UIImageView alloc]initWithImage: selected];
       self.backgroundView=[[UIImageView alloc]initWithImage:nomal];
    }
    else if (index.row==0)
    {
        UIImage *nomal=[UIImage ResizeThePicture:@"common_card_top_background.png" WithUIEdgeInserts:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
        UIImage *selected=[UIImage ResizeThePicture:@"common_card_top_background_highlighted.png" WithUIEdgeInserts:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
        self.selectedBackgroundView=[[UIImageView alloc]initWithImage: selected];
        self.backgroundView=[[UIImageView alloc]initWithImage:nomal];
    }
    else if( index.row==array.count-1)
    {
        UIImage *nomal=[UIImage ResizeThePicture:@"common_card_bottom_background.png" WithUIEdgeInserts:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
        UIImage *selected=[UIImage ResizeThePicture:@"common_card_bottom_background_highlighted.png" WithUIEdgeInserts:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
        self.selectedBackgroundView=[[UIImageView alloc]initWithImage: selected];
        self.backgroundView=[[UIImageView alloc]initWithImage:nomal];
    }
    else{
        UIImage *nomal=[UIImage ResizeThePicture:@"common_card_middle_background.png" WithUIEdgeInserts:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
        UIImage *selected=[UIImage ResizeThePicture:@"common_card_middle_background_highlighted.png" WithUIEdgeInserts:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
        
        self.selectedBackgroundView=[[UIImageView alloc]initWithImage: selected];
        self.backgroundView=[[UIImageView alloc]initWithImage:nomal];
    }
    //设置文字背景(清空背景颜色)
    self.textLabel.backgroundColor=[UIColor clearColor];

      self.accessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_arrow.png"]];
 
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setFrame:(CGRect)frame
{
    frame.origin.x+=8.0f;
    frame.size.width-=16.0f;
    //frame.origin.y-=30.5f;
    //frame.size.height+=10.0f;
    [super setFrame:frame];
}
@end
