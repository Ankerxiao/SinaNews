//
//  PicNewsVC.m
//  SinaSH
//
//  Created by keane on 16/7/4.
//  Copyright © 2016年 keane. All rights reserved.
//

#import "PicNewsVC.h"
#import "NetManager.h"
#import "NewsModel.h"
#import "ScrollTableView.h"
#import "NewsDetailVC.h"
#import "BtnListScrollerView.h"

@interface PicNewsVC ()<BtnListScrollerViewDelegate,ScrollTableViewDelegate>

@property (nonatomic,strong)NSMutableArray *totalNewsArray;

@property (nonatomic,strong)ScrollTableView *scrollTableView;

@property (nonatomic,strong)BtnListScrollerView *btnScroll;

@property (nonatomic,strong)NSArray *orignArray;

@end

@implementation PicNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initNavView];
    [self initSubViews];
    [self loadDataWithIndex:0];

    
}

- (void)initData
{
    
    _orignArray = @[@{@"hdpic_toutiao":@"图片"},
                    @{@"hdpic_funny":@"趣图"},
                    @{@"hdpic_funny":@"美图"},
                    @{@"hdpic_funny":@"故事"}];
    
    _totalNewsArray = [[NSMutableArray alloc] init];
    
    NSInteger count = [_orignArray count];
    while (count--) {
        [_totalNewsArray addObject:[[NSMutableArray alloc] init]];
    }
}

- (void)initSubViews
{
    _scrollTableView = [[ScrollTableView alloc] initWithTableViewCount:[_orignArray count] andDelegate:self];
    [self.view addSubview:_scrollTableView];
}

- (void)loadDataWithIndex:(NSInteger)index
{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?channel=%@",[[_orignArray[index] allKeys] firstObject]];
    [[NetManager shareManager] requestUrl:urlStr WithSuccessBlock:^(id data) {
        NSMutableArray *arrayTemp = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in data[@"data"][@"list"]) {
            NewsModel *newsModel = [[NewsModel alloc] initWithDictionary:dic error:nil];
            [arrayTemp addObject:newsModel];
        }
        NSLog(@"%@",arrayTemp);
        
        [_totalNewsArray replaceObjectAtIndex:index withObject:arrayTemp];
        //[_totalNewsArray insertObject:arrayTemp atIndex:index];
        
        [_scrollTableView refreshTableViewWithSection:index];
        
    } andFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)initNavView
{
    NSMutableArray *btnTitle = [[NSMutableArray alloc] init];
    for (NSDictionary* dic in _orignArray) {
        
        [btnTitle addObject:[dic valueForKey:[[dic allKeys]firstObject]]];
    }
    
    _btnScroll = [[BtnListScrollerView alloc] initWithBtnTitleArray:btnTitle];
    _btnScroll.delegate = self;
    self.navigationItem.titleView = _btnScroll;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ScrollTableViewDelegate
//通知代理索引为section的tableview中第row个cell被点击
- (void)didSelectedTableViewCellWithSection:(NSInteger)section AndRow:(NSInteger)row
{
    NewsModel *newsModel = _totalNewsArray[section][row];
    NSLog(@"%@ %@",newsModel.title,newsModel.link);
    
    NewsDetailVC *vc = [[NewsDetailVC alloc] initWithUrl:newsModel.link];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//返回指定索引的TableView有多少个Cell
- (NSInteger)tableViewNumberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%ld",section);
    NSLog(@"%@",_totalNewsArray);
    return [_totalNewsArray[section] count];
}

//返回指定索引的TableView的指定Row的cell数据
- (NewsModel*)newsModelWithTableViewSection:(NSInteger)section andCellRow:(NSInteger)row
{
    return _totalNewsArray[section][row];
}

//返回指定索引的TableView中Cell的样式
- (UINib*)getNibWithTableSection:(NSInteger)section
{
    return [UINib nibWithNibName:@"PicCell" bundle:nil];
}

//要求代理去获取指定TableView所需的数据
- (void)loadTableViewDataWithSection:(NSInteger)section
{
    [self loadDataWithIndex:section];
}

//通知代理当前显示页数(section)发生变化
- (void)currentPageNumberChanged:(NSInteger)currentPage
{
    [_btnScroll scrollBtnListWithIndex:currentPage];
}

#pragma mark BtnListScrollerViewDelegate
- (void)didSelectedBtnWithIndex:(NSInteger)index
{
    NSLog(@"didSelectedBtnWithIndex %ld",index);
    [_scrollTableView scrollTableViewListWithSecion:index];
}

- (CGFloat)tableViewCellHeightWithSection:(NSInteger)section AndRow:(NSInteger)row
{
    return 162;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
