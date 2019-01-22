//
//  KEBasePullTableViewController.h
//  Funmily
//
//  Created by kevin on 17/4/6.
//  Copyright © 2017年 HuuHoo. All rights reserved.
//

#import "KEBaseTableViewController.h"

#import "MJRefresh.h"
#import "UIScrollView+EmptyDataSet.h"
#import "FFTableViewAdditionalDelegate.h"

@interface KEBasePullTableViewController:KEBaseTableViewController<FFTableViewAdditionalDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic,assign) NSUInteger pullPageIndex;

@property (nonatomic,assign) BOOL isLoading;

@property (nonatomic,weak) id<FFTableViewAdditionalDelegate> pullDelegate;


/**
 *  加载网络数据  需要重载
 */
-(void)loadWebDataSource;

/**
 *  下拉 调用
 */
-(void)loadTableViewHeader;
/**
 *  上拉 调用
 */
-(void)loadTableViewFooter;

/**
 *  加载完成 调用
 *  @param count 获取到的数据数。错误 传 -1
 */
-(void)endRefreshingWithCount:(NSInteger)count;

@end
