//
//  FFImageViewCache.m
//  Funmily
//
//  Created by kevin on 16/8/17.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import "FFImageViewCache.h"
#import "UIImageView+WebCache.h"
#import "UIImage+FFCreate.h"
#import <CoreGraphics/CoreGraphics.h>

@interface FFImageViewCache() <SDWebImageManagerDelegate>

@property (strong, nonatomic) dispatch_queue_t cacheQueue;

@end

@implementation FFImageViewCache

+ (instancetype)shareImageCache {
    static id cache;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        cache = [[self alloc] init];
    });
    
    return cache;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _cacheQueue = dispatch_queue_create("com.funmily.FFImageCache", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

#pragma mark - 清理 SDWebImageManager的缓存
- (void)ff_clearCache {
    [[SDWebImageManager sharedManager].imageCache clearDiskOnCompletion:nil];
}

#pragma mark - SDWebImageManager缓存大小
- (NSUInteger)ff_getCacheSize {
    return  [SDWebImageManager sharedManager].imageCache.getSize;
}

#pragma mark - 图片保存到本地
- (void)ff_saveImage:(UIImage *)image
             withKey:(NSString *)urlStr
           forMemory:(BOOL)memory {
    if (!urlStr || !image) {
        return;
    }
//    dispatch_async(self.cacheQueue, ^{
//        NSData *data;
            // PNG imageData file always contain the following (decimal) values:
            // 137 80 78 71 13 10 26 10
            // and the image has an alpha channel, we will consider it PNG to avoid losing the transparency
//            NSInteger alphaInfo = CGImageGetAlphaInfo(image.CGImage);
//            BOOL hasAlpha = !(alphaInfo == kCGImageAlphaNone ||
//                              alphaInfo == kCGImageAlphaNoneSkipFirst ||
//                              alphaInfo == kCGImageAlphaNoneSkipLast);
//            BOOL imageIsPng = hasAlpha;
//            
//            if (imageIsPng) {
//                data = UIImagePNGRepresentation(image);
//            }
//            else {
//                data = UIImageJPEGRepresentation(image, (CGFloat)1.0);
//            }
            [[SDImageCache sharedImageCache] storeImage:image forKey:urlStr completion:nil];
//    });
}

#pragma mark - 获取本地缓存的图片
- (UIImage *)ff_getCacheImage:(NSString *)imageUrl {
    if (!imageUrl) {
        return nil;
    }
    
    UIImage *cacheImage = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:imageUrl];
    return cacheImage;
}

@end

@implementation UIImageView(FFWebCache)

#pragma mark - 直接加载url图片
- (void)ff_setImageAtPath:(id)urlStr
              placeholder:(UIImage *)placeholder {
    if ([urlStr isKindOfClass:[NSURL class]]) {
        [self setImageURL:(NSURL*)urlStr placeholder:placeholder];
        return;
    }
    if (![urlStr isKindOfClass:[NSString class]]) {
        self.image = placeholder;
        return;
    }
    NSString *str = [self urlEncode:urlStr];
    [self setImageURL:[NSURL URLWithString:str] placeholder:placeholder];
}

- (void)setImageURL:(NSURL *)url
        placeholder:(UIImage *)placeholder {
//    [self setShowActivityIndicatorView:YES];
    [self sd_setImageWithURL:url
            placeholderImage:placeholder
                     options:SDWebImageRetryFailed | SDWebImageLowPriority];
}

#pragma mark - 直接加载url图片(带block)
- (void)ff_setImageOriginalStr:(NSString *)urlStr
           placeholder:(UIImage *)placeholder
             completed:(void (^)(UIImage *image, BOOL finish))comBlock {
    if (!urlStr) {
        if(comBlock) {
            comBlock(nil, YES);
        }
        return;
    }
    
    NSURL *url = [NSURL URLWithString:[self urlEncode:urlStr]];
//    [self setShowActivityIndicatorView:YES];
    [self sd_setImageWithURL:url
            placeholderImage:placeholder
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       if(comBlock) {
                           comBlock(image, YES);
                       }
                   }];
}

