//
//  HomeTableViewCell.m
//  SunShineCar
//
//  Created by stellar on 16/4/9.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "LatestNewsModel.h"
#import "Public.h"
@interface HomeTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *newsIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *CategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *countlabel;


@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * const CellIdentifier = @"snoopy";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.backgroundColor = YYColor(244, 240, 243);
    return cell;
    
}
- (void)setModel:(LatestNewsModel *)model
{
    _model = model;

    [self.newsIcon sd_setImageWithURL:[NSURL URLWithString:model.newsImage] placeholderImage:[UIImage imageNamed:@"loadHolder"]];
    
    self.newsIcon.layer.cornerRadius = 8;
    self.newsIcon.clipsToBounds = YES;
    
    self.titleLabel.text = model.newsTitle;
    self.CategoryLabel.text = model.newsCategory;
    self.countlabel.text = model.commentCount;
}
@end
