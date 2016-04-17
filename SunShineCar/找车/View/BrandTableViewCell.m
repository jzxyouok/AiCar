//
//  BrandTableViewCell.m
//  SunShineCar
//
//  Created by stellar on 16/4/11.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "BrandTableViewCell.h"
#import "Brand.h"
#import "UIImageView+WebCache.h"
#import "Public.h"
@interface BrandTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *carNameLabel;
@end
@implementation BrandTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//加载自定义cell方法
+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    static NSString * const CellIdentifier = @"snoopy";
    BrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BrandTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.backgroundColor = YYColor(244, 240, 243);
    return cell;
}
- (void)setModel:(Brand *)model
{
    _model = model;
    //。。。。。
    NSString *iconString = [model valueForKey:@"icon"];
    NSString *nameString = [model valueForKey:@"name"];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:iconString] placeholderImage:[UIImage imageNamed:@"carHolder"]];
    self.carNameLabel.text = nameString;
}
@end
