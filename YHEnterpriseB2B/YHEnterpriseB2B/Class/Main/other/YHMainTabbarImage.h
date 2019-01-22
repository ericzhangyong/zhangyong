//
//  YHMainTabbarImage.h
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/1/17.
//  Copyright © 2019年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface YHMainTabbarImage : NSObject

+(instancetype)sharedManage;

/**
 *  未选中状态
 */
@property (nonatomic, strong) UIImage *uImage;

/**
 *  选中状态
 */
@property (nonatomic, strong) UIImage *sImage;


- (NSString *)getSColor;
- (NSString *)getuColor;
@end