#pragma mark - 加载指定size图片 默认使用网宿裁剪，除非需要放大的 会使用原图
- (void)ff_setImageStr:(NSString *)urlStr
               fitSize:(CGSize)size
           placeholder:(UIImage *)placeholder {
    [self ff_setImageStr:urlStr fitSize:size cornerRadius:0 placeholder:placeholder useWCS:YES];
}

- (void)ff_setImageStr:(NSString *)urlStr
               fitSize:(CGSize)size
            cornerRadius:(CGFloat)cornerRadius
           placeholder:(UIImage *)placeholder
                useWCS:(BOOL)isUse
{
    [self sd_cancelCurrentAnimationImagesLoad];
//    [self sd_cancelCurrentImageLoad];
    if (!urlStr) {
        self.image = placeholder;
        return;
    }
    urlStr = [self urlEncode:urlStr];
    if (![NSURL URLWithString:urlStr]) {
        self.image = placeholder;
        return;
    }
    NSString *sizeImagekey = @"";
    BOOL isInWCS = isUse && [urlStr containsString:@"wcsapi.biz.matocloud"];
    if (isInWCS) {
        sizeImagekey = [self appendWCSPath:urlStr cropSize:size];
    }else{
        sizeImagekey = [self cropFromPath:urlStr cropSize:size];
    }
    
    //TODO:相同图片，不通尺寸 公用问题
    
    UIImage *cacheImage = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:sizeImagekey];
    if (cacheImage) {
        if (cornerRadius > 1.0) {
            self.image = [self ff_image:cacheImage cornerRadius:cornerRadius];
        }else{
            self.image = cacheImage;
        }
        [self setNeedsLayout];
        return;
    }
    cacheImage = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:urlStr];
    if (cacheImage) {
        [self cropDownloadImage:cacheImage
                     cornerRadius:cornerRadius
                      expectSize:size
                         saveKey:sizeImagekey];
        return;
    }
    NSURL *url;
    if (isInWCS) {
        url = [NSURL URLWithString:sizeImagekey];
    }else{
        url = [NSURL URLWithString:urlStr];
    }
    
    [self ff_loadURL:url placeholderImage:placeholder isInWCS:isInWCS cornerRadius:cornerRadius expectSize:size saveKey:sizeImagekey retryCount:0];
    
}

-(void)ff_loadURL:(NSURL *)url placeholderImage:(UIImage *)placeholder isInWCS:(BOOL)isInWCS cornerRadius:(CGFloat)cornerRadius expectSize:(CGSize)size saveKey:(NSString *)sizeImagekey retryCount:(NSInteger)retryCount{
    retryCount++;
    __weak __typeof(self)wself = self;
    [self sd_setImageWithURL:url
            placeholderImage:placeholder
                     options:SDWebImageRetryFailed | SDWebImageLowPriority | SDWebImageAvoidAutoSetImage
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       if (!wself) {
                           return;
                       }
                       if (image) {
                           if (isInWCS) {
                               if (cornerRadius > 1.0) {
                                   self.image = [self ff_image:image cornerRadius:cornerRadius];
                               }else{
                                   self.image = image;
                               }
                               [self setNeedsLayout];
                           }else{
                               [wself cropDownloadImage:image
                                           cornerRadius:cornerRadius
                                             expectSize:size
                                                saveKey:sizeImagekey];
                               [[SDWebImageManager sharedManager].imageCache removeImageForKey:imageURL.absoluteString fromDisk:NO withCompletion:nil];
                           }
                       }
                       else {
                           wself.image = placeholder;
                           [wself setNeedsLayout];
//                           if (error.code >= 500 && error.code < 510 && retryCount < 4) {
//                               [wself ff_loadURL:url placeholderImage:placeholder isInWCS:isInWCS cornerRadius:cornerRadius expectSize:size saveKey:sizeImagekey retryCount:retryCount];
//                           }
                       }
                   }];
}


