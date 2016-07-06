//
//  BtnListScrollerView.h
//  SinaSH
//
//  Created by keane on 16/7/4.
//  Copyright © 2016年 keane. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BtnListScrollerViewDelegate <NSObject>
- (void)didSelectedBtnWithIndex:(NSInteger)index;
@end

@interface BtnListScrollerView : UIView
@property (nonatomic,weak)id <BtnListScrollerViewDelegate> delegate;

-(instancetype)initWithBtnTitleArray:(NSArray*)btnTitleArray;
- (void)scrollBtnListWithIndex:(NSInteger)btnIndex;
@end
