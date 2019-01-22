//
//  FFDBHelper.h
//  Funmily
//
//  Created by kevin on 16/8/18.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDB.h"

@interface FFDBHelper : NSObject

@property (nonatomic, strong, readonly) FMDatabaseQueue *dbQueue;

+ (FFDBHelper *)shareInstance;

+ (NSString *)dbPath;


@end
