//
//  YHRootNavViewController.m
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/1/17.
//  Copyright © 2019年 yh. All rights reserved.
//

#import "YHRootNavViewController.h"

@interface YHRootNavViewController ()

@end

@implementation YHRootNavViewController
+(instancetype)rootNavigationController
{
    static YHRootNavViewController *nav;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nav = [[YHRootNavViewController alloc] init];
    });
    return nav;
}

-(void)ff_setRootViewController:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UITabBarController class]]) {
        [self ff_resetNavBar];
    }
    [self setViewControllers:@[vc]];
}

-(void)ff_setRootViewControllers:(NSArray<UIViewController *> *)vcArr
{
    [vcArr enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITabBarController class]]) {
            [self ff_resetNavBar];
            *stop = YES;
        }
    }];
    
    [self setViewControllers:vcArr];
}
-(void)ff_resetNavBar
{
    UIFont *font = [UIFont systemFontOfSize:17.0];
    UIColor *color = [UIColor blackColor];
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:color, NSForegroundColorAttributeName, font, NSFontAttributeName, nil];
    [self.navigationBar setTitleTextAttributes:attribute];
    [self.navigationBar setBackgroundImage:nil forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = nil;
}

-(void)ff_replaceLastViewController:(UIViewController *)vc
{
    NSArray *curVcArr = self.viewControllers;
    NSArray *oldVcarr = [curVcArr subarrayWithRange:NSMakeRange(0, curVcArr.count - 1)];
    NSArray *newVcArr = [oldVcarr arrayByAddingObject:vc];
    [self setViewControllers:newVcArr animated:YES];
}

-(NSInteger)ff_hasVcClass:(Class)vcClass
{
    NSArray *curVcArr = self.viewControllers;
    __block NSInteger hasVc = -1;
    [curVcArr enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:vcClass]) {
            hasVc = idx;
            *stop = YES;
        }
    }];
    return hasVc;
}
-(BOOL)ff_popToVcClass:(Class)vcClass
{
    NSArray *curVcArr = self.viewControllers;
    __block UIViewController *popVc;
    [curVcArr enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:vcClass]) {
            popVc = obj;
            *stop = YES;
        }
    }];
    if (popVc) {
        [self popToViewController:popVc animated:YES];
        return YES;
    }
    return NO;
}
-(void)ff_pushNewViewController:(UIViewController *)vc
{
    [self pushViewController:vc animated:YES];
}
-(void)ff_pushNoAnimatViewController:(UIViewController *)vc
{
    [self pushViewController:vc animated:NO];
}
-(void)ff_pushNewSingleViewController:(UIViewController *)vc
{
    NSInteger vcIndex = [self ff_hasVcClass:[vc class]];
    if (vcIndex == -1) {
        [self ff_pushNewViewController:vc];
        return;
    }
    NSArray *curVcArr = self.viewControllers;
    NSArray *oldVcarr = [curVcArr subarrayWithRange:NSMakeRange(0, vcIndex)];
    NSArray *newVcArr = [oldVcarr arrayByAddingObject:vc];
    [self setViewControllers:newVcArr animated:YES];
}

@end
