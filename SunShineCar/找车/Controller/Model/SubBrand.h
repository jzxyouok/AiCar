//
//  SubBrand.h
//  SunShineCar
//
//  Created by stellar on 16/4/12.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubBrand : NSObject
/** 子品牌车型系列图标 */
@property (nonatomic, copy) NSString *seriesIcon;

/** 子品牌车型系列名字 */
@property (nonatomic, copy) NSString *seriesName;

/** 子品牌车型系列价钱 */
@property (nonatomic, copy) NSString *seriesPrice;

/** 子品牌车型id */
@property (nonatomic, copy) NSString *seriesId;
@end
