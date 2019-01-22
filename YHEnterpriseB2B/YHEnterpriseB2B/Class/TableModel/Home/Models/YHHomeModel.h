//
//  YHHomeModel.h
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/1/17.
//  Copyright © 2019年 yh. All rights reserved.
//

#import "YHBaseModel.h"
@class YHHomeCellModel;


@interface YHHomeModel : YHBaseModel

@property (nonatomic,copy) NSString *sectionTitle;
@property (nonatomic,retain) NSArray<YHHomeCellModel *> *data;

@end



@interface YHHomeCellModel : YHBaseModel

@property (nonatomic,copy) NSString *frontCover;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *oldPrice;



@end

