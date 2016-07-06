//
//  PicCell.h
//  SinaSH
//
//  Created by Mr Lee on 16/7/6.
//  Copyright © 2016年 keane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface PicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *PicV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *iocnV;
@property (weak, nonatomic) IBOutlet UILabel *commentL;
@property (weak, nonatomic) IBOutlet UILabel *totoalL;

-(void)updateCellData:(NewsModel*)newsModel;

@end
