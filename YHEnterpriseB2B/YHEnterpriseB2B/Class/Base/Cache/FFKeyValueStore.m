//
//  FFKeyValueStore.m
//  Funmily
//
//  Created by kevin on 16/8/17.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import "FFKeyValueStore.h"
#import "YTKKeyValueStore.h"

#import "YYModel.h"

@interface FFKeyValueStore()

@property (nonatomic, strong) YTKKeyValueStore *kvStore;

@property (nonatomic, assign) FFTableType kvType;

@end


static FFKeyValueStore *ffStoreTemp;
static FFKeyValueStore *ffStoreConfig;
static FFKeyValueStore *ffStoreRestart;

#define kStoreTableName [FFKeyValueStore getTableNameWithType:_kvType]

#define PATH_OF_Library    [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@implementation FFKeyValueStore

+(instancetype)createWithType:(FFTableType)type
{
    FFKeyValueStore *store = [[FFKeyValueStore alloc] init];
    store.kvType = type;
    return store;
}

+(instancetype)shareStoreWithType:(FFTableType)type
{
    FFKeyValueStore *store;
    if (type == FFTableTypeReStart) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            ffStoreRestart = [FFKeyValueStore createWithType:type];
        });
        store = ffStoreRestart;
    }else if (type == FFTableTypeConfig) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            ffStoreConfig = [FFKeyValueStore createWithType:type];
        });
        store = ffStoreConfig;
    }else {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            ffStoreTemp = [FFKeyValueStore createWithType:type];
        });
        store = ffStoreTemp;
    }
    return store;
}

-(void)setKvType:(FFTableType)kvType
{
    NSString *tableName = [FFKeyValueStore getTableNameWithType:kvType];
    [self.kvStore createTableWithName:tableName];
    _kvType= kvType;
}
- (YTKKeyValueStore *)kvStore
{
    if (!_kvStore) {
        NSString * dbFolder = [PATH_OF_Library stringByAppendingPathComponent:@"funmily/mycache"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:dbFolder]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:dbFolder withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString * dbPath = [dbFolder stringByAppendingPathComponent:@"ff_keyValueStore.db"];
        _kvStore = [[YTKKeyValueStore alloc] initWithDBWithPath:dbPath];
    }
    return _kvStore;
}


+ (NSString *)getTableNameWithType:(FFTableType)type
{
    NSString *tableName = [NSString stringWithFormat:@"ff_table_%zd",type];
    return tableName;
}


- (void)ff_putObject:(id)object withId:(NSString *)objectId
{
    id saveObject = object;
    if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
        saveObject = @[object];
    }
    
    if (![NSJSONSerialization isValidJSONObject:saveObject]) {
//        DDLogError(@"保存失败");
        return;
    }
    
    [self.kvStore putObject:saveObject withId:objectId intoTable:kStoreTableName];
}

//存数组 单个的 会有点小问题。
- (id)ff_getObjectById:(NSString *)objectId
{
    id obj = [self.kvStore getObjectById:objectId fromTable:kStoreTableName];
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *arr = (NSArray *)obj;
        if (arr.count == 1) {
            return arr.firstObject;
        }
    }
    return obj;
}

- (void)ff_deleteObjectById:(NSString *)objectId
{
    [self.kvStore deleteObjectById:objectId fromTable:kStoreTableName];
}

- (void)ff_clearTable
{
    [self.kvStore clearTable:kStoreTableName];
}


- (void)ff_putOCObject:(id)object withId:(NSString *)objectId;
{
    id jsonObj = [object yy_modelToJSONObject];
    [self ff_putObject:jsonObj withId:objectId];
}

- (id)ff_getOCObjectById:(NSString *)objectId forClass:(Class)class
{
    id resultObj = [self ff_getObjectById:objectId];
    
    if ([resultObj isKindOfClass:[NSArray class]]) {
        return [NSArray yy_modelArrayWithClass:class json:resultObj];
    }
    return [class yy_modelWithJSON:resultObj];
}
@end
