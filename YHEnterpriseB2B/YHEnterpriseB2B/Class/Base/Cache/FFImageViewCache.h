//
//  FFImageViewCache.h
//  Funmily
//
//  Created by kevin on 16/8/17.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//圆角设为最大 ，则是全圆角
#define kImageCornerRadiusMax 1000.0

@interface FFImageViewCache : NSObject

+ (instancetype)shareImageCache;

/**
 清理 SDWebImageManager的缓存
 */
- (void)ff_clearCache;

/**
 获取SDWebImageManager缓存大小

 @return 单位:字节
 */
- (NSUInteger)ff_getCacheSize;

/**
 上传照片 保存到本地(防止上传后 又要下载。 上传640 保存 640  320 160 也有可能)

 @param image 上传的原图
 @param urlStr 图片路径
 @param memory 是否保存到内存
 */
- (void)ff_saveImage:(UIImage *)image
             withKey:(NSString *)urlStr
           forMemory:(BOOL)memory;

/**
 获取本地缓存的图片
 
 @param imageUrl 图片地址
 @return UIImage
 */
- (UIImage *)ff_getCacheImage:(NSString *)imageUrl;

@end

@interface UIImageView(FFWebCache)

/**
 UIImageView 直接加载url图片

 @param urlStr 图片地址(NSString/NSURL)
 @param placeholder 默认占位图
 */
- (void)ff_setImageAtPath:(id)urlStr
              placeholder:(UIImage *)placeholder;

/**
 UIImageView 直接加载url图片(带block)
 
 @param urlStr 图片地址(NSString/NSURL)
 @param placeholder 默认占位图
 @param comBlock 图片下载完成回调
 */
- (void)ff_setImageOriginalStr:(NSString *)urlStr
           placeholder:(UIImage *)placeholder
             completed:(void (^)(UIImage *image, BOOL finish))comBlock;

/**
 *  下载完成后，缓存 和 显示 fitSize 的image。 默认使用网宿裁剪，除非需要放大的 会使用原图
    A.网宿来源由网宿裁剪
    B.本地裁剪实现 1、缓存原始图 2、缓存fitSize图 3、获取缓存图 根据 size 取
 *  @param urlStr 图片地址
 *  @param size 显示尺寸
 *  @param placeholder 占位图
 */
- (void)ff_setImageStr:(NSString *)urlStr
               fitSize:(CGSize)size
           placeholder:(UIImage *)placeholder;
- (void)ff_setImageStr:(NSString *)urlStr
               fitSize:(CGSize)size
          cornerRadius:(CGFloat)cornerRadius
           placeholder:(UIImage *)placeholder
                useWCS:(BOOL)isUse;
//增加圆角图片支持
- (void)ff_setImageStr:(NSString *)urlStr
               fitSize:(CGSize)size
            cornerRadius:(CGFloat)cornerRadius
           placeholder:(UIImage *)placeholder;

@end
