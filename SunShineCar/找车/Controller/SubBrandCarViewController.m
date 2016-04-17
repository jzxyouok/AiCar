//
//  SubBrandCarViewController.m
//  SunShineCar
//
//  Created by stellar on 16/4/12.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "SubBrandCarViewController.h"
#import "HttpTools.h"
#import "YYModel.h"
#import "Public.h"
#import "SubCarBrand.h"
#import "SubBrand.h"
#import "UIImageView+WebCache.h"
#import "SubBrandTableViewCell.h"
#import "SubBrandDetailTableViewController.h"
#import "MineDefineNavigationController.h"
#import "BarButtonItem.h"
@interface SubBrandCarViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIWindow *window;
@end

@implementation SubBrandCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
//    NSLog(@"%@",self.brandCarID);
    [self setUpTableView];
    [self loadData];
    
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
//数据加载
- (void)loadData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[BRANDID] = self.brandCarID;
    [HttpTools get:YYGetCarSubBrandsURL params:param success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
//        NSLog(@"%@",dict);
        for (NSDictionary *tempDict in dict[@"subBrands"]) {
            SubCarBrand *model = [SubCarBrand yy_modelWithDictionary:tempDict];
            [self.dataArray addObject:model];
        }
        //数据请求成功，刷新表格数据
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
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 99.0*ScreenHeight/667.0) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 数据源
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
//每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SubCarBrand *model = self.dataArray[section];
    return model.series.count;
}

//cell绑定数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SubBrandTableViewCell *cell = [SubBrandTableViewCell cellWithTableView:tableView];
    SubCarBrand *subCar = self.dataArray[indexPath.section];
    SubBrand *model = subCar.series[indexPath.row];
    
    
    cell.model = model;

    return cell;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SubCarBrand *subCarBrand = self.dataArray[section];
    return subCarBrand.subBrandName;
}
#pragma mark - 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0*ScreenHeight/667.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight)];
    self.window.windowLevel = UIWindowLevelNormal;
    
    SubBrandDetailTableViewController *detail = [SubBrandDetailTableViewController alloc];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detail];
    
    detail.title = @"车系详情";
    detail.navigationItem.leftBarButtonItem = [BarButtonItem barButtonWithTitle:@"返回" target:self action:@selector(backBaseController)];
//    detail.navigationItem.leftBarButtonItem = [DefineBarButtonItem barButtonWithImage:@"nav_fanhui" title:@"返回" target:self action:@selector(backBaseController)];
    detail.navigationItem.rightBarButtonItem = [BarButtonItem barButtonWithTitle:@"更多" target:self action:@selector(moreData)];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.window setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }];
    //把seriesId传给详情视图控制器
    SubCarBrand *subCar = self.dataArray[indexPath.section];
    SubBrand *model = subCar.series[indexPath.row];
    NSString *subCarsID = [model valueForKey:@"seriesId"];
    detail.subBrandID = subCarsID;
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}
#pragma mark - 导航栏按钮@selector点击事件方法
//返回一定要销毁窗口
- (void)backBaseController
{
    [UIView animateWithDuration:0.2 animations:^{
        [self.window setFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight)];
    } completion:^(BOOL finished) {
        [self.window resignKeyWindow];
        self.window = nil;
    }];
}
- (void)moreData
{
    NSLog(@"－－－ 更多数据 －－－");
}
@end
