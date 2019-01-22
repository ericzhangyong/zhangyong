//
//  YHConfigUrl.m
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/1/17.
//  Copyright © 2019年 yh. All rights reserved.
//

#import "YHConfigUrl.h"

@implementation YHConfigUrl


+(instancetype)shareYHConfigUrl{
    static YHConfigUrl *configUrl = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configUrl = [YHConfigUrl new];
    });
    return configUrl;
}


-(instancetype)init{
    if (self = [super init]) {
        _webInstance= @"http://192.168.1.23:3000/";
        
        
        //0 com 1 cn
#if kUrl_server==0
#define kUrl_getServerUrl @"http://10.0.0.111:40080/common/serverurl/get"
#elif kUrl_server==1
#define kUrl_getServerUrl @"http://aismallapp.yanchang8.cn/common/serverurl/get"
#else
#define kUrl_getServerUrl @"http://xq.familyktv.com/common/serverurl/get"
#endif
        
        
    }
    return self;
}


@end
