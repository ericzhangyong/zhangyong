//
//  FFBaseWebViewController.m
//  Funmily
//
//  Created by Kuroky on 16/10/13.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import "FFBaseWebViewController.h"
#import "Masonry.h"
#import "FFProgressHUD.h"
#import "FFLoadView.h"
//#import "LHDuerOSApiManager.h"

@interface FFBaseWebViewController () <WKUIDelegate, WKNavigationDelegate> {
    
}

@property (nonatomic, strong, readwrite) WKWebView *wkwebView;
@property (nonatomic, strong) UIBarButtonItem *backBarItem;
@property (nonatomic, strong) UIBarButtonItem *closeBarItem;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) FFLoadView *loadStatusView;

@end

@implementation FFBaseWebViewController
-(void)loadUrl:(NSString *)url {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.wkwebView loadRequest:request];
    
//    [[LHDuerOSApiManager sharedInstance] requestEvent:event_LinkClicked token:self.webToken info:@{@"url":self.webUrl}];
}
#pragma mark - Get
- (WKWebView *)wkwebView {
    if (!_wkwebView) {
        _wkwebView = [self setupContentWebView];
    }
    return _wkwebView;
}

- (UIBarButtonItem *)backBarItem {
    if (!_backBarItem) {
        _backBarItem = [self setUpBackBarItem];
    }
    return _backBarItem;
}

- (UIBarButtonItem *)closeBarItem {
    if (!_closeBarItem) {
        _closeBarItem = [self setUpCloseBarItem];
    }
    return _closeBarItem;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [self setupProgressView];
    }
    return _progressView;
}

#pragma mark - Configuration
- (WKWebViewConfiguration *)setUpWebViewConfiguration {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    self.configuration = config;
    

    // 默认为0
    //config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    self.userContentController = [[WKUserContentController alloc] init];
    self.configuration.userContentController = self.userContentController;
    
    // web内容处理池
    //config.processPool = [[WKProcessPool alloc] init];
//    if (IOS_VERSION_10_OR_LATER) {
//        config.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
//    }
//    else if (IOS_VERSION_9_OR_LATER) {
//        config.requiresUserActionForMediaPlayback = NO;
//    }
//    else {
//        config.mediaPlaybackAllowsAirPlay = NO;
//    }
    return config;
}

- (WKWebView *)setupContentWebView {
    WKWebViewConfiguration *config = [self setUpWebViewConfiguration];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    webView.translatesAutoresizingMaskIntoConstraints = NO;
    webView.backgroundColor = [UIColor clearColor];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [webView addObserver:self
              forKeyPath:NSStringFromSelector(@selector(loading))
                 options:NSKeyValueObservingOptionNew
                 context:nil];
    #pragma clang diagnostic pop
    [webView addObserver:self
              forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                 options:NSKeyValueObservingOptionNew
                 context:nil];
    
    [webView addObserver:self
                   forKeyPath:NSStringFromSelector(@selector(title))
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    return webView;
}

- (UIBarButtonItem *)setUpBackBarItem {
   UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackBar:)];
    return backBarItem;
}

- (UIBarButtonItem *)setUpCloseBarItem {
    UIBarButtonItem *closeBarItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickPopBar:)];
    return closeBarItem;
}

- (UIProgressView *)setupProgressView {
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
//    progressView.progressTintColor = [UIColor colorWithRed:63/255.0 green:182/255.0 blue:215/255.0 alpha:1.0f];
//    FF3E90
    progressView.progressTintColor = [UIColor colorWithRed:255/255.0 green:62/255.0 blue:144/255.0 alpha:1.0f];
    
    return progressView;
}


#pragma mark - ViewController Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self addContentView];
}

- (void)addContentView {
    [self.view addSubview:self.wkwebView];
    [self.view addSubview:self.progressView];
    
    [self.wkwebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
    }];
    self.wkwebView.hidden = YES;
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.height.equalTo(@(2));
    }];
    self.loadStatusView = [FFLoadView ff_loadStatusView:FFLoadIsLoaing];
    [self.view addSubview:self.loadStatusView];
    [self.loadStatusView ff_reloadData];
    [self.navigationItem setLeftBarButtonItems:@[self.backBarItem]];
}

- (void)setWebUrl:(NSString *)webUrl {
    _webUrl = webUrl;
}

#pragma mark - ProgressView
- (void)showProgressBar {
    if (self.progressView.alpha == 0.0) {
        self.progressView.alpha = 1.0;
    }
}

- (void)hideProgressbar {
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.progressView.alpha = 0.0f;
                     }];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if (![object isKindOfClass:[WKWebView class]]) {
        return;
    }
    WKWebView *webView = (WKWebView *)object;
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]) {
        self.progressView.progress = webView.estimatedProgress;
    }
    else if ([keyPath isEqualToString:NSStringFromSelector(@selector(title))]) {
        if (!self.navigationItem.title) {
            self.navigationItem.title = webView.title;
        }
        //self.navigationItem.title = webView.title;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    else if ([keyPath isEqualToString:NSStringFromSelector(@selector(loading))]) {
   #pragma clang diagnostic pop
    }
    
    if (!webView.isLoading) {
        [self hideProgressbar];
        self.wkwebView.hidden = NO;
        [self updateCloseButton];
        if (self.loadStatusView.loadType != FFLoadShouldHide) {
            self.loadStatusView.loadType = FFLoadShouldHide;
            [self.loadStatusView ff_reloadData];
        }
    }
    else {
        [self showProgressBar];
        if (self.loadStatusView.loadType != FFLoadIsLoaing) {
            self.loadStatusView.loadType = FFLoadIsLoaing;
            [self.loadStatusView ff_reloadData];
        }
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [[FFProgressHUD sharedProgressHUD] toastTitle:@"无法加载,请重试!"];
}

- (void)updateCloseButton {
    if ([self.wkwebView canGoBack]) {
        [self.navigationItem setLeftBarButtonItems:@[self.backBarItem, self.closeBarItem]];
    }
    else {
        [self.navigationItem setLeftBarButtonItems:@[self.backBarItem]];
    }
}

#pragma marl - Button Action 
- (void)clickBackBar:(id)sender {
    if ([self.wkwebView canGoBack]) {
        [self.wkwebView goBack];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)clickPopBar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)removeContentView {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self.wkwebView removeObserver:self
                        forKeyPath:NSStringFromSelector(@selector(loading))
                           context:nil];
    #pragma clang diagnostic pop
    [self.wkwebView removeObserver:self
                  forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                     context:nil];
    [self.wkwebView removeObserver:self
                        forKeyPath:NSStringFromSelector(@selector(title))
                           context:nil];
    self.wkwebView.UIDelegate = nil;
    self.wkwebView.navigationDelegate = nil;
}

- (void)dealloc {
    [self removeContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
