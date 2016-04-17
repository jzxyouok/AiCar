//
//  SubBrandTableViewCell.m
//  SunShineCar
//
//  Created by stellar on 16/4/12.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "SubBrandTableViewCell.h"
#import "Public.h"
#import "SubBrand.h"
#import "UIImageView+WebCache.h"
@interface SubBrandTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end
@implementation SubBrandTableViewCell

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
    SubBrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SubBrandTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.backgroundColor = YYColor(244, 240, 243);
    return cell;
}
- (void)setModel:(SubBrand *)model
{
    _model = model;
    
    NSString *seriesNamed = [model valueForKey:@"seriesName"];
    NSString *seriesIcons = [model valueForKey:@"seriesIcon"];
    NSString *seriesPriced = [model valueForKey:@"seriesPrice"];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:seriesIcons] placeholderImage:[UIImage imageNamed:@"carHolder"]];
    self.nameLabel.text = seriesNamed;
    self.priceLabel.text = seriesPriced;
}
@end
