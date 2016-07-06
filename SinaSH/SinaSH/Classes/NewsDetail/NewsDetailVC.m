//
//  NewsDetailVC.m
//  SinaSH
//
//  Created by keane on 16/7/5.
//  Copyright © 2016年 keane. All rights reserved.
//

#import "NewsDetailVC.h"

@interface NewsDetailVC ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,copy)NSString* urlStr;
@end

@implementation NewsDetailVC

-(instancetype)initWithUrl:(NSString*)url
{
    self = [super init];
    if(self != nil){
        self.urlStr = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlStr]];
    [_webView loadRequest:req];
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
