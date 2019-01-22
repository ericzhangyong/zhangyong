//
//  YHConst.h
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/1/17.
//  Copyright © 2019年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+FFHEX.h"

NS_ASSUME_NONNULL_BEGIN

#if (defined DEBUG) || (defined SERVERURL)
# define LHLog(fmt, ...) NSLog(@"[函数名:%s]" "[行号:%d] :::" fmt, __FUNCTION__, __LINE__, ##__VA_ARGS__);
# define LHYLKLog(fmt, ...) NSLog(@"kyl_[函数名:%s]" "[行号:%d] :::" fmt, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define LHLog(...);
# define LHYLKLog(...);
#endif

#define weakify( x ) __weak __typeof__(x) weak##x = x;

/**
 *  经测试 无效
 */
#define strongify( x ) __typeof__(x) x = weak##x;
#pragma mark - 判断当前的iPhone设备/系统版本

//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

// 判断是否为 iPhone 5SE
#define isiPhone4s ([[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 480.0f)

// 判断是否为 iPhone 5SE
#define iPhone5SE ([[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f)

// 判断是否为iPhone 6/6s
#define iPhone6_6s ([[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f)

// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus ([[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f)
// iPhone X
#define kDevice_iPhoneX (fabs(MAX([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height) - 812.0) < 0.1)

//获取屏幕 宽度、高度
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define TabBarHeight 49
#define YHMasStatusBarHeight (kDevice_iPhoneX ? 44 : 20)
#define YHMasSafeTopHeight (kDevice_iPhoneX ? 44 : 0)
//导航栏高度
#define YHMasNavHeight (kDevice_iPhoneX ? 88 : 64)
//距离底部的距离（不带tabbar）
#define YHMasBtnBottomConstaint (kDevice_iPhoneX ? 34 : 0)


#define kImageRatio (9.0/16.0)

//0com 1cn
#ifdef SERVERURL
#define kUrl_server SERVERURL
#else
#define kUrl_server 0
#endif




#define  AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define defaultImage [UIImage imageNamed:@"pic_dd2_default"]

@interface YHConst : NSObject

@end

NS_ASSUME_NONNULL_END
