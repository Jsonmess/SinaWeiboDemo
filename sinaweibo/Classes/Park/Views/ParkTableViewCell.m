//
//  ParkTableViewCell.m
//  sinaweibo
//
//  Created by Json on 14-9-15.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "ParkTableViewCell.h"

@implementation ParkTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
