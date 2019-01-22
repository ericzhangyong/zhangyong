//
//  FFKeyChain.m
//  Funmily
//
//  Created by Kuroky on 16/9/9.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import "FFKeyChain.h"
#import "SAMKeychain.h"

static  NSString *const         KDefaultService     =   @"com.huuhoo.Funmily";
NSString *const keyChainDeviceIdAccount             =   @"deviceIdAccount";

@implementation FFKeyChain

+ (NSString *)ff_keychainValueForKey:(NSString *)key {
    
    if (!key) {
        return nil;
    }
    
    NSString *str = [SAMKeychain passwordForService:KDefaultService
                                            account:key];
    return str;
}

+ (BOOL)ff_setKeychain:(NSString *)value forKey:(NSString *)key {
    
    if (!value || !key) {
//        NSString *str = [NSString stringWithFormat:@"keychain save fail key: %@ value: %@", key, value];
//        DDLogError(str);
        return NO;
    }
    
    BOOL saveSuccess = [SAMKeychain setPassword:value
                                     forService:KDefaultService
                                        account:key];
    if (!saveSuccess) {
//        NSString *str = [NSString stringWithFormat:@"keychain save fail key: %@ value: %@", key, value];
//        DDLogError(str);
    }
    return saveSuccess;
}

+ (BOOL)ff_deleteKeychainValueForKey:(NSString *)key {
    
    BOOL deleteSuccess = [SAMKeychain deletePasswordForService:KDefaultService account:key];
    if (!deleteSuccess) {
//        NSString *str = [NSString stringWithFormat:@"keychain value delete fail key: %@", key];
//        DDLogError(str);
    }
    return deleteSuccess;
}

@end
