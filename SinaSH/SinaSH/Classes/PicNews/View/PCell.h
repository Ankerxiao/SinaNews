//
//  PCell.h
//  SinaSH
//
//  Created by Mr Lee on 16/7/6.
//  Copyright © 2016年 keane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *PicV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *iconV;
@property (weak, nonatomic) IBOutlet UILabel *picSumL;
@property (weak, nonatomic) IBOutlet UILabel *commentL;

@end
