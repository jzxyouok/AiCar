//
//  SubCarBrand.h
//  SunShineCar
//
//  Created by stellar on 16/4/12.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubCarBrand : NSObject
/** 子品牌名称 */
@property (nonatomic, copy) NSString *subBrandName;

/** 子品牌车型系列 */
@property (nonatomic, strong) NSMutableArray *series;

/** 子品牌车型系列数量 */
@property (nonatomic, copy) NSString *seriesNum;
@end
