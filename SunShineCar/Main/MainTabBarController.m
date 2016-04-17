//
//  MainViewController.m
//  AnniCar
//
//  Created by stellar on 16/4/9.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "MainTabBarController.h"
#import "WMPageController.h"
#import "MineDefineNavigationController.h"
#import "Public.h"

#import "LatestNewsViewController.h"
#import "VideoViewController.h"
#import "GuidePurchaseViewController.h"
#import "TestingViewController.h"
#import "MarketConditionsViewController.h"

#import "SpecialChoiceController.h"
#import "HotBbsController.h"
#import "FindBbsController.h"

#import "BrandCarViewController.h"
#import "ConditionCarViewController.h"

#import "DownPriceController.h"
#import "ActivityViewController.h"
#import "ProperViewController.h"
#import "ApplyViewController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initMainViewController];
}

- (void)initMainViewController
{
    //一.
    //1.1主页WMPageController翻页效果的实现
    NSMutableArray *homeClassArray = [NSMutableArray array];
    NSMutableArray *homeTitleArray = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        Class ViewControllerClass;
        NSString *title;
        
        switch (i) {
            case 0:
                ViewControllerClass = [LatestNewsViewController class];
                title = @"最新";
                break;
            case 1:
                ViewControllerClass = [VideoViewController class];
                title = @"视屏";
                break;
            case 2:
                ViewControllerClass = [GuidePurchaseViewController class];
                title = @"导购";
                break;
            case 3:
                ViewControllerClass = [TestingViewController class];
                title = @"测评";
                break;
            case 4:
                ViewControllerClass = [MarketConditionsViewController class];
                title = @"行情";
                break;
                
        }
        //视图控制器和标题分别装进数组中
        [homeClassArray addObject:ViewControllerClass];
        [homeTitleArray addObject:title];
    }
    WMPageController *home = [[WMPageController alloc] initWithViewControllerClasses:homeClassArray andTheirTitles:homeTitleArray];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    //隐藏导航条
     [home.navigationController setNavigationBarHidden:YES];
    //设置选择控制器的一些属性
    home.menuViewStyle = WMMenuViewStyleLine;
    home.menuItemWidth = 66*ScreenWidth/375;
    home.titleColorNormal = [UIColor blackColor];
    home.titleColorSelected = [UIColor orangeColor];
    
    //1.2论坛
    NSMutableArray *BBSClassArray = [NSMutableArray array];
    NSMutableArray *BBSTitleArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        Class ViewControllerClass;
        NSString *title;
        
        switch (i) {
            case 0:
                ViewControllerClass = [SpecialChoiceController class];
                title = @"精选";
                break;
            case 1:
                ViewControllerClass = [HotBbsController class];
                title = @"美图";
                break;
            case 2:
                ViewControllerClass = [FindBbsController class];
                title = @"找论坛";
                break;
        }
        //视图控制器和标题分别装进数组中
        [BBSClassArray addObject:ViewControllerClass];
        [BBSTitleArray addObject:title];
    }
    WMPageController *bbs = [[WMPageController alloc] initWithViewControllerClasses:BBSClassArray andTheirTitles:BBSTitleArray];
    UINavigationController *bbsNav = [[UINavigationController alloc] initWithRootViewController:bbs];
    //设置选择控制器的一些属性
    //隐藏导航条
    [bbs.navigationController setNavigationBarHidden:YES];
    bbs.menuViewStyle = WMMenuViewStyleLine;
    bbs.menuItemWidth = 66*ScreenWidth/375;
    bbs.titleColorNormal = [UIColor blackColor];
    bbs.titleColorSelected = [UIColor orangeColor];
    
    
    //1.3找车
    NSMutableArray *FindCarClassArray = [NSMutableArray array];
    NSMutableArray *FindCarTitleArray = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        Class ViewControllerClass;
        NSString *title;
        
        switch (i) {
            case 0:
                ViewControllerClass = [BrandCarViewController class];
                title = @"品牌找车";
                break;
            case 1:
                ViewControllerClass = [ConditionCarViewController class];
                title = @"条件找车";
                break;

        }
        //视图控制器和标题分别装进数组中
        [FindCarClassArray addObject:ViewControllerClass];
        [FindCarTitleArray addObject:title];
    }
    WMPageController *findCar = [[WMPageController alloc] initWithViewControllerClasses:FindCarClassArray andTheirTitles:FindCarTitleArray];
    UINavigationController *findCarNav = [[UINavigationController alloc] initWithRootViewController:findCar];
    //设置选择控制器的一些属性
    //隐藏导航条
    [findCar.navigationController setNavigationBarHidden:YES];
    findCar.menuViewStyle = WMMenuViewStyleLine;
    findCar.menuItemWidth = 88*ScreenWidth/375;
    findCar.titleColorNormal = [UIColor blackColor];
    findCar.titleColorSelected = [UIColor orangeColor];
    
    //1.4降价
    
    NSMutableArray *LowPriceClassArray = [NSMutableArray array];
    NSMutableArray *LowPriceTitleArray = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        Class ViewControllerClass;
        NSString *title;
        
        switch (i) {
            case 0:
                ViewControllerClass = [DownPriceController class];
                title = @"降价";
                break;
            case 1:
                ViewControllerClass = [ActivityViewController class];
                title = @"活动";
                break;
            case 2:
                ViewControllerClass = [ProperViewController class];
                title = @"车有惠";
                break;
            case 3:
                ViewControllerClass = [ApplyViewController class];
                title = @"我报名的";
                break;
        }
        //视图控制器和标题分别装进数组中
        [LowPriceClassArray addObject:ViewControllerClass];
        [LowPriceTitleArray addObject:title];
    }
    WMPageController *low = [[WMPageController alloc] initWithViewControllerClasses:LowPriceClassArray andTheirTitles:LowPriceTitleArray];
    UINavigationController *lowNav = [[UINavigationController alloc] initWithRootViewController:low];
    //设置选择控制器的一些属性
    //隐藏导航条
    [low.navigationController setNavigationBarHidden:YES];
    low.menuViewStyle = WMMenuViewStyleLine;
    low.menuItemWidth = 76*ScreenWidth/375;
    low.titleColorNormal = [UIColor blackColor];
    low.titleColorSelected = [UIColor orangeColor];
    
    //二.初始化tabBar
    NSArray *viewsController = @[homeNav,bbsNav,findCarNav,lowNav];
    [self setViewControllers:viewsController animated:YES];
    UITabBar *tabBar = self.tabBar;
    //三.设置控制器属性
    [self setupChildViewController:home title:@"首页" imageName:@"tab_shouye_baitian" selectedImageName:@"tab_shouye_baitian_hit" tabBar:tabBar index:0];
    [self setupChildViewController:bbs title:@"发现" imageName:@"tab_luntan_baitian" selectedImageName:@"tab_luntan_baitian_hit" tabBar:tabBar index:1];
    [self setupChildViewController:findCar title:@"找车" imageName:@"tab_zhaoche_baitian" selectedImageName:@"tab_zhaoche_baitian_hit" tabBar:tabBar index:2];
    [self setupChildViewController:low title:@"降价" imageName:@"tab_jiangjia_baitian" selectedImageName:@"tab_jiangjia_baitian_hit" tabBar:tabBar index:3];
    
}
- (void)setupChildViewController:(UIViewController *)childVC
                           title:(NSString *)title
                       imageName:(NSString *)imageName
               selectedImageName:(NSString *)selectedImageName
                          tabBar:(UITabBar *)tabBar
                           index:(NSUInteger)index {
    childVC.title = title;
    UITabBarItem *item = [tabBar.items objectAtIndex:index];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 设置不对图片进行蓝色的渲染
    [item setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item setSelectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}


@end
