//
//  HomeNewsCell.h
//  SinaSH
//
//  Created by keane on 16/7/4.
//  Copyright © 2016年 keane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface HomeNewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsImgView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;

@property (weak, nonatomic) IBOutlet UILabel *newsDetailL;
@property (weak, nonatomic) IBOutlet UILabel *commentL;


-(void)updateCellData:(NewsModel*)newsModel;

@end
