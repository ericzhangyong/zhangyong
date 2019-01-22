//
//  YHHomeViewController.m
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/1/17.
//  Copyright © 2019年 yh. All rights reserved.
//

#import "YHHomeViewController.h"
#import "YHHomeFooterView.h"
#import "YHHomeHeaderView.h"
#import "YHHomeModel.h"
#import "YHHomeRecommendCell.h"
#import "YHHomeActivityCell.h"
#import "YHHomeClassiftyCell.h"

@interface YHHomeViewController ()

@property (nonatomic,strong)  YHHomeHeaderView *headerView;
@property (nonatomic,strong)  YHHomeFooterView *footerView;

@end

@implementation YHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    [self loadWebDataSource];
}

-(void)setUpViews{
    
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(YHMasStatusBarHeight);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"YHHomeActivityCell" bundle:nil] forCellReuseIdentifier:@"cell0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YHHomeActivityCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YHHomeClassiftyCell" bundle:nil] forCellReuseIdentifier:@"cell2"];


    //headerView
    YHHomeHeaderView *headerView =[YHHomeHeaderView createHomeHeaderView];
    self.tableView.tableHeaderView = headerView;
    //footerView
    YHHomeFooterView *footerview = [YHHomeFooterView createHomeFooterView];
    self.tableView.tableFooterView = footerview;
}

-(void)loadWebDataSource{
    [super loadWebDataSource];
    
//    YHHomeModel *sectionModel = [YHHomeModel new];
//    sectionModel.sectionTitle = @"爆款推荐";
//    NSMutableArray *dataArr = [NSMutableArray array];
//    YHHomeCellModel *cellModel1 = [YHHomeCellModel new];
//    cellModel1.title = @"测试一";
//    YHHomeCellModel *cellModel2 = [YHHomeCellModel new];
//    cellModel2.title = @"测试一";
//    [dataArr addObject:cellModel1];
//    [dataArr addObject:cellModel2];
//    sectionModel.data =dataArr;
//    
//    YHHomeModel *sectionModel2 = [YHHomeModel new];
//    sectionModel2.sectionTitle = @"活动专区";
//    sectionModel2.data =dataArr;
//    YHHomeModel *sectionModel3 = [YHHomeModel new];
//    sectionModel3.sectionTitle = @"分类推荐";
//    sectionModel3.data =dataArr;
//    [self.dataSource addObject:sectionModel];
//    [self.dataSource addObject:sectionModel2];
//    [self.dataSource addObject:sectionModel3];
//    [self.tableView reloadData];
    
}

#pragma UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.dataSource[section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [UIView new];
    sectionView.frame = CGRectMake(0, 0, kScreenWidth, 20);
    sectionView.backgroundColor = [UIColor ff_colorWithHexString:@"f1f1f1"];
    return sectionView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        YHHomeRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0" forIndexPath:indexPath];
        return cell;
    }else if(indexPath.section == 1){
        YHHomeActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        return cell;
    }else if(indexPath.section == 2){
        YHHomeClassiftyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        return cell;
    }
    return nil;
}




@end
