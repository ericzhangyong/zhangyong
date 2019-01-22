//
//  YHMainTabManager.h
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/1/17.
//  Copyright © 2019年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYLTabBarController.h"
#import "YHHomeViewController.h"
#import "YHClassifyViewController.h"
#import "YHOffenListViewController.h"
#import "YHShoppingViewController.h"
#import "YHMineViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHMainTabManager : NSObject

@property (strong, nonatomic, readonly) CYLTabBarController *tabBarController;



+ (instancetype)sharedManager;



@property (nonatomic,strong,readonly) YHHomeViewController *homeVC;
@property (nonatomic,strong,readonly) YHClassifyViewController *classifyVC;
@property (nonatomic,strong,readonly) YHOffenListViewController *offenVC;
@property (nonatomic,strong,readonly) YHShoppingViewController *shoppingVC;
@property (nonatomic,strong,readonly) YHMineViewController *mineVC;


@end

NS_ASSUME_NONNULL_END
