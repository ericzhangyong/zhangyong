//
//  UIImage+FFCreate.h
//  Funmily
//
//  Created by zhangyong on 16/8/25.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FFCreate)


#pragma mark - Create image

/**
 *  返回1x1 point size image with the given color.
 */
+ (nullable UIImage *)ff_imageWithColor:(nullable UIColor *)color;

/**
 *  返回特定 size image with the given color.
 */
+ (nullable UIImage *)ff_imageWithColor:(nullable UIColor *)color size:(CGSize)size;

/**
 *  创建新的image
 *
 *  @param size        给定size
 *  @param contentMode contentMode
 *
 *  @return 新image
 */
- (nullable UIImage *)ff_imageByResizeToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;

/**
 *  复制image对应rect的image
 *
 *  @param rect  对应区域
 *
 *  @return 新的image
 */
- (nullable UIImage *)ff_imageByCropToRect:(CGRect)rect;
/**
 *  旋转image
 *
 *  @param radians 旋转方向
 *  @param fitSize 是否适应size
 *
 *  @return 新的image
 */
- (nullable UIImage *)imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;


- (nullable UIImage *)ff_imageByRoundRadius:(CGFloat)radius;

/**
 UIView转成UIImage

 @param view 初始view
 @return 新的image
 */
+ (nullable UIImage *)ff_imageWithView:(nullable UIView *)view;

/**
 图片合并

 @param combineSize 容器大小
 @param image1 图片1
 @param rect1 图片1位置
 @param image2 图片2
 @param rect2 图片2位置
 @return 新的图片
 */
+ (nullable UIImage *)ff_imageCombine:(CGSize)combineSize
                                image:(nullable UIImage *)image1
                                frame:(CGRect)rect1
                            withImage:(nullable UIImage *)image2
                                frame:(CGRect)rect2;

/**
 模糊化 image 适用覆盖于白色背景.
 (类似通知中心)
 */
- (nullable UIImage *)ff_imageByBlurDark;

@end
