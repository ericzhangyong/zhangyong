//
//  YHConfigUrl.h
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/1/17.
//  Copyright © 2019年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHConfigUrl : NSObject


@property (nonatomic,copy) NSString *webInstance;

+(instancetype)shareYHConfigUrl;

@end

NS_ASSUME_NONNULL_END
