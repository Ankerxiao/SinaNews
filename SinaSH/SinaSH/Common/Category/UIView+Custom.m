//
//  UIView+Custom.m
//  SinaSH
//
//  Created by keane on 16/7/4.
//  Copyright © 2016年 keane. All rights reserved.
//

#import "UIView+Custom.h"

@implementation UIView (Custom)

-(CGFloat)height
{
    return self.frame.size.height;
}

-(CGFloat)width
{
    return self.frame.size.width;
}

-(CGFloat)x
{
    return self.frame.origin.x;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}
@end
