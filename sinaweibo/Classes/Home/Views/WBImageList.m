//
//  WBImageList.m
//  sinaweibo-tableview定制
//
//  Created by Json on 14-8-29.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.
//

#import "WBImageList.h"
#import "UIImageView+WebCache.h"
#define ImageViewCount 9  //数量
#define ImageViewSpace 10.0f //间距
#define ImageCountOneSize  120
#define ImageCountMoreSize  80
#define GifIconW 27
#define GifIconH 20
@interface WBImageList()
{
    UIImageView *GifIcon;
}
@end
@implementation WBImageList

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    //初始化九个图像视图
        for (NSInteger i=0; i<ImageViewCount; i++) {
            UIImageView *imageview=[[UIImageView alloc]init];
            //Gif标识
            GifIcon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif.png"]];
            [imageview addSubview:GifIcon];
            [self addSubview:imageview];
 
            
        }
        
    }
    return self;
}
/**
 *  根据传入的url数组，加载图片
 *
 *  @param ImageUrlList url数组
 */
-(void)setImageUrlList:(NSArray *)ImageUrlList
{
    NSInteger urlcount=ImageUrlList.count; //需要加载的图片数量
    for (NSInteger i=0; i<ImageViewCount; i++) {
        UIImageView *ChildImageView=self.subviews[i];
        //当图像视图编号大于等于图片数量，则隐藏
        if (i>=urlcount) {
            [ChildImageView setHidden:YES];
        }
        else
        {
            //加载图片
            [ChildImageView setHidden:NO];
            NSURL *url=[NSURL URLWithString:ImageUrlList[i][@"thumbnail_pic"]];
        
      [ChildImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"timeline_image_loading.png"] options:
             SDWebImageLowPriority|SDWebImageRetryFailed];
            if ([self ShouldAddGifIconWithChildImageViewUrl:ImageUrlList[i][@"thumbnail_pic"]]) {
                [ChildImageView.subviews[0] setHidden:NO];
            }
            else
            {
                [ChildImageView.subviews[0] setHidden:YES];
            }
            if (urlcount==1) {
                ChildImageView.contentMode=UIViewContentModeScaleAspectFit;
                [ChildImageView setFrame:CGRectMake(0, 0, ImageCountOneSize, ImageCountOneSize)];
                //计算gif的frame
                [ChildImageView.subviews[0] setFrame:CGRectMake(ImageCountOneSize-GifIconW, ImageCountOneSize-GifIconH, GifIconW, GifIconH)];
                continue;
            }
            // 超出边界的图片内容减掉
            ChildImageView.clipsToBounds = YES;
            ChildImageView.contentMode = UIViewContentModeScaleAspectFill;
            int temp = (urlcount == 4) ? 2 : 3;//3列or2列
            NSInteger row = i/temp; // 行号
            NSInteger column = i%temp; // 列号
            CGFloat x = (ImageCountMoreSize + ImageViewSpace) * column;
            CGFloat y = (ImageCountMoreSize + ImageViewSpace) * row;
            ChildImageView.frame = CGRectMake(x, y, ImageCountMoreSize, ImageCountMoreSize);
            [ChildImageView.subviews[0] setFrame:CGRectMake(ImageCountMoreSize-GifIconW, ImageCountMoreSize-GifIconH, GifIconW, GifIconH)];
        }
    }
}
-(void)setImageArrayList:(NSArray *)ImageArrayList
{
    NSInteger urlcount=ImageArrayList.count; //需要加载的图片数量
    for (NSInteger i=0; i<ImageViewCount; i++) {
        UIImageView *ChildImageView=self.subviews[i];
        //当图像视图编号大于等于图片数量，则隐藏
        if (i>=urlcount) {
            [ChildImageView setHidden:YES];
        }
        else
        {
            //加载图片
            [ChildImageView setHidden:NO];
            
            [ChildImageView setImage:ImageArrayList[i]];
            if (NO) {
                [ChildImageView.subviews[0] setHidden:NO];
            }
            else
            {
                [ChildImageView.subviews[0] setHidden:YES];
            }
            if (urlcount==1) {
                ChildImageView.contentMode=UIViewContentModeScaleAspectFit;
                [ChildImageView setFrame:CGRectMake(0, 0, ImageCountOneSize, ImageCountOneSize)];
                //计算gif的frame
                [ChildImageView.subviews[0] setFrame:CGRectMake(ImageCountOneSize-GifIconW, ImageCountOneSize-GifIconH, GifIconW, GifIconH)];
                continue;
            }
            // 超出边界的图片内容减掉
            ChildImageView.clipsToBounds = YES;
            ChildImageView.contentMode = UIViewContentModeScaleAspectFill;
            int temp = (urlcount == 4) ? 2 : 3;//3列or2列
            NSInteger row = i/temp; // 行号
            NSInteger column = i%temp; // 列号
            CGFloat x = (ImageCountMoreSize + ImageViewSpace) * column;
            CGFloat y = (ImageCountMoreSize + ImageViewSpace) * row;
            ChildImageView.frame = CGRectMake(x, y, ImageCountMoreSize, ImageCountMoreSize);
            [ChildImageView.subviews[0] setFrame:CGRectMake(ImageCountMoreSize-GifIconW, ImageCountMoreSize-GifIconH, GifIconW, GifIconH)];
        }
    }
}

+ (CGSize)imageListSizeWithCount:(int)count
{
    // 1张图片
    if (count == 1) {
        return CGSizeMake(ImageCountOneSize, ImageCountOneSize);
    }
    
    // 多于2张图片
    CGFloat countRow = (count == 4) ? 2 : 3;
    // 总行数
    int rows = (count + countRow - 1) / countRow;
    // 总列数
    int columns = (count >= 3) ? 3 : 2;
    
    CGFloat width = columns * ImageCountMoreSize + (columns - 1) * ImageViewSpace;
    CGFloat height = rows * ImageCountMoreSize + (rows - 1) * ImageViewSpace;
    return CGSizeMake(width, height);
}
-(BOOL)ShouldAddGifIconWithChildImageViewUrl:(NSString *)url
{
    if ([url.lowercaseString hasSuffix:@"gif"] ) {
        //是gif图
        return YES;
    }
    else{
       return NO;
    }
    
}
@end
