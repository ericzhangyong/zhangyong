//
//  YHHomeFooterView.m
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/1/17.
//  Copyright © 2019年 yh. All rights reserved.
//

#import "YHHomeFooterView.h"

@implementation YHHomeFooterView

+(instancetype)createHomeFooterView{
    
    YHHomeFooterView *footerView = [[NSBundle mainBundle] loadNibNamed:@"YHHomeFooterView" owner:self options:nil].lastObject;
    return footerView;
}


@end
