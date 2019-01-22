//
//  FFCommonCache.h
//  Funmily
//
//  Created by kevin on 16/8/17.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFCache : NSObject
/**
 *  默认保存7天
 */
+ (_Nullable instancetype)sharedCache;
/**
 *  永久保存
 */
+ (_Nullable instancetype)sharedCacheForever;
/**
 *  保存3天
 */
+ (_Nullable instancetype)sharedCache3Day;

- (BOOL)ff_containsObjectForKey:( NSString * _Nonnull )key;

- (_Nullable id<NSCoding>)ff_objectForKey:(NSString * _Nonnull)key;

/**
 *  读取大数据 需要异步读取，否则会占用进程时间
 */
- (void)ff_objectForKey:(NSString * _Nonnull)key withBlock:(void(^ _Nullable)(NSString * _Nonnull key, id<NSCoding> _Nonnull object))block;

- (void)ff_setObject:(_Nonnull id<NSCoding>)object forKey:(NSString * _Nullable)key forDisk:(BOOL)isDisk;

- (void)ff_setObject:(_Nonnull id<NSCoding>)object forKey:(NSString * _Nullable)key;

- (void)ff_removeObjectForKey:(NSString * _Nonnull)key;

- (void)ff_removeAllObjects;

@end
