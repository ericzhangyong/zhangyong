//
//  YHRequestHeaderConfig.m
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/1/16.
//  Copyright © 2019年 yh. All rights reserved.
//

#import "YHRequestHeaderConfig.h"

@implementation YHRequestHeaderConfig


+ (instancetype)shareConfig {
    
    static YHRequestHeaderConfig *ins = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[YHRequestHeaderConfig alloc] init];
    });
    return ins;
}
- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    
}
@end
