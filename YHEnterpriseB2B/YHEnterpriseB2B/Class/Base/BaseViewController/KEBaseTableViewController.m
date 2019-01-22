//
//  KEBaseTableViewController.m
//  Funmily
//
//  Created by kevin on 17/4/6.
//  Copyright © 2017年 HuuHoo. All rights reserved.
//

#import "KEBaseTableViewController.h"
#import "UIColor+FFHEX.h"
//#import "UINavigationBar+Awesome.h"

@interface KEBaseTableViewController ()

@property (nonatomic, assign) CGFloat navProgress;
@property (nonatomic, assign) CGFloat preOffY;

@end

@implementation KEBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    _navProgress = 1.0;
    _preOffY = 0.0;
    
}

#pragma mark - 懒加载属性

-(UITableViewStyle)ps_tableViewStryle
{
    return UITableViewStylePlain;
}
-(BOOL)ps_needNavBarScroll
{
    return NO;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.ps_tableViewStryle];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.backgroundColor = [UIColor ff_colorWithHexString:@"#f1f1f1"];
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_tableView setTableFooterView:view];
//        if (@available(iOS 11.0, *)){
//            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        }
    }
    return _tableView;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // in subClass
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma makr - test move navBar
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (!self.view.window) {
//        return;
//    }
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if (offsetY > 0) {
//        //        if (offsetY >= 44) {
//        //            [self setNavigationBarTransformProgress:1];
//        //        } else {
//        //            [self setNavigationBarTransformProgress:(offsetY / 44)];
//        //        }
//
//        if ((_preOffY - offsetY) > 0 && offsetY > 100){
//            _preOffY = offsetY;
//            return;
//        }
//
//        _navProgress += (_preOffY - offsetY) / 44;
//        if (_navProgress >= 1) {
//            _navProgress = 1;
//            [self setNavigationBarTransformProgress:0];
//        }else if(_navProgress <= 0){
//            _navProgress = 0;
//            [self setNavigationBarTransformProgress:1];
//        }else{
//
//
//            [self setNavigationBarTransformProgress:(1 - _navProgress)];
//        }
//    } else {
//        [self setNavigationBarTransformProgress:0];
//        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
//    }
//    _preOffY = offsetY;
//}
//
//- (void)setNavigationBarTransformProgress:(CGFloat)progress
//{
//    if (!self.ps_needNavBarScroll) {
//        return;
//    }
//    [self.navigationController.navigationBar lt_setTranslationY:(-44 * progress)];
//    [self.navigationController.navigationBar lt_setElementsAlpha:(1-progress)];
//}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self resetNav];
}
-(void)resetNav
{
    if (!self.ps_needNavBarScroll) {
        return;
    }
//    [self.navigationController.navigationBar lt_reset];
    _navProgress = 1.0;
}


- (void)dealloc {
    _dataSource = nil;
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    _tableView = nil;
}
@end
