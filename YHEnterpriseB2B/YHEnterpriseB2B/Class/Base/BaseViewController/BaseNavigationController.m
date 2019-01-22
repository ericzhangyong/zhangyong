//
//  BaseNavigationController.m
//  aihuuhoo
//
//  Created by kevin on 2018/3/28.
//  Copyright © 2018年 huuhoo. All rights reserved.
//

#import "BaseNavigationController.h"
#import <objc/runtime.h>

@interface BaseNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic , strong) NSMutableArray *showNavBarVcClassArr;
@property (nonatomic , strong) NSMutableArray *hideNavBarVcClassArr;
@property (nonatomic, weak) id<UINavigationControllerDelegate> navDelegate;

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate = self;
    
    UINavigationBar *navigationBar = self.navigationBar;
    UIImage *image = [UIImage imageNamed:@"nav_return"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationBar.backIndicatorImage = image;
    navigationBar.backIndicatorTransitionMaskImage = image;
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];

    //    [navigationBar.backItem.backBarButtonItem setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsDefault];
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if(UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))return  NO;
    
    if (self.viewControllers.count == 1)//关闭主界面的右滑返回
    {
        return NO;
    }
    else
    {
        if (self.topViewController.ff_interactivePopDisabled) {
            return NO;
        }
        return YES;
    }
}

//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.viewControllers.count) {
//        viewController.hidesBottomBarWhenPushed = YES;
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onNavLeftBar:)];
//    }
//    [super pushViewController:viewController animated:YES];
//}
- (void)onNavLeftBar:(id)sender {
    [self popViewControllerAnimated:YES];
}



-(void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    if (delegate != self) {
        self.navDelegate = delegate;
    }
    [super setDelegate:self];
}
-(void)setNavigationBarHidden:(BOOL)navigationBarHidden
{
    
}

-(void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.navDelegate) {
        [self.navDelegate navigationController:navigationController willShowViewController:viewController animated:animated];
    }
    NSString *vcStr = NSStringFromClass([viewController class]);
    if ([self.showNavBarVcClassArr containsObject:vcStr]) {
        if (navigationController.isNavigationBarHidden) {
            [super setNavigationBarHidden:NO animated:animated];
        }
    }else if([self.hideNavBarVcClassArr containsObject:vcStr]){
        if (!navigationController.isNavigationBarHidden) {
            [super setNavigationBarHidden:YES animated:animated];
        }
    }else{
        if (navigationController.isNavigationBarHidden) {
            [super setNavigationBarHidden:NO animated:animated];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)showNavBarVcClassArr
{
    if (!_showNavBarVcClassArr) {
        _showNavBarVcClassArr = [@[] mutableCopy];
    }
    return _showNavBarVcClassArr;
}
-(NSMutableArray *)hideNavBarVcClassArr
{
    if (!_hideNavBarVcClassArr) {
        NSArray *hideHomeArr = @[@"YHHomeViewController",@"CYLTabBarController"];
        NSArray *hideClassifyArr = @[@"YHClassifyViewController"];
        NSArray *hideOffenArr = @[@"YHOffenListViewController"];
        NSArray *hideShopArr = @[@"YHShoppingViewController"];
        NSArray *hideMineArr = @[@"YHMineViewController"];
        _hideNavBarVcClassArr = [hideHomeArr mutableCopy];
        [_hideNavBarVcClassArr addObjectsFromArray:hideClassifyArr];
        [_hideNavBarVcClassArr addObjectsFromArray:hideOffenArr];
        [_hideNavBarVcClassArr addObjectsFromArray:hideShopArr];
        [_hideNavBarVcClassArr addObjectsFromArray:hideMineArr];
    }
    return _hideNavBarVcClassArr;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}


@end


@implementation UIViewController (FFPopGesture)

- (BOOL)ff_interactivePopDisabled
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setFf_interactivePopDisabled:(BOOL)disabled
{
    objc_setAssociatedObject(self, @selector(ff_interactivePopDisabled), @(disabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end



