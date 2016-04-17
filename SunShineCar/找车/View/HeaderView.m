//
//  HeaderView.m
//  SunShineCar
//
//  Created by stellar on 16/4/13.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "HeaderView.h"
#import "Public.h"
#import "UIImageView+WebCache.h"
@interface HeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *seriesNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *guidePriceLabel;

@end
@implementation HeaderView

- (IBAction)collectionButtonClicked:(id)sender {
    NSLog(@"--- 收藏 ---");
}
- (IBAction)lowestButtonClicked:(id)sender {
    NSLog(@"--- 问最低价 ---");
}

+ (instancetype)itemView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    [YYNotificationCenter addObserver:self selector:@selector(carBrandIdChanged:) name:YYDictName object:nil];
}
//用了通知记得回收
- (void)dealloc
{
    [YYNotificationCenter removeObserver:self];
}
- (void)carBrandIdChanged:(NSNotification *)notification
{
    NSDictionary *dicter = notification.userInfo[YYDict];
    
    self.dict = dicter;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.dict[@"image"]] placeholderImage:[UIImage imageNamed:@"carHolder"]];
    self.seriesNameLabel.text = self.dict[@"seriesName"];
    self.guidePriceLabel.text = [NSString stringWithFormat:@"厂商指导价：%@",self.dict[@"price"]];
}
@end
