//
//  PicCell.m
//  SinaSH
//
//  Created by Mr Lee on 16/7/6.
//  Copyright © 2016年 keane. All rights reserved.
//

#import "PicCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NewsModel.h"

@implementation PicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCellData:(NewsModel*)newsModel
{
    [self.PicV sd_setImageWithURL:[NSURL URLWithString:newsModel.kpic]];
    [self.titleL setText:newsModel.title];
    [self.totoalL setText:[NSString stringWithFormat:@"%@图",newsModel.pictotal]];
    self.iocnV.image = [UIImage imageNamed:@"feed_cell_commentIcon"];
    [self.commentL setText:newsModel.comment];
    
}


@end
