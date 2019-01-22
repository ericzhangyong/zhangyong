//
//  BaseNavigationController.h
//  aihuuhoo
//
//  Created by kevin on 2018/3/28.
//  Copyright © 2018年 huuhoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController



@end

@interface UIViewController (FFPopGesture)

@property (nonatomic, assign) BOOL ff_interactivePopDisabled;


@end
