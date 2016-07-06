//
//  VideoNewsVC.m
//  SinaSH
//
//  Created by keane on 16/7/4.
//  Copyright © 2016年 keane. All rights reserved.
//

#import "VideoNewsVC.h"
#import "BtnListScrollerView.h"
#import "ScrollTableView.h"
#import "NetManager.h"
#import <AVFoundation/AVFoundation.h>
#import "PlayerView.h"

@interface VideoNewsVC ()<BtnListScrollerViewDelegate,ScrollTableViewDelegate>

@property (nonatomic,strong)AVPlayer *player;
@property (nonatomic,strong)AVPlayerLayer *playerLayer;
@property (nonatomic,strong)NSMutableArray *totalNewsArray;
@property (nonatomic,strong)NSArray *oriArray;
@property (nonatomic,strong)BtnListScrollerView *btnScroll;
@property (nonatomic,strong)ScrollTableView *scrollTableView;

@property (nonatomic,assign)NSInteger playSection;
@property (nonatomic,assign)NSInteger playRow;

@end

@implementation VideoNewsVC

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
    _playSection = -1;
    _playRow = -1;
    _oriArray = @[@{@"video_funny":@"搞笑"},
                  @{@"video_funny":@"搞笑"},
                  @{@"video_funny":@"搞笑"},
                  @{@"video_funny":@"搞笑"}
                  ];
    _totalNewsArray = [[NSMutableArray alloc] init];
    
    NSInteger count =  [_oriArray count];
    while (count--) {
        [_totalNewsArray addObject:[[NSMutableArray alloc] init]];
    }
    
}

- (void)initNavView
{
    NSMutableArray *btnTitle = [[NSMutableArray alloc] init];
    for (NSDictionary* dic in _oriArray) {
        
        [btnTitle addObject:[dic valueForKey:[[dic allKeys]firstObject]]];
    }
    
    _btnScroll = [[BtnListScrollerView alloc] initWithBtnTitleArray:btnTitle];
    _btnScroll.delegate = self;
    self.navigationItem.titleView = _btnScroll;
}

- (void)initSubViews
{
    _scrollTableView = [[ScrollTableView alloc] initWithTableViewCount:[_oriArray count] andDelegate:self];
    [self.view addSubview:_scrollTableView];
}



- (void)loadDataWithIndex:(NSInteger)index
{
    NSString *urlStr = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?channel=%@",[[_oriArray[index] allKeys] firstObject]];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)didSelectedBtnWithIndex:(NSInteger)index
{
    
    
}


#pragma mark ScrollTableViewDelegate
- (CGFloat)tableViewCellHeightWithSection:(NSInteger)section AndRow:(NSInteger)row
{
    return 120;
}

- (NSInteger)tableViewNumberOfRowsInSection:(NSInteger)section
{
    return [_totalNewsArray[section] count];
}
- (NewsModel*)newsModelWithTableViewSection:(NSInteger)section andCellRow:(NSInteger)row
{
    return _totalNewsArray[section][row];
}

- (UINib*)getNibWithTableSection:(NSInteger)section
{
    return [UINib nibWithNibName:@"VideoCell" bundle:nil];
}

- (void)loadTableViewDataWithSection:(NSInteger)section
{
}
- (void)currentPageNumberChanged:(NSInteger)currentPage
{
}
- (void)didSelectedTableViewCellWithSection:(NSInteger)section AndRow:(NSInteger)row
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NewsModel *model = _totalNewsArray[section][row];
    
        //播视频
        [self playVideoWithSection:section AndRow:row AndModel:model];

    });
    
}

- (void)playVideoWithSection:(NSInteger)section AndRow:(NSInteger)row AndModel:(NewsModel*)model
{
    UITableView *currentView = [self.scrollTableView.scrollV viewWithTag:100+section];
    CGRect rect = CGRectMake(0,120*row, SCREEN_WIDTH, 100);
    [PlayerView playInView:currentView AndFrame:rect AndUrl:model.videoUrl];
    return;
    
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
