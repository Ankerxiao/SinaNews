//
//  ScrollTableView.h
//  SinaSH
//
//  Created by keane on 16/7/4.
//  Copyright © 2016年 keane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@protocol ScrollTableViewDelegate <NSObject>

//返回指定索引的TableView有多少个Cell
- (NSInteger)tableViewNumberOfRowsInSection:(NSInteger)section;

//返回指定索引的TableView的指定Row的cell数据
- (NewsModel*)newsModelWithTableViewSection:(NSInteger)section andCellRow:(NSInteger)row;

//返回指定索引的TableView中Cell的样式
- (UINib*)getNibWithTableSection:(NSInteger)section;

//要求代理去获取指定TableView所需的数据
- (void)loadTableViewDataWithSection:(NSInteger)section;

//通知代理当前显示页数(section)发生变化
- (void)currentPageNumberChanged:(NSInteger)currentPage;

//通知代理索引为section的tableview中第row个cell被点击
- (void)didSelectedTableViewCellWithSection:(NSInteger)section AndRow:(NSInteger)row;

@optional

//获取索引为section的tableview中的第row个cell的高度
- (CGFloat)tableViewCellHeightWithSection:(NSInteger)section AndRow:(NSInteger)row;

@end

@interface ScrollTableView : UIView
@property (nonatomic,strong)UIScrollView *scrollV;
@property (nonatomic,weak)id<ScrollTableViewDelegate> delegate;
@property (nonatomic,copy) NSString *sectionUrl;
-(instancetype)initWithTableViewCount:(NSInteger)index;
-(instancetype)initWithTableViewCount:(NSInteger)count andDelegate:(id<ScrollTableViewDelegate>)delegate;

//刷新指定索引的tableview
-(void)refreshTableViewWithSection:(NSInteger)index;

//滚动scrollTablView到指定的位置
-(void)scrollTableViewListWithSecion:(NSInteger)section;

@end
