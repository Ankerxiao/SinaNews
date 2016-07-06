//
//  VideoCell.h
//  SinaSH
//
//  Created by keane on 16/7/5.
//  Copyright © 2016年 keane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface VideoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;

-(void)updateCellData:(NewsModel*)newsModel;
@end
