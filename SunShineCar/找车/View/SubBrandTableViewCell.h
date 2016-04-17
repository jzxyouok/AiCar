//
//  SubBrandTableViewCell.h
//  SunShineCar
//
//  Created by stellar on 16/4/12.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SubBrand;
@interface SubBrandTableViewCell : UITableViewCell


@property(nonatomic,strong)SubBrand *model;
//加载自定义cell方法
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
