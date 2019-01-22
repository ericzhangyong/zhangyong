//
//  YHHomeHeaderView.m
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/1/17.
//  Copyright © 2019年 yh. All rights reserved.
//

#import "YHHomeHeaderView.h"

@implementation YHHomeHeaderView

+(instancetype)createHomeHeaderView{
    YHHomeHeaderView *headerView = [[NSBundle mainBundle]loadNibNamed:@"YHHomeHeaderView" owner:self options:nil].lastObject;
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 480);
    return headerView;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
}



@end
