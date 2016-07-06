//
//  BtnListScrollerView.m
//  SinaSH
//
//  Created by keane on 16/7/4.
//  Copyright © 2016年 keane. All rights reserved.
//

#import "BtnListScrollerView.h"

#define  BTN_WIDTH 40
#define  BTN_DISTANCE 5
#define  BTN_HEIGHT 30
#define  BTN_TAG_BEGIN 100

@interface BtnListScrollerView()
@property (nonatomic,strong)UIScrollView *scrollV;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)UIView *btnBgView;
@end

@implementation BtnListScrollerView

-(instancetype)initWithBtnTitleArray:(NSArray*)btnTitleArray
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAV_HEIGHT)];
    if(self != nil){
        self.titleArray = btnTitleArray;
        [self initSubViews];
    }
    return self;
}


- (void)initSubViews
{
    _scrollV = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollV.showsHorizontalScrollIndicator = NO;
    for (int index = 0; index < [_titleArray count]; index++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(index*(BTN_WIDTH+BTN_DISTANCE), (NAV_HEIGHT-BTN_HEIGHT)/2, BTN_WIDTH, BTN_HEIGHT)];
        [btn setTitle:_titleArray[index] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.tag = BTN_TAG_BEGIN + index;
        [btn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        
        if(index == 0)
        {
            btn.selected = YES;
            _btnBgView = [[UIView alloc] initWithFrame:btn.frame];
            [_btnBgView setBackgroundColor:[UIColor lightGrayColor]];
            [_btnBgView setAlpha:0.5];
            _btnBgView.layer.cornerRadius = 5;
            [_scrollV addSubview:_btnBgView];
        }
        
        [_scrollV addSubview:btn];
    }
    [_scrollV setContentSize:CGSizeMake(([_titleArray count])*(BTN_WIDTH+BTN_DISTANCE), NAV_HEIGHT)];
    
    [self addSubview:_scrollV];
}


- (void)btnPress:(UIButton*)btn
{
    NSInteger index = 0;
    for (UIView* view in [_scrollV subviews]) {
        if([view isKindOfClass:[UIButton class]]){
            UIButton *btnTemp = (UIButton*)view;
            btnTemp.selected = NO;
            
            
            if([btnTemp isEqual:btn]){
                btnTemp.selected = YES;
                
                if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didSelectedBtnWithIndex:)]) {
                    [self.delegate didSelectedBtnWithIndex:index];
                }
            
                [UIView animateWithDuration:0.5 animations:^{
                    _btnBgView.frame = btnTemp.frame;
                }];
            }
            index++;
        }
    }
}

- (void)scrollBtnListWithIndex:(NSInteger)btnIndex
{
    UIButton *btn = [_scrollV viewWithTag:btnIndex+BTN_TAG_BEGIN];
    
    NSInteger index = 0;
    for (UIView* view in [_scrollV subviews]) {
        if([view isKindOfClass:[UIButton class]]){
            UIButton *btnTemp = (UIButton*)view;
            btnTemp.selected = NO;
            
            
            if([btnTemp isEqual:btn]){
                btnTemp.selected = YES;
                
                [UIView animateWithDuration:0.5 animations:^{
                    _btnBgView.frame = btnTemp.frame;
                }];
            }
            index++;
        }
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
