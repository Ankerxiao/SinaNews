//
//  MyCenterVC.m
//  SinaSH
//
//  Created by keane on 16/7/4.
//  Copyright © 2016年 keane. All rights reserved.
//

#import "MyCenterVC.h"

#define SCREENW [UIScreen mainScreen].bounds.size.width

@interface MyCenterVC ()<UITableViewDataSource,UITableViewDelegate>

{
    
    BOOL st ;
    
    NSArray * dataArray;
    UIView *view;
}


@property(nonatomic,strong)UITableView *table;

@end

@implementation MyCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = YES;
    
    dataArray = @[@[@"离线下载",@"夜间模式",@"头条推送",@"仅WIFI下载图片",@"离线设置",@"正文字号",@"清除缓存"],@[@"反馈",@"检查更新",@"关于"],@[@"应用中心"]];
    
    [self.view addSubview:self.table];
}

- (UITableView *)table
{
    if (!_table)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49) style:UITableViewStyleGrouped] ;
        _table.delegate = self ;
        _table.dataSource = self ;
        
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 320)];
        
        view.backgroundColor = [UIColor orangeColor];
        
        UIImageView *backV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230)];
        
        backV.image =[UIImage imageNamed:@"UseCenterWeatherBGSunny"] ;
        
        _table.tableHeaderView = view;
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(140, 80, 100, 100)];
        
        imageV.layer.cornerRadius = 50;
        imageV.layer.borderWidth = 1;
        imageV.clipsToBounds = YES;
        imageV.layer.borderColor = [UIColor whiteColor].CGColor;
        
        imageV.image = [UIImage imageNamed:@"tabbar_setting"];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(150, CGRectGetMaxY(imageV.frame)+10, 150, 30)];
        
        label.text = @"登录账号";
        label.textColor = [UIColor whiteColor];
        
        [backV addSubview:label];
       
        [view addSubview:backV];
        [backV addSubview:imageV];
        
        CGFloat btnW = SCREEN_WIDTH/3;
        for (int i = 0; i<3; i++) {
            
            NSArray *picArray = @[@"usercenter_favorite_icon",@"usercenter_comment",@"weather_default"];
            NSArray *btnArray = @[@"收藏",@"评论",@"天气"];
          
            
            UIView *buttonV = [[UIView alloc]initWithFrame:CGRectMake(i*btnW, CGRectGetMaxY(backV.frame), btnW, 90)];
            
            buttonV.backgroundColor = [UIColor whiteColor];
            
            
            UIImageView *picV = [[UIImageView alloc]initWithFrame:CGRectMake(50, 15, 35, 35)];
            
            picV.image = [UIImage imageNamed:picArray[i]];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 35, 35)];
            
            label.text = btnArray[i];
            label.textColor = [UIColor darkGrayColor];
            
            [buttonV addSubview:label];
            [buttonV addSubview:picV];
            
            [view addSubview:buttonV];
            
            
            
            
            
        }
        
        _table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero] ;
        
        //_table.separatorStyle = UITableViewCellSeparatorStyleNone ;
    }
    return _table ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 15;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return dataArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray[section] count];
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.accessoryView = nil;
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    
    cell.textLabel.text = dataArray[indexPath.section][indexPath.row];
    if (indexPath.section==0 && (indexPath.row == 1 || indexPath.row == 2 ||indexPath.row == 3)) {
        
        UISwitch *switchView = [[UISwitch alloc] init];
        
        [switchView addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
        
        
        cell.accessoryView = switchView;
    }
    
    else
    {
        
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

-(void)change:(UISwitch *)s
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
