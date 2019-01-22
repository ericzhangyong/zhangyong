//
//  FFWeakScriptMessageDelegate.m
//  Funmily
//
//  Created by zhangyong on 17/8/10.
//  Copyright © 2017年 HuuHoo. All rights reserved.
//

#import "FFWeakScriptMessageDelegate.h"

@implementation FFWeakScriptMessageDelegate


- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate
{
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

@end
