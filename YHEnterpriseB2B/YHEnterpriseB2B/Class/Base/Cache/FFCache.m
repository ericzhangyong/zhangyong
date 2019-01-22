//
//  FFCommonCache.m
//  Funmily
//
//  Created by kevin on 16/8/17.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import "FFCache.h"
#import "YYCache.h"

/**
 *  用于分组缓存，及 缓存策略
 */
typedef NS_ENUM(NSInteger,FFCacheType) {
    /**
     *  默认模式
     */
    FFCacheTypeDefault,
    /**
     *  永久存储
     */
    FFCacheTypeForever,
    /**
     *  缓存3天
     */
    FFCacheTypeLimit3Day,
};

@interface FFCache()

@property (nonatomic, strong) YYCache *manageCache;

@end

@implementation FFCache

+ (instancetype)sharedCache
{
    static id cache;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        cache = [[self alloc] initWithCacheType:FFCacheTypeDefault];
    });
    
    return cache;
}

+ (instancetype)sharedCacheForever
{
    static id cache;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        cache = [[self alloc] initWithCacheType:FFCacheTypeForever];
    });
    
    return cache;
}

+ (instancetype)sharedCache3Day
{
    static id cache;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        cache = [[self alloc] initWithCacheType:FFCacheTypeLimit3Day];
    });
    
    return cache;
}


-(instancetype)initWithCacheType:(FFCacheType)type
{
    self = [super init];
    if (type == FFCacheTypeForever) {
        _manageCache = [YYCache cacheWithPath:[self getCachePathWithName:@"ff_forever"]];
    }else if(type == FFCacheTypeLimit3Day) {
        _manageCache = [YYCache cacheWithPath:[self getCachePathWithName:@"ff_limit3day"]];
        _manageCache.diskCache.ageLimit = 3*24*60*60;
    }else{
        _manageCache = [YYCache cacheWithPath:[self getCachePathWithName:@"ff_default"]];
        _manageCache.diskCache.ageLimit = 7*24*60*60;
    }
    
    return self;
}


-(NSString *)getCacheFolderPath
{
    NSString *folderPath = [NSString stringWithFormat:@"%@/Library/funmily/mycache",NSHomeDirectory()];
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return folderPath;
}
-(NSString *)getCachePathWithName:(NSString *)name
{
    return [[self getCacheFolderPath] stringByAppendingPathComponent:name];
}



- (BOOL)ff_containsObjectForKey:(NSString *)key
{
    return [_manageCache containsObjectForKey:key];
}

- (nullable id<NSCoding>)ff_objectForKey:(NSString *)key
{
    return [_manageCache objectForKey:key];
}

- (void)ff_objectForKey:(NSString *)key withBlock:(void(^)(NSString *key, id<NSCoding> object))block
{
    [_manageCache objectForKey:key withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(key,object);
        });
    }];
}
- (void)ff_setObject:(_Nonnull id<NSCoding>)object forKey:(NSString *)key forDisk:(BOOL)isDisk
{
    if (isDisk) {
        [_manageCache.diskCache setObject:object forKey:key];
    }else{
        [self ff_setObject:object forKey:key];
    }
}
- (void)ff_setObject:(_Nonnull id<NSCoding>)object forKey:(NSString *)key
{
    return [_manageCache setObject:object forKey:key];
}

- (void)ff_removeObjectForKey:(NSString *)key
{
    return [_manageCache removeObjectForKey:key];
}

- (void)ff_removeAllObjects
{
    return [_manageCache removeAllObjects];
}

@end
