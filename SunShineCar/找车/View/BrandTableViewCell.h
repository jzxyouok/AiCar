//
//  BrandTableViewCell.h
//  SunShineCar
//
//  Created by stellar on 16/4/11.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Brand;
@interface BrandTableViewCell : UITableViewCell


@property(nonatomic,strong)Brand *model;

//加载自定义cell方法
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
