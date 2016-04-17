//
//  SpecialSaleModel.h
//  SunShineCar
//
//  Created by stellar on 16/4/15.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialSaleModel : NSObject
/** 汽车名称*/
@property(nonatomic,copy)NSString *seriesName;
/** 降价*/
@property(nonatomic,copy)NSString *cheapRange;
/** 汽车型号*/
@property(nonatomic,copy)NSString *carName;
/** 图片*/
@property(nonatomic,copy)NSString *seriesImage;
/** 电话号码*/
@property(nonatomic,copy)NSString *dealerTel;
/** 地址*/
@property(nonatomic,copy)NSString *dealerName;
@end
