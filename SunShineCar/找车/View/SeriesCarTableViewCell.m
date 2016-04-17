//
//  SeriesCarTableViewCell.m
//  SunShineCar
//
//  Created by stellar on 16/4/12.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "SeriesCarTableViewCell.h"
#import "Public.h"
#import "SeriesBrand.h"
@interface SeriesCarTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *carNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *carTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *driverLabel;
@property (weak, nonatomic) IBOutlet UILabel *engineLabel;
@property (weak, nonatomic) IBOutlet UILabel *transmissionLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowestPrice;
@property (weak, nonatomic) IBOutlet UILabel *guidePriceLabel;

@end
@implementation SeriesCarTableViewCell
- (IBAction)lowestPrice:(id)sender {
    
    NSLog(@"---问最低价---");
}
- (IBAction)compareButton:(id)sender {
     NSLog(@"---＋对比---");
}
- (IBAction)purchaseCar:(id)sender {
     NSLog(@"---购车计算---");
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    static NSString * const CellIdentifier = @"snoopy";
    SeriesCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SeriesCarTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.backgroundColor = YYColor(244, 240, 243);
    return cell;
}
- (void)setModel:(SeriesBrand *)model
{
    _model = model;
    NSString *subSeriesNamed = [model valueForKey:@"subSeriesName"];
    NSString *driverd = [model valueForKey:@"driver"];
    NSString *carNamed = [model valueForKey:@"carName"];
    NSString *engined = [model valueForKey:@"engine"];
    NSString *transmissions = [model valueForKey:@"transmission"];
    NSString *lowestPriced = [model valueForKey:@"lowestPrice"];
    NSString *guidePriced = [model valueForKey:@"guidePrice"];
    self.carNameLabel.text = subSeriesNamed;
    self.carTypeLabel.text = carNamed;
    self.driverLabel.text = driverd;
    self.engineLabel.text = engined;
    self.transmissionLabel.text = transmissions;
    self.lowestPrice.text = [NSString stringWithFormat:@"全国最低价：%@",lowestPriced];
    self.guidePriceLabel.text = [NSString stringWithFormat:@"(指导价：%@)",guidePriced];
    
}
@end
