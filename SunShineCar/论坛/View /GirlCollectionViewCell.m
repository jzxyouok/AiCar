//
//  GirlCollectionViewCell.m
//  SunShineCar
//
//  Created by stellar on 16/4/13.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "GirlCollectionViewCell.h"
#import "GirlsModel.h"
#import "UIImageView+WebCache.h"
@interface GirlCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *girImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation GirlCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(GirlsModel *)model
{
    _model = model;
    self.titleLabel.text = model.title;
    NSString *urlStr = [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",model.img];
    [self.girImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"carHolder"]];
    self.girImageView.layer.cornerRadius = 8;
    self.girImageView.clipsToBounds = YES;
}
@end
