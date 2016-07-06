//
//  HomeNewsCell.m
//  SinaSH
//
//  Created by keane on 16/7/4.
//  Copyright © 2016年 keane. All rights reserved.
//

#import "HomeNewsCell.h"
#import <UIImageView+WebCache.h>

@implementation HomeNewsCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)updateCellData:(NewsModel*)newsModel
{
    [self.newsTitle setText:newsModel.title];
    [self.newsDetailL setText:newsModel.intro];
    [self.commentL setText:newsModel.comment];
    [self.newsImgView sd_setImageWithURL:[NSURL URLWithString:newsModel.kpic]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
