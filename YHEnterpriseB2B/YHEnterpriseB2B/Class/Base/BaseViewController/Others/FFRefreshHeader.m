//
//  FFRefreshHeader.m
//  Funmily
//
//  Created by kevin on 16/8/25.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import "FFRefreshHeader.h"

@implementation FFRefreshHeader

- (void)prepare
{
    [super prepare];
//    self.mj_h = 32;
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    [self setImages:@[[UIImage imageNamed:@"top_icon_pullToRefresh"]] forState:MJRefreshStateIdle];
    [self setImages:@[[UIImage imageNamed:@"top_icon_pullToRefresh"],[UIImage imageNamed:@"top_icon_pullToRefresh_1"],[UIImage imageNamed:@"top_icon_pullToRefresh_2"],[UIImage imageNamed:@"top_icon_pullToRefresh_3"]] forState:MJRefreshStateRefreshing];
    [self setImages:@[[UIImage imageNamed:@"top_icon_pullToRefresh_2"]] forState:MJRefreshStatePulling];
    [self setImages:@[[UIImage imageNamed:@"top_icon_pullToRefresh"]] forState:MJRefreshStateWillRefresh];
}

- (void)placeSubviews
{
    [super placeSubviews];
}

@end
