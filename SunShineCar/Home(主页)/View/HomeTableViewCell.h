//
//  HomeTableViewCell.h
//  SunShineCar
//
//  Created by stellar on 16/4/9.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LatestNewsModel;
@interface HomeTableViewCell : UITableViewCell

@property(nonatomic,strong)LatestNewsModel *model;

//加载自定义cell方法
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
