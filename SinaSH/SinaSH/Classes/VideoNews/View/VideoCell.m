//
//  VideoCell.m
//  SinaSH
//
//  Created by keane on 16/7/5.
//  Copyright © 2016年 keane. All rights reserved.
//

#import "VideoCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation VideoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCellData:(NewsModel*)newsModel
{
    [self.picView sd_setImageWithURL:[NSURL URLWithString:newsModel.kpic]];
    [self.titleL setText:newsModel.title];
}

@end
