//
//  AppDelegate.h
//  Testdownload
//
//  Created by zhangyong on 2019/1/14.
//  Copyright © 2019年 lehu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

