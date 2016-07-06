//
//  NewsModel.m
//  SinaSH
//
//  Created by keane on 16/7/4.
//  Copyright © 2016年 keane. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+(JSONKeyMapper *)keyMapper
{
    JSONKeyMapper *mapper = [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"newsId",@"video_info.url":@"videoUrl"}];
    return mapper;
}

@end
