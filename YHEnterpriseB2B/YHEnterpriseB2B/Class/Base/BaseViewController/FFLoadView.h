//
//  FFLoadView.h
//  Funmily
//
//  Created by Kuroky on 16/10/26.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FFLoadType) {
    FFLoadShouldHide                        =       0,
    FFLoadNetWorkError                      =       1,
    FFLoadNoData                            =       2,
    FFLoadIsLoaing                          =       3
};

@interface FFLoadView : UIView

@property (nonatomic) FFLoadType loadType;

/**
 距顶部距离,不传或为0时默认居中
 */
@property (nonatomic) CGFloat topLeading;

/**
 提示文字,不传显示默认(按type判断)
 */
@property (nonatomic, copy) NSString *labelText;

/**
 图片名称,不传显示默认(按type判断)
 */
@property (nonatomic, copy) NSString *imageName;

/**
 初始化

 @param type UI类型
 @return FFLoadView
 */
+ (FFLoadView *)ff_loadStatusView:(FFLoadType)type;

/**
 配置UI
 */
- (void)ff_reloadData;

/**
 移除loadView
 */
- (void)ff_removeLoadingView;

@end

@interface FFLoadModel : NSObject

- (instancetype)initWithType:(FFLoadType)type;

/**
 显示类型
 */
@property (nonatomic) FFLoadType loadType;

/**
 显示文字
 */
@property (nonatomic, copy) NSString *loadtext;

/**
 显示图片
 */
@property (nonatomic, copy) NSString *loadImageName;

@end
