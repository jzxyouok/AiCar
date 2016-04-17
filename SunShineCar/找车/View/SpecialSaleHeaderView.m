//
//  SpecialSaleHeaderView.m
//  SunShineCar
//
//  Created by stellar on 16/4/15.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "SpecialSaleHeaderView.h"
#import "Public.h"
#import "SpecialSaleModel.h"
#import "UIImageView+WebCache.h"
@interface SpecialSaleHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *seriesImageImageView;
@property (weak, nonatomic) IBOutlet UILabel *carNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cheapRangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dealerNameLabel;



@end



@implementation SpecialSaleHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)itemView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SpecialSaleHeaderView" owner:nil options:nil] firstObject];
}
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    [YYNotificationCenter addObserver:self selector:@selector(SpecialSaleChanged:) name:YYSpecialSaleName object:nil];
}
//用了通知记得回收
- (void)dealloc
{
    [YYNotificationCenter removeObserver:self];
}
- (void)SpecialSaleChanged:(NSNotification *)notification
{
    SpecialSaleModel *dicter = notification.userInfo[YYSpecialSaleDict];
    
    self.dict = dicter;
    [self.seriesImageImageView sd_setImageWithURL:[NSURL URLWithString:dicter.seriesImage] placeholderImage:[UIImage imageNamed:@"carHolder"]];
    self.carNameLabel.text = dicter.carName;
    self.cheapRangeLabel.text = [NSString stringWithFormat:@"直降%@万",dicter.cheapRange];
    self.dealerNameLabel.text = dicter.dealerName;
   
}

@end
