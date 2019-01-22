//
//  YHMainTabManager.m
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/1/17.
//  Copyright © 2019年 yh. All rights reserved.
//

#import "YHMainTabManager.h"
#import "YHMainTabbarImage.h"
#import "UIColor+FFHEX.h"



@interface YHMainTabManager ()<UITabBarControllerDelegate>

@property (strong, nonatomic, readwrite) CYLTabBarController *tabBarController;
@property (nonatomic,strong,readwrite) YHHomeViewController *homeVC;
@property (nonatomic,strong,readwrite) YHClassifyViewController *classifyVC;
@property (nonatomic,strong,readwrite) YHOffenListViewController *offenVC;
@property (nonatomic,strong,readwrite) YHShoppingViewController *shoppingVC;
@property (nonatomic,strong,readwrite) YHMineViewController *mineVC;

@property (nonatomic, copy) void (^ TabBarSelectIndexHandler)(NSInteger index);

@end

@implementation YHMainTabManager


+ (instancetype)sharedManager{
    static YHMainTabManager *tabManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabManager = [[YHMainTabManager alloc] init];
    });
    return tabManager;
}


-(instancetype)init {
    if (self = [super init]) {
        [self setUpAppearence];
    }
    return self;
}

- (void)setUpAppearence {
    //tabbarp设置
    
    UIColor *nColor = [UIColor ff_colorWithHexString:[[YHMainTabbarImage sharedManage] getuColor]]; //  3cb3d5
    UIColor *sColor = [UIColor ff_colorWithHexString:[[YHMainTabbarImage sharedManage] getSColor]]; // 0e7a96
    NSDictionary *att  = [NSDictionary dictionaryWithObjectsAndKeys:nColor,NSForegroundColorAttributeName, nil];
    NSDictionary *att1 = [NSDictionary dictionaryWithObjectsAndKeys:sColor,NSForegroundColorAttributeName, nil];
    [[UITabBarItem appearance] setTitleTextAttributes:att forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:att1 forState:UIControlStateSelected];

    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
}

- (CYLTabBarController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [self addKidsViewControllers];
    }
    return _tabBarController;
}

- (CYLTabBarController *)addKidsViewControllers {
    
//    self.tabBarImages = [[FFMainTabImageManage sharedManage] fetchKidsLocalTabbarImages:4];
    YHMainTabbarImage *homeTabbarImage;
    YHMainTabbarImage *classfyTabbarImage;
    YHMainTabbarImage *offenTabbarImage;
    YHMainTabbarImage *shoppingTabbarImage;
    YHMainTabbarImage *mineTabbarImage;
    
    homeTabbarImage = [YHMainTabbarImage new];
    homeTabbarImage.uImage = [UIImage imageNamed:@"tabbar_home_unselected"];
    homeTabbarImage.sImage = [UIImage imageNamed:@"tabbar_home_selected"];
    
    classfyTabbarImage = [YHMainTabbarImage new];
    classfyTabbarImage.uImage = [UIImage imageNamed:@"tabbar_classify_unselected"];
    classfyTabbarImage.sImage = [UIImage imageNamed:@"tabbar_classify_selected"];
    
    offenTabbarImage = [YHMainTabbarImage new];
    offenTabbarImage.uImage = [UIImage imageNamed:@"tabbar_often_unselected"];
    offenTabbarImage.sImage = [UIImage imageNamed:@"tabbar_often_selected"];
    
    shoppingTabbarImage = [YHMainTabbarImage new];
    shoppingTabbarImage.uImage = [UIImage imageNamed:@"shop_bar_unselected"];
    shoppingTabbarImage.sImage = [UIImage imageNamed:@"shop_bar_selected"];
    
    mineTabbarImage = [YHMainTabbarImage new];
    mineTabbarImage.uImage = [UIImage imageNamed:@"tabbar_mine_unselected"];
    mineTabbarImage.sImage = [UIImage imageNamed:@"tabbar_mine_selected"];
    
    UIViewController *nav1 = self.homeVC;
    UIViewController *nav2 = self.classifyVC;
    UIViewController *nav3 = self.offenVC;
    UIViewController *nav4 = self.shoppingVC;
    UIViewController *nav5 = self.mineVC;
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    NSDictionary *dict1 = @{CYLTabBarItemTitle:@"首页",
                            CYLTabBarItemImage:homeTabbarImage.uImage,
                            CYLTabBarItemSelectedImage:homeTabbarImage.sImage};
    NSDictionary *dict2 = @{CYLTabBarItemTitle:@"分类",
                            CYLTabBarItemImage:classfyTabbarImage.uImage,
                            CYLTabBarItemSelectedImage:classfyTabbarImage.sImage};
    
    NSDictionary *dict3 = @{CYLTabBarItemTitle:@"常购清单",
                            CYLTabBarItemImage:offenTabbarImage.uImage,
                            CYLTabBarItemSelectedImage:offenTabbarImage.sImage};
    NSDictionary *dict4 = @{CYLTabBarItemTitle:@"购物车",
                            CYLTabBarItemImage:shoppingTabbarImage.uImage,
                            CYLTabBarItemSelectedImage:shoppingTabbarImage.sImage};
    NSDictionary *dict5 = @{CYLTabBarItemTitle:@"我的",
                            CYLTabBarItemImage:shoppingTabbarImage.uImage,
                            CYLTabBarItemSelectedImage:shoppingTabbarImage.sImage};
    NSArray *tabBarItemsAttributes = @[dict1, dict2, dict3, dict4,dict5];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
//    [tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabBar_bg"]];
    NSArray *vcArray =@[nav1, nav2, nav3, nav4,nav5];
    [tabBarController setViewControllers:vcArray];
    tabBarController.delegate = self;
    return tabBarController;
}


#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    [_tabBarController updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (self.TabBarSelectIndexHandler) {
        self.TabBarSelectIndexHandler([self.tabBarController.viewControllers indexOfObject:viewController]);
    }
}

#pragma mark - kids

-(YHHomeViewController *)homeVC{
    if (!_homeVC) {
        _homeVC = [YHHomeViewController new];
    }
    return _homeVC;
}
-(YHClassifyViewController *)classifyVC{
    if (!_classifyVC
        ) {
        _classifyVC = [YHClassifyViewController new];
    }
    return _classifyVC;
}
-(YHOffenListViewController *)offenVC{
    if (!_offenVC) {
        _offenVC = [YHOffenListViewController new];
    }
    return _offenVC;
}
-(YHShoppingViewController *)shoppingVC{
    if (!_shoppingVC) {
        _shoppingVC = [YHOffenListViewController new];
    }
    return _shoppingVC;
}
-(YHMineViewController *)mineVC{
    if (!_mineVC) {
        _mineVC = [YHMineViewController new];
    }
    return _mineVC;
}

@end
