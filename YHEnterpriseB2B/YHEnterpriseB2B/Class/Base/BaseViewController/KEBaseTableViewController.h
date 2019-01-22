//
//  KEBaseTableViewController.h
//  Funmily
//
//  Created by kevin on 17/4/6.
//  Copyright © 2017年 HuuHoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFBaseViewController.h"
#import "Masonry.h"


@interface KEBaseTableViewController : FFBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

-(void)resetNav;

@property (nonatomic, assign, readonly) UITableViewStyle ps_tableViewStryle;

/**
 *  是否需要 NavBar 滚动
 */
@property (nonatomic, assign, readonly) BOOL ps_needNavBarScroll;

@end
