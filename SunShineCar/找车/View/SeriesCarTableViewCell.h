//
//  SeriesCarTableViewCell.h
//  SunShineCar
//
//  Created by stellar on 16/4/12.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SeriesBrand;
@interface SeriesCarTableViewCell : UITableViewCell

@property(nonatomic,strong)SeriesBrand *model;

//加载自定义cell类方法
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
