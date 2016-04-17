//
//  BrandCarViewController.m
//  SunShineCar
//
//  Created by stellar on 16/4/10.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "BrandCarViewController.h"
#import "Public.h"
#import "HttpTools.h"
#import "YYModel.h"
#import "Brand.h"
#import "CarBrand.h"
#import "SpecialSaleModel.h"
#import "BrandTableViewCell.h"
#import "SpecialSaleHeaderView.h"
#import "SubBrandCarViewController.h"
#import "UIView+SDAutoLayout.h"
@interface BrandCarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

//@property(nonatomic,strong)NSMutableArray *specilSaleDataArray;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic,weak) UIView *backgroudView;
@end

@implementation BrandCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpTableView];
    //加载数据
    [self loadBrand];

    [self loadHeaderView];
    [self loadHeaderData];
}
#pragma mark - headerView
- (void)loadHeaderView
{
    self.tableView.tableHeaderView = [SpecialSaleHeaderView itemView];
}

- (void)loadHeaderData
{
    NSMutableDictionary *paramer = [NSMutableDictionary dictionary];
    //城市参数可以根据定位来修改，固定到某一个城市
    paramer[cityIds] = @150;
    [HttpTools get:YYGetSpecialSaleURL params:paramer success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
//        NSLog(@"%@",dict);
        SpecialSaleModel *model = [SpecialSaleModel yy_modelWithDictionary:dict];
        
        //发出模型通知，传model
        dispatch_async(dispatch_get_main_queue(), ^{
            [YYNotificationCenter postNotificationName:YYSpecialSaleName object:nil userInfo:@{YYSpecialSaleDict : model}];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark - 数据加载，创建表格
- (void)setUpTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20.0*ScreenHeight/667.0, ScreenWidth, ScreenHeight-99.0*ScreenHeight/667.0) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView.bounces = NO;
    //修改索引的字体颜色和背景
    tableView.sectionIndexColor = [UIColor redColor];
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];

    
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
- (void)loadBrand
{
    [HttpTools get:YYGetAllXCarBrandsURL params:nil success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
       
        for (NSDictionary *tempDict in dict[@"letters"]) {
       
            CarBrand *model = [CarBrand yy_modelWithDictionary:tempDict];
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
        CarBrand *datas = self.dataArray[section];
        return datas.brandNum;
}
//cell绑定数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        BrandTableViewCell *cell = [BrandTableViewCell cellWithTableView:tableView];
        CarBrand *carBrandmodel = self.dataArray[indexPath.section];
        Brand *model = carBrandmodel.brands[indexPath.row];
        cell.model = model;
        return cell;
}
//组标题
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CarBrand *carBrandmodel = self.dataArray[section];
    return carBrandmodel.letter;
   
}
//索引标题
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    return [self.dataArray valueForKey:@"letter"];
}
#pragma mark - 代理
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0*ScreenHeight/667.0;
}
//cell点击
#pragma mark - 创建新的窗口显示子数据
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CarBrand *carBrandmodeles = self.dataArray[indexPath.section];
//    //发出通知
//    [YYNotificationCenter postNotificationName:YYSubBrandsCarName object:nil userInfo:@{YYSubBrandsCarId : carBrandmodeles.brands[indexPath.row]}];
    
    //创建一个新的窗口，以此窗口来容纳汽车子品牌的数据
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(ScreenWidth, 50*ScreenHeight/667.0, ScreenWidth*4/3, ScreenHeight - 99.0*ScreenHeight/667.0)];
    //默认的
    self.window.windowLevel = UIWindowLevelNormal;
    self.window.backgroundColor = [UIColor cyanColor];
    SubBrandCarViewController *subBrand = [[SubBrandCarViewController alloc] init];
    CarBrand *carBrandmodeles = self.dataArray[indexPath.section];
    NSDictionary *brandDict = carBrandmodeles.brands[indexPath.row];
    
    NSString *subCarID = [brandDict objectForKey:@"id"];
    subBrand.brandCarID = subCarID;
    
    self.window.rootViewController = subBrand;
    [self.window makeKeyAndVisible];
    
    //设置阴影
    UIView *backgroudView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight)];
    //动画显示
    [UIView animateWithDuration:0.2 animations:^{
        [self.window setFrame:CGRectMake(ScreenWidth*4/3 - ScreenWidth - 30.0*ScreenWidth/375.0, 50*ScreenHeight/667.0, ScreenWidth*4/3, ScreenHeight - 99.0*ScreenHeight/667.0)];
        [backgroudView setFrame:self.view.bounds];
    }];
    backgroudView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    //阴影添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [backgroudView addGestureRecognizer:tap];
    [backgroudView addGestureRecognizer:pan];
    [self.view addSubview:backgroudView];
    self.backgroudView = backgroudView;
}

- (void)tapAction
{
    [UIView animateWithDuration:0.2 animations:^{
        //尺寸回到开始的状态
        [self.window setFrame:CGRectMake(ScreenWidth, 50*ScreenHeight/667.0, ScreenWidth / 4 * 3, ScreenHeight - 99)];
        [self.backgroudView setFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight)];
    } completion:^(BOOL finished) {
        //销毁背景阴影和窗口
        [self.backgroudView removeFromSuperview];
        [self.window resignKeyWindow];
        self.window = nil;
        self.backgroudView = nil;
    }];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [self tapAction];
}
@end
