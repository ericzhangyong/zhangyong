//
//  YHBaseModel.m
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/1/16.
//  Copyright © 2019年 yh. All rights reserved.
//

#import "YHBaseModel.h"
#import "YYModel.h"


@implementation YHBaseModel
#pragma mark - json字典转换成Model
+ (id)ff_convertModelWithJsonDic:(NSDictionary *)jsonDic {
    
    return [self yy_modelWithDictionary:jsonDic];
}

#pragma mark - json字符串转换成Model
+ (id)ff_convertModelWithJsonStr:(NSString *)jsonStr {
    
    return [self yy_modelWithJSON:jsonStr];
}

#pragma mark - json数组model化
+ (NSArray *)ff_convertModelWithJsonArr:(NSArray *)jsonArr {
    
    return [NSArray yy_modelArrayWithClass:self json:jsonArr];
}

#pragma mark - Coding/Copying/hash/equal
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

- (id)copyWithZone:(NSZone *)zone {
    
    return [self yy_modelCopy];
}

- (NSUInteger)hash {
    
    return [self yy_modelHash];
}

- (BOOL)isEqual:(id)object {
    
    return [self yy_modelIsEqual:object];
}

- (NSString *)description {
    
    return [self yy_modelDescription];
}

@end

@implementation NSObject (FFBaseModel)

#pragma mark - model转成json对象
- (NSMutableDictionary *)ff_modelToJsonDictionary {
    
    id obj = [self yy_modelToJSONObject];
    return obj;
}

- (NSString *)ff_modelToJsonString
{
    return [self yy_modelToJSONString];
}

@end

@implementation NSString (FFBaseModel)

- (NSDictionary *)ff_stringToJsonDictionary {
    //    if (![NSJSONSerialization isValidJSONObject:self]) {
    //        return nil;
    //    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic;
    if (jsonData) {
        jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                  options:NSJSONReadingAllowFragments
                                                    error:nil];
    }
    if (!jsonDic || ![jsonDic isKindOfClass:[NSDictionary class]]) {
        jsonDic = nil;
    }
    return jsonDic;
}

@end
