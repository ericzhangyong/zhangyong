//
//  YHMainTabbarImage.m
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/1/17.
//  Copyright © 2019年 yh. All rights reserved.
//

#import "YHMainTabbarImage.h"
#import "FFToolsUtils.h"

@implementation YHMainTabbarImage
+ (instancetype)sharedManage {
    static YHMainTabbarImage *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YHMainTabbarImage alloc] init];
    });
    
    return manager;
}

- (NSString *)getSColor {
    NSString * color = [[NSUserDefaults standardUserDefaults] objectForKey:@"tabbar_sColor"];
    if ([FFToolsUtils isNullOrSpaceString:color]) {
        color = @"#3cb3d5";
    }
    return color;
}

- (NSString *)getuColor {
    NSString * color = [[NSUserDefaults standardUserDefaults] objectForKey:@"tabbar_uColor"];
    if ([FFToolsUtils isNullOrSpaceString:color]) {
        color = @"#565656";
    }
    return color;
}

@end
