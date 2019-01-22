//
//  FFWeakScriptMessageDelegate.h
//  Funmily
//
//  Created by zhangyong on 17/8/10.
//  Copyright © 2017年 HuuHoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>


@interface FFWeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>


@property (nonatomic, retain) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
