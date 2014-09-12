//
//  NoReplyCell.m
//  sinaweibo
//
//  Created by Json on 14-9-7.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "NoReplyCell.h"
#import "UIImage+Json_load_image.h"
#import "UIImage+Json_resize_image.h"
#import "NoCommentAndOtherView.h"
@interface NoReplyCell()
{
    NoCommentAndOtherView *_imgView;
}
@end

@implementation NoReplyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithContentView:(NoCommentAndOtherView*)ImgView WithChoice:(NSInteger)choice{
    _imgView=ImgView;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //设置背景
        [self setBackgroundColor:[UIColor whiteColor]];
   //        NSLog(@"theId %d",choice);
        switch (choice) {
            case 0:
                [self setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage GetStrechImageWithNomalImageName:@"timeline_retweet_background.png" WithLeftCapWidth:31.0f topCapHeight:10.0f]]];
                break;
                
            case 1:

                [self setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage ResizeThePicture:@"timeline_retweet_background1.png" WithUIEdgeInserts:UIEdgeInsetsMake(10.0f, 10.0f, 20.0f, 20.0f) resizingMode:UIImageResizingModeStretch]]];

                break;
            case 2:
                [self setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage GetStrechImageWithNomalImageName:@"timeline_retweet_background.png" WithLeftCapWidth:10.0f topCapHeight:10.0f]]];
                break;
            default:
                break;
        }
        //添加内容
        [self AddImage];
        
    }
    
    return self;
}
-(void )AddImage
{
    CGSize size=[_imgView CaculateTheFrame];
    [self.contentView addSubview:_imgView];
    [_imgView setFrame:CGRectMake((self.contentView.bounds.size.width-size.width)*0.6f, 40.0f, size.width, size.height)];
 
}

@end
