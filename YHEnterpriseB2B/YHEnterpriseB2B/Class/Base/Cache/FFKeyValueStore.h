//
//  FFKeyValueStore.h
//  Funmily
//
//  Created by kevin on 16/8/17.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  定义3个 tableView 用来保存不同功能的数据
 */
typedef NS_ENUM(NSInteger,FFTableType) {
    FFTableTypeTemp = 100,
    FFTableTypeConfig,
    FFTableTypeReStart,
};

@interface FFKeyValueStore : NSObject

+(instancetype)shareStoreWithType:(FFTableType)type;

- (void)ff_putObject:(id)object withId:(NSString *)objectId;

- (id)ff_getObjectById:(NSString *)objectId;

- (void)ff_deleteObjectById:(NSString *)objectId;

- (void)ff_clearTable;

/**
 *  存储 OC对象 实例 或者 数组
 *  @param object OC对象 实例 或者 数组
 *  @param objectId 存取键
 */
- (void)ff_putOCObject:(id)object withId:(NSString *)objectId;

/**
 *  获取 OC对象 实例 或者 数组
 *  @param objectId 存取键
 *  @param class 实例 类型
 *  @return OC对象 实例 或者 数组
 */
- (id)ff_getOCObjectById:(NSString *)objectId forClass:(Class)class;


@end
