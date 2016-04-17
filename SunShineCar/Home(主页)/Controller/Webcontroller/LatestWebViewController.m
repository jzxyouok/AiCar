//
//  LatestWebViewController.m
//  SunShineCar
//
//  Created by stellar on 16/4/10.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "LatestWebViewController.h"
#import "Public.h"
#import "BarButtonItem.h"
@interface LatestWebViewController ()<UIWebViewDelegate>

@end

@implementation LatestWebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = YYRandomColor;
    
    [self createWebView];
}

- (void)createWebView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    self.webView.delegate = self;
//    self.navigationItem.leftBarButtonItem = [BarButtonItem barButtonWithImage:@"nav_fanhui" title:@"返回" target:self action:@selector(backToLatesetView)];
        self.navigationItem.leftBarButtonItem = [BarButtonItem barButtonWithTitle:@"返回" target:self action:@selector(backToLatesetView)];
    self.navigationItem.rightBarButtonItem = [BarButtonItem barButtonWithTitle:@"更多" target:self action:@selector(moreData)];
    [self.view addSubview:self.webView];
}
#pragma mark - @selector
- (void)backToLatesetView
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)moreData
{
    NSLog(@"---点击更多---");
}
#pragma mark - 代理
/**
 *  网页开始加载的时候调用
 */
- (void )webViewDidStartLoad:(UIWebView  *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
/**
 *  网页加载完成的时候调用
 */
- (void )webViewDidFinishLoad:(UIWebView  *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //处理内存泄漏问题
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  网页加载错误的时候调用
 */
- (void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

//内存警告时的处理
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}
@end
