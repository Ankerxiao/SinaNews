//
//  RootTabBarTableViewController.m
//  SinaSH
//
//  Created by keane on 16/7/4.
//  Copyright © 2016年 keane. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "HomeNewsVC.h"
#import "PicNewsVC.h"
#import "VideoNewsVC.h"
#import "MyCenterVC.h"

@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(instancetype)init
{
    self = [super init];
    if(self != nil){
        [self initTabBar];
    }
    return self;
}


- (void)initTabBar
{
    [self initTabBarVCs];
    [self initTabBarItems];
}


- (void)initTabBarVCs
{
    HomeNewsVC *homeVC = [[HomeNewsVC alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    PicNewsVC *picVC = [[PicNewsVC alloc] init];
    UINavigationController *picNav = [[UINavigationController alloc] initWithRootViewController:picVC];
    
    VideoNewsVC *videoVC = [[VideoNewsVC alloc] init];
    UINavigationController *videoNav = [[UINavigationController alloc] initWithRootViewController:videoVC];
    
    MyCenterVC *myCenter = [[MyCenterVC alloc] init];
    UINavigationController *myNav = [[UINavigationController alloc] initWithRootViewController:myCenter];
    
    self.viewControllers = @[homeNav,picNav,videoNav,myNav];
    self.tabBar.tintColor = [UIColor redColor];
    
}


- (void)initTabBarItems
{
    NSArray  * titleArray = @[@"新闻",@"图片",@"视频",@"我的"];
    NSArray *imageArray = @[@"tabbar_news",@"tabbar_picture",@"tabbar_video",@"tabbar_setting"];
    
    for (int index = 0; index < [self.viewControllers count]; index++) {
        UINavigationController *navTemp = self.viewControllers[index];
        UIViewController *vcTemp = [navTemp.viewControllers firstObject];
        
        //vcTemp.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemRecents+index tag:index];
        
        NSString *str = [NSString stringWithFormat:@"%@",imageArray[index]];
        
        NSString *hlStr = [NSString stringWithFormat:@"%@_hl",str];
    
        
        vcTemp.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleArray[index] image:[[UIImage imageNamed:str]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:hlStr]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