//网宿地址处理(居中裁切)
- (NSString *)appendWCSPath:(NSString *)path
                   cropSize:(CGSize)size {
    if ([path containsString:@"?op=imageMogr2"]) {
        return path;
    }
    CGFloat screenScale = [UIScreen mainScreen].scale;
//    if (screenScale > 2.0) {
//        screenScale = 2.0;
//    }
    CGFloat width = size.width * screenScale;
    CGFloat height = size.height * screenScale;
//    NSString *thumbnail = [NSString stringWithFormat:@"?op=imageMogr2&gravity=CENTER&square=true&thumbnail=%.fx%.f", width, height];
    NSString *thumbnail = [NSString stringWithFormat:@"?op=imageView2&mode=1&width=%.f&height=%.f", width, height];
    NSString *str = [path stringByAppendingString:thumbnail];
    return str;
}

// 本地裁切后的地址
- (NSString *)cropFromPath:(NSString *)path
                  cropSize:(CGSize)size {
    NSString *sizeStr = [NSString stringWithFormat:@"_%.0f_%.0f",size.width,size.height];
    NSString *pathStr = [[path stringByDeletingPathExtension] stringByAppendingString:sizeStr];
    NSString *extensionStr = [path pathExtension];
    NSString *str = @"";
    if (extensionStr) {
        str = [pathStr stringByAppendingPathExtension:extensionStr];
    }
    else {
        str = pathStr;
    }
    return str;
}

// 本地裁切后图片
- (void)cropDownloadImage:(UIImage *)originImage
            cornerRadius:(CGFloat)cornerRadius
               expectSize:(CGSize)size
                  saveKey:(NSString *)key {
    UIImage *resizeImage = [originImage ff_imageByResizeToSize:size contentMode:UIViewContentModeScaleAspectFill];
    [[SDWebImageManager sharedManager] saveImageToCache:resizeImage
                                                 forURL:[NSURL URLWithString:key]];
    if (cornerRadius > 1.0) {
        self.image = [self ff_image:resizeImage cornerRadius:cornerRadius];
    }else{
        self.image = resizeImage;
    }
    [self setNeedsLayout];
}

#pragma mark - 圆角图片支持
- (void)ff_setImageStr:(NSString *)urlStr
               fitSize:(CGSize)size
          cornerRadius:(CGFloat)cornerRadius
           placeholder:(UIImage *)placeholder
{
    [self ff_setImageStr:urlStr fitSize:size cornerRadius:cornerRadius placeholder:placeholder useWCS:YES];
}

-(UIImage *)ff_image:(UIImage *)image cornerRadius:(CGFloat)cornerRadius
{
    UIImage *resultImage;
    if (fabs(cornerRadius - kImageCornerRadiusMax) < 1.0) {
        resultImage = [image ff_imageByRoundRadius:image.size.height*0.5];
    }else{
        cornerRadius *= [UIScreen mainScreen].scale / image.scale;
        resultImage = [self ff_image:image byRoundRadius:cornerRadius];
    }
    return resultImage;
}

- (UIImage *)ff_image:(UIImage *)image byRoundRadius:(CGFloat)radius
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    //    CGContextAddEllipseInRect(ctx, rect);
    CGContextAddPath(ctx, [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(ctx);
    [image drawInRect:rect];
    UIImage *rImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return rImage;
}

#pragma mark - Url Encode
- (NSString *)urlEncode:(NSString *)str {
    NSCharacterSet *charSet = [NSCharacterSet URLFragmentAllowedCharacterSet];
    //"#%<>[\]^`{|}
    NSString *newString = [str stringByAddingPercentEncodingWithAllowedCharacters:charSet];
    if (newString) {
        return newString;
    }
    return str;
}

@end
