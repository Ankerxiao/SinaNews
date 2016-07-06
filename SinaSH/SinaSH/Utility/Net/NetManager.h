//
//  NetManager.h
//  SinaSH
//
//  Created by keane on 16/7/4.
//  Copyright © 2016年 keane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^SuccessBlock) (id data);
typedef void (^FailedBlock) (NSError *error);

@interface NetManager : NSObject

+(instancetype)shareManager;

- (void)requestUrl:(NSString*)url WithSuccessBlock:(SuccessBlock)successB andFailedBlock:(FailedBlock)failB;

//- (void)requestUrl:(NSString*)url WithSuccessBlock:(SuccessBlock)successB andFailedBlock:(FailedBlock)failB andShowLoding:(BOOL)loading;

@end
