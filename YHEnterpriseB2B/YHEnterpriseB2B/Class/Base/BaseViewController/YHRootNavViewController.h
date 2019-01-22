//
//  YHRootNavViewController.h
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/1/17.
//  Copyright © 2019年 yh. All rights reserved.
//

#import "BaseNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHRootNavViewController : BaseNavigationController
+(instancetype)rootNavigationController;

-(void)ff_setRootViewController:(UIViewController *)vc;

-(void)ff_setRootViewControllers:(NSArray<UIViewController *> *)vcArr;

-(void)ff_replaceLastViewController:(UIViewController *)vc;

-(NSInteger)ff_hasVcClass:(Class)vcClass;
-(BOOL)ff_popToVcClass:(Class)vcClass;

-(void)ff_pushNewViewController:(UIViewController *)vc;

-(void)ff_pushNoAnimatViewController:(UIViewController *)vc;


-(void)ff_pushNewSingleViewController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
