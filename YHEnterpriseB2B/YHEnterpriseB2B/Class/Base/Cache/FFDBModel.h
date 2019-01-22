//
//  FFDBModel.h
//  Funmily
//
//  Created by kevin on 16/8/18.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import <Foundation/Foundation.h>

/** SQLite五种数据类型 */
#define SQLTEXT     @"TEXT"
#define SQLINTEGER  @"INTEGER"
#define SQLREAL     @"REAL"
#define SQLBLOB     @"BLOB"
#define SQLNULL     @"NULL"
#define PrimaryKey  @"primary key"

#define primaryId   @"pk"

@interface FFDBModel : NSObject

/** 主键 id */
@property (nonatomic, assign)   int        pk;

/**
 *  执行自定义SQL语句
 */
+ (BOOL)ff_executeUpdateSql:(NSString *)sql;

/** 保存或更新 有唯一键 通过这个方法保存或更新
 * 如果不存在主键 和 唯一键 onlyKey，保存，
 * 有主键，则更新
 */
- (BOOL)ff_saveOrUpdate;

/** 删除单个数据 */
- (BOOL)ff_deleteObject;

/** 通过条件删除数据 */
+ (BOOL)ff_deleteObjectsByCriteria:(NSString *)criteria;

/** 清空表 */
+ (BOOL)ff_clearTable;

/** 查询全部数据 */
+ (NSArray *)ff_findAll;

/** 查找某条数据 */
+ (instancetype)ff_findFirstByCriteria:(NSString *)criteria;

/** 通过条件查找数据
 * 这样可以进行分页查询 @" WHERE pk > 5 limit 10"
 */
+ (NSArray *)ff_findByCriteria:(NSString *)criteria;


#pragma mark - must be override method
/** 如果子类中有一些property不需要创建数据库字段，那么这个方法必须在子类中重写
 */
+ (NSArray *)ff_transients;
/** 设置 UNIQUE
 *  数据库中 唯一键,可以考虑设置成主键
 */
+ (NSString *)ff_onlyKey;

@end
