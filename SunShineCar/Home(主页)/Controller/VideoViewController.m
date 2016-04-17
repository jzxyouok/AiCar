//
//  VideoViewController.m
//  AnniCar
//
//  Created by stellar on 16/4/9.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "VideoViewController.h"
#import "Public.h"
@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = YYRandomColor;
[YYNotificationCenter addObserver:self selector:@selector(carBrandIdChanged:) name:YYDictName object:nil];

}
- (void)carBrandIdChanged:(NSNotification *)notification
{
//    NSDictionary *dict = notification.userInfo[YYDict];
    
//    NSLog(@"%@",dict);
    
}
@end
