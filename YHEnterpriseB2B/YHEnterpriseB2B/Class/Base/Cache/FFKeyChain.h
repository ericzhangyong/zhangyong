//
//  FFKeyChain.h
//  Funmily
//
//  Created by Kuroky on 16/9/9.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const keyChainDeviceIdAccount;

/**
 *  保存数据到keychain (SAMKeychain)
 */
@interface FFKeyChain : NSObject

/**
 *  keychain数据读取
 *
 *  @param key key
 *
 *  @return NSString
 */
+ (NSString *)ff_keychainValueForKey:(NSString *)key;

/**
 *  keychain保存数据
 *
 *  @param value 保存的字段
 *  @param key   key
 *
 *  @return BOOL
 */
+ (BOOL)ff_setKeychain:(NSString *)value forKey:(NSString *)key;

/**
 *  keychain数据删除
 *
 *  @param key key
 *
 *  @return BOOL
 */
+ (BOOL)ff_deleteKeychainValueForKey:(NSString *)key;

@end
