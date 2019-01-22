//
//  FFBaseWebViewController.h
//  Funmily
//
//  Created by Kuroky on 16/10/13.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import "FFBaseViewController.h"
#import <WebKit/WebKit.h>

@interface FFBaseWebViewController : FFBaseViewController

@property (nonatomic, strong, readonly) WKWebView *wkwebView;

@property (nonatomic, copy) NSString *webUrl;
@property (nonatomic, copy) NSString *webToken;

@property (nonatomic,strong) WKWebViewConfiguration *configuration;
@property (nonatomic,strong) WKUserContentController *userContentController;

-(void)loadUrl:(NSString *)url;

@end
