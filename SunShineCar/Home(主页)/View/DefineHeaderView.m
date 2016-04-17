//
//  DefineHeaderView.m
//  SunShineCar
//
//  Created by stellar on 16/4/9.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "DefineHeaderView.h"
#import "UIImageView+WebCache.h"
#import "Public.h"
#import "YYModel.h"
#import "HeaderModel.h"
#import "SDCycleScrollView.h"
@interface DefineHeaderView ()<SDCycleScrollViewDelegate>
@property(nonatomic,weak)UIScrollView *scrollView;


@property(nonatomic,strong)NSMutableArray *imageArray;
@end
@implementation DefineHeaderView

//懒加载数组初始化
- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (void)loadImageData
{
    NSURL *url = [NSURL URLWithString:YYGetCarNewsURL];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
        if (!error) {
            for (NSDictionary *tempDict in dict[@"focusList"][@"focusImgs"]) {
                HeaderModel *model = [HeaderModel yy_modelWithDictionary:tempDict];
                [self.imageArray addObject:model.imgURL];
            }
        }
        else {
            NSLog(@"%@",error);
        }
        //请求数据成功，刷新UI
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self createCycleScrollView];
        });
    }];
    [dataTask resume];
}
- (void)createCycleScrollView
{
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.contentSize = CGSizeMake(ScreenWidth * self.imageArray.count, 175.0*ScreenHeight/667.0);
     [self addSubview:scrollView];
    self.scrollView = scrollView;
    //监听图片点击遵循协议，成为代理，实现方法
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 175.0*ScreenHeight/667.0) delegate:self placeholderImage:[UIImage imageNamed:@"loadHolder"]];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    // 自定义分页控件小圆标颜色
    cycleScrollView.currentPageDotColor = YYColor(237, 75, 75);
    [self.scrollView addSubview:cycleScrollView];
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //加载网络图片
        cycleScrollView.imageURLStringsGroup = self.imageArray;
    });

}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
}
@end
