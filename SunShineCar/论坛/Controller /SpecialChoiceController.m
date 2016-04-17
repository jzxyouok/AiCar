//
//  HotBbsController.m
//  SunShineCar
//
//  Created by stellar on 16/4/10.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "SpecialChoiceController.h"
#import "Public.h"
#import "HttpTools.h"
#import "YYModel.h"
#import "MJRefresh.h"
#import "GirlsModel.h"
#import "GirlCollectionViewCell.h"

#import "PictureDetailViewController.h"
#import "DWBubbleMenuButton.h"
@interface SpecialChoiceController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,weak)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,assign)NSInteger PictureId;

@property(nonatomic,strong)NSMutableDictionary *param;

@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger counts;

@end

@implementation SpecialChoiceController

static NSString * const reuseIdentifier = @"snoopy";


#pragma mark - 集合视图数据
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpCollectionView];
    // 下拉加载最新数据
    [self pullDownToRefreshLatestNews];
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableDictionary *)param
{
    if (!_param) {
        _param = [NSMutableDictionary dictionary];
        _param[Pagin] = @1;
        _param[PicId] = @6;
    }
    return _param;
}
#pragma mark - 刷新数据
/**
 *  下拉加载最新数据
 */
- (void)pullDownToRefreshLatestNews
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    [self.collectionView.mj_header beginRefreshing];
}
//创建集合视图
- (void)setUpCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 1.1设置每个Item的大小
    layout.itemSize = CGSizeMake(170.0*ScreenWidth/375.0, 280.0*ScreenHeight/667.0);
    // 1.2 设置每列最小间距
    layout.minimumInteritemSpacing = 6;
    
    // 1.3设置每行最小间距
    layout.minimumLineSpacing = 6;
    
    // 1.4设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 1.5 设置item内边距大小
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    // 1.7 设置集合视图样式
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20.0*ScreenHeight/667.0, ScreenWidth, ScreenHeight-99*ScreenHeight/667.0) collectionViewLayout:layout];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    collectionView.backgroundColor = [UIColor lightGrayColor];
    //注册单元格
    [collectionView registerNib:[UINib nibWithNibName:@"GirlCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.view addSubview:collectionView];
    //    //两个视图同在一个view上，可以控制子视图的层次，谁显示在上一层
    //    [self.view insertSubview:categoryButton aboveSubview:collectionView];
    self.collectionView = collectionView;
}
- (void)loadData
{
    [HttpTools get:YYGetGirlsURL params:self.param success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
        for (NSDictionary *tempDict in dict[@"tngou"]) {
            GirlsModel *model = [GirlsModel yy_modelWithDictionary:tempDict];
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - 自定义气泡按钮
//1.载入气泡按钮
- (void)viewDidAppear:(BOOL)animated
{
    //1.1
    UILabel *MainLabel =  [self createMainLabel];
    //1.2
    DWBubbleMenuButton *upMenuView = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(295.0*ScreenWidth/375.0, ScreenHeight/2+180.0*ScreenHeight/667.0, MainLabel.frame.size.width, MainLabel.frame.size.height) expansionDirection:DirectionUp];
    upMenuView.homeButtonView = MainLabel;
    //1.3
    [upMenuView addButtons:[self createButtons]];
    [self.view addSubview:upMenuView];
}
//2.主按钮创建
- (UILabel *)createMainLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70.0*ScreenWidth/375.0, 70.0*ScreenHeight/667.0)];
    label.text = @"更多";
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = label.frame.size.height/2;
    label.backgroundColor = YYColor(96, 160, 220);
    label.clipsToBounds = YES;
    return label;
}
//3.子按钮创建，用数组存放
- (NSArray *)createButtons
{
    NSInteger index = 1001;
    NSMutableArray *buttonArray = [NSMutableArray array];
    for (NSString *buttonTitle in @[@"性感美女",@"韩日美女",@"丝袜美腿",@"美女照片",@"美女写真",@"清纯美女",@"性感车模"]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitleColor:YYColor(236, 212, 198) forState:UIControlStateNormal];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        button.backgroundColor = YYColor(96, 160, 220);
        button.frame = CGRectMake(0, 0, 70.0*ScreenWidth/375.0, 40.0*ScreenHeight/667.0);
        button.layer.cornerRadius = 8;
        button.clipsToBounds = YES;
        
        button.tag = index++;
        [button addTarget:self action:@selector(tagChanged:) forControlEvents:UIControlEventTouchUpInside];
        [buttonArray addObject:button];
    }
    return [buttonArray copy];
}

//4.用tag来代替id，换个方式得到id
- (void)tagChanged:(UIButton *)sender
{
    self.PictureId = sender.tag - 1000;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 数据源

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GirlCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}
#pragma mark - 代理
//item点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PictureDetailViewController *pic =  [[PictureDetailViewController alloc] init];
    GirlsModel *model = self.dataArray[indexPath.item];
    NSString *str  = [NSString stringWithFormat:@"http://www.tngou.net/tnfs/show/%@",model.ID];
    pic.urlStr = str ;
    [self.navigationController pushViewController:pic animated:YES];
}
@end

