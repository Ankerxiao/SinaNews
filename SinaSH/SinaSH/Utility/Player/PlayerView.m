//
//  PlayerView.m
//  SinaSH
//
//  Created by keane on 16/7/6.
//  Copyright © 2016年 keane. All rights reserved.
//

#import "PlayerView.h"
#import <AVFoundation/AVFoundation.h>

@interface PlayerView()
@property (nonatomic,strong)AVPlayer *player;
@property (nonatomic,strong)AVPlayerLayer *playerLayer;
@property (nonatomic,assign)BOOL isPlay;
@property (nonatomic,copy)NSString *playID;
@end

@implementation PlayerView

+(instancetype)sharePlayerView
{
    static PlayerView *playerView = nil;
    if(playerView == nil){
        playerView = [[PlayerView alloc] init];
    }
    return playerView;
}

+(void)playInView:(UIView*)view AndFrame:(CGRect)rect AndUrl:(NSString*)url{
    
    NSString *playID = [NSString stringWithFormat:@"%ld%@%@",[view hash],[NSValue valueWithCGRect:rect],url];
    
    
    PlayerView *playerView = [PlayerView sharePlayerView];
    
    if(playerView.isPlay == YES){
        [playerView.player pause];
        playerView.player = nil;
        [playerView.playerLayer removeFromSuperlayer];
        playerView.playerLayer = nil;
        
        if([playID isEqualToString: playerView.playID]){
            
            playerView.isPlay = NO;
            playerView.playID = @"";
            return;
        }
    }
    
    playerView.player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:url]];
    playerView.playerLayer = [AVPlayerLayer playerLayerWithPlayer:playerView.player];
    
    playerView.playerLayer.frame = rect;
    playerView.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [view.layer addSublayer:playerView.playerLayer];
    
    [playerView.player play];
    playerView.playID = playID;
    playerView.isPlay = YES;
}

@end
