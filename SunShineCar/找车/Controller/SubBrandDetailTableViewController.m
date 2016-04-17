//
//  SubBrandDetailTableViewController.m
//  SunShineCar
//
//  Created by stellar on 16/4/12.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "SubBrandDetailTableViewController.h"
#import "Public.h"
#import "YYModel.h"
#import "HttpTools.h"
#import "SeriesCarBrand.h"
#import "SeriesBrand.h"
#import "SeriesCarTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "HeaderView.h"
@interface SubBrandDetailTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSDictionary *dict;
@end

@implementation SubBrandDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
//    NSLog(@"%@",self.subBrandID);

    [self setUpTableView];
    [self loadData];
    [self loadHeaderView];
}
- (void)loadHeaderView
{
    self.tableView.tableHeaderView = [HeaderView itemView];
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

//加载数据
- (void)loadData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[SERIESID] = self.subBrandID;
    [HttpTools get:YYGetSeriesInfoNewsURL params:param success:^(id data) {
        self.dict = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
//        NSLog(@"%@",self.dict);
        
        for (NSDictionary *tempDict in self.dict[@"saleSubSeries"]) {
            SeriesCarBrand *seriesModel = [SeriesCarBrand yy_modelWithDictionary:tempDict];
            [self.dataArray addObject:seriesModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
//创建表格
- (void)setUpTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64.0*ScreenHeight/667.0) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    tableView.rowHeight = 150.0*ScreenHeight/667.0;
    // 设置tableView的额外滚动区域
//    [tableView setContentInset:UIEdgeInsetsMake(0.0, 0.0, 0.0, 150)];
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SeriesCarBrand *model = self.dataArray[section];
    return model.cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //发出通知，某些地方需要就注册通知，接收数据
    [YYNotificationCenter postNotificationName:YYDictName object:nil userInfo:@{YYDict : self.dict}];
    
    SeriesCarTableViewCell *cell = [SeriesCarTableViewCell cellWithTableView:tableView];
    SeriesCarBrand *carBrand = self.dataArray[indexPath.section];
    SeriesBrand *modelBrand = carBrand.cars[indexPath.row];
    cell.model = modelBrand;
    return cell;
}
#pragma mark - Table view delegate
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SeriesCarBrand *model = self.dataArray[section];
    return model.engine;
}
#pragma mark - Table view header
@end
