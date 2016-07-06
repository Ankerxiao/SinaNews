//
//  ScrollTableView.m
//  SinaSH
//
//  Created by keane on 16/7/4.
//  Copyright © 2016年 keane. All rights reserved.
//

#import "ScrollTableView.h"
#import "HomeNewsCell.h"

#define  TABLEVIEW_TAG_BEGIN 100
#define  CELL_ID @"cellId"
#define  CELL_HEIGHT 100

@interface ScrollTableView()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,assign)NSInteger tabViewCount;
@property (nonatomic,assign)NSInteger currentPageNum;
@end

@implementation ScrollTableView


-(instancetype)initWithTableViewCount:(NSInteger)count andDelegate:(id<ScrollTableViewDelegate>)delegate
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_STATUS_HEIGHT - TABBAR_HEIGHT)];
    if(self != nil){
        _tabViewCount = count;
        self.delegate = delegate;
        [self initSubViews];
    }
    return self;
}

-(instancetype)initWithTableViewCount:(NSInteger)count
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - TABBAR_HEIGHT)];
    if(self != nil){
        _tabViewCount = count;
        [self initSubViews];
    }
    return self;
}



- (void)initSubViews
{
    _scrollV = [[UIScrollView alloc] initWithFrame:self.bounds];
    [_scrollV setContentSize:CGSizeMake(_tabViewCount*SCREEN_WIDTH, self.height)];
    _scrollV.delegate = self;
    _scrollV.pagingEnabled = YES;
    
    for (int index = 0; index < _tabViewCount; index++) {
        UITableView *tabV = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*index, 0, SCREEN_WIDTH, _scrollV.height)];
        tabV.tag = TABLEVIEW_TAG_BEGIN+index;
        tabV.delegate = self;
        tabV.dataSource = self;
        
        if([self checkDelSelect:@selector(getNibWithTableSection:)]){
            [tabV registerNib:[_delegate getNibWithTableSection:index] forCellReuseIdentifier:[NSString stringWithFormat:@"%@_%ld",CELL_ID,tabV.tag]];
        }else{
            assert("error");
        }
        
        [_scrollV addSubview:tabV];
    }
    
    [self addSubview:_scrollV];
    
}



-(void)refreshTableViewWithSection:(NSInteger)index
{
    UITableView *tableT = [_scrollV viewWithTag:index+TABLEVIEW_TAG_BEGIN];
    [tableT performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}


#pragma mark TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self checkDelSelect:@selector(didSelectedTableViewCellWithSection:AndRow:)])
    {
        [_delegate didSelectedTableViewCellWithSection:tableView.tag-TABLEVIEW_TAG_BEGIN AndRow:indexPath.row];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([self checkDelSelect:@selector(tableViewCellHeightWithSection:AndRow:)]){
        return [_delegate tableViewCellHeightWithSection:tableView.tag-TABLEVIEW_TAG_BEGIN AndRow:indexPath.row];
    }
    return CELL_HEIGHT;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if([self checkDelSelect:@selector(tableViewNumberOfRowsInSection:)])
    {
        return [_delegate tableViewNumberOfRowsInSection:tableView.tag-TABLEVIEW_TAG_BEGIN];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self checkDelSelect:@selector(newsModelWithTableViewSection:andCellRow:)])
    {
        NewsModel *newsModel = [self.delegate newsModelWithTableViewSection:tableView.tag-TABLEVIEW_TAG_BEGIN andCellRow:indexPath.row];
        
        
        HomeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@_%ld",CELL_ID,tableView.tag]];
        [cell updateCellData:newsModel];
        return cell;
    }
    return nil;
}

//check Select是否存在
- (BOOL)checkDelSelect:(SEL)select
{
    return (_delegate != nil && [_delegate respondsToSelector:select]);
}


- (void)scrollTableViewListWithSecion:(NSInteger)section
{
    [_scrollV setContentOffset:CGPointMake(section*SCREEN_WIDTH, 0) animated:YES];
}

#pragma mark ScrollDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollDeal:scrollView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollDeal:scrollView];
}

- (void)scrollDeal:(UIScrollView*)scrollView
{
    if([scrollView isMemberOfClass:[UIScrollView class]]){
        
        NSLog(@"%f",scrollView.contentOffset.x/SCREEN_WIDTH);
        NSInteger pageNum = scrollView.contentOffset.x/SCREEN_WIDTH;
        if(pageNum != _currentPageNum){
            _currentPageNum = pageNum;
            if([self checkDelSelect:@selector(currentPageNumberChanged:)])
            {
                [_delegate currentPageNumberChanged:_currentPageNum];
            }
        }
        
        if([self checkDelSelect:@selector(loadTableViewDataWithSection:)]){
            [_delegate loadTableViewDataWithSection:pageNum];
        }
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
