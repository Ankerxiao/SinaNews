//
//  NewsModel.h
//  SinaSH
//
//  Created by keane on 16/7/4.
//  Copyright © 2016年 keane. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface NewsModel : JSONModel
@property (nonatomic,copy)NSString *newsId;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *intro;
@property (nonatomic,copy)NSString *kpic;
@property (nonatomic,copy)NSString *link;
@property (nonatomic,copy)NSString<Optional> *comment;
@property (nonatomic,copy)NSString<Optional> *videoUrl;
@property (nonatomic,copy)NSString<Optional> *pictotal;
@end
