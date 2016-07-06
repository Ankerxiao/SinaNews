//
//  NetManager.m
//  SinaSH
//
//  Created by keane on 16/7/4.
//  Copyright © 2016年 keane. All rights reserved.
//

#import "NetManager.h"
@interface NetManager()
@property (nonatomic,strong)AFHTTPSessionManager *sessionManager;
@end

@implementation NetManager

+(instancetype)shareManager
{
    static NetManager* netManager = nil;
    if(netManager == nil){
        netManager = [[NetManager alloc] init];
        netManager.sessionManager = [AFHTTPSessionManager manager];
        netManager.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        netManager.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return netManager;
}

- (void)requestUrl:(NSString*)url WithSuccessBlock:(SuccessBlock)successB andFailedBlock:(FailedBlock)failB
{
    
    [self.sessionManager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successB([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failB(error);
    }];
}
@end
