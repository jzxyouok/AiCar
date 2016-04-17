//
//  LatestNewsViewController.m
//  AnniCar
//
//  Created by stellar on 16/4/9.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "LatestNewsViewController.h"
#import "Public.h"
#import "HttpTools.h"
#import "HomeTableViewCell.h"
#import "LatestNewsModel.h"
#import "DefineHeaderView.h"
#import "YYModel.h"
#import "MJRefresh.h"
#import "LatestWebViewController.h"

@interface LatestNewsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableDictionary *param;

@property(nonatomic,assign)NSInteger count;
@property(nonatomic,assign)NSInteger offset;
@property(nonatomic,copy)NSString *subCarID;
@end

@implementation LatestNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置表格视图
    [self setUptableView];
    // 下拉加载最新数据
    [self pullDownToRefreshLatestNews];
    // 上拉加载更多数据
    [self pullUpToLoadMoreNews];
}
#pragma mark - lazy load
//数组初始化装数据模型
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
//字典初始化装传入参数
- (NSMutableDictionary *)param
{
    if (!_param) {
        _param = [NSMutableDictionary dictionary];
        /** 刷新的新闻数量（必须是整10的数，比如10，20，30等等，不然不会返回数据）*/
        _param[LIMIT] = @10;
        
        /** 刷新状态 0 为刷新最新的新闻 10 为刷新之前的新闻 每加10则加载更久之前的新闻 */
        _param[OFFSET] = @0;
        
        /** 新闻的类型 1为最新新闻（大杂烩） 2（国内外新车） 3（评测） 4（导购） 5（行情）*/
        _param[TYPE] = @1;
        
        /** version? 传不传没影响 */
        _param[VER] = @"6.6";
    }
    return _param;
}

#pragma mark - 刷新数据
/**
 *  下拉加载最新数据
 */
- (void)pullDownToRefreshLatestNews
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadLatestNews)];
    
    [self.tableView.mj_header beginRefreshing];
}
/**
 *  上拉加载更多数据
 */
- (void)pullUpToLoadMoreNews
{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.count += 10;
        self.offset = self.count;
        _param[OFFSET] = [NSString stringWithFormat:@"%ld",self.offset];
        
        _param[LIMIT] = @10;
        _param[TYPE] = @1;
        _param[VER] = @"6.6";
        //加载新闻数据
        [self loadLatestNews];

    }];
    [self.tableView.mj_footer beginRefreshing];
}

#pragma mark - 数据相关


- (void)setUptableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20.0*ScreenHeight/667.0, ScreenWidth, ScreenHeight-99.0*ScreenHeight/667.0) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
- (void)loadLatestNews
{
    [HttpTools get:YYGetCarNewsURL params:self.param success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
        for (NSDictionary *tempDict in dict[@"newsList"]) {
            LatestNewsModel *model = [LatestNewsModel yy_modelWithDictionary:tempDict];
            //把模型里面有广告的数据过滤掉，adIndex属性关系着广告
            if (!model.adIndex) {
                  [self.dataArray addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - Table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [HomeTableViewCell cellWithTableView:tableView];
    LatestNewsModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}
#pragma mark - Table view header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0*ScreenHeight/667.0;
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DefineHeaderView *headerView = [[DefineHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 175.0*ScreenHeight/667.0)];
    //解决headerView不能随着cell一起滚动
    //把tableView的headerView设置成 cell组的headerView
    self.tableView.tableHeaderView = headerView;
    [headerView loadImageData];
    
    return headerView;
}
#pragma mark - Table view delegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0*ScreenHeight/667.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LatestNewsModel *model = self.dataArray[indexPath.row];
    LatestWebViewController *webViewController = [[LatestWebViewController alloc] init];
    
    webViewController.urlStr = model.newsLink;
    [self.navigationController pushViewController:webViewController animated:YES];
}
@end
