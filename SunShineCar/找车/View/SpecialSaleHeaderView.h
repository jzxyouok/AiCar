//
//  SpecialSaleHeaderView.h
//  SunShineCar
//
//  Created by stellar on 16/4/15.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SpecialSaleModel;
@interface SpecialSaleHeaderView : UIView

@property(nonatomic,strong)SpecialSaleModel *dict;
+ (instancetype)itemView;
@end
