//
//  SeriesBrand.h
//  SunShineCar
//
//  Created by stellar on 16/4/12.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeriesBrand : NSObject
/** 汽车名称 */
@property (nonatomic, copy) NSString *subSeriesName;

/** 汽车型号 */
@property (nonatomic, copy) NSString *carName;

/** 汽车驱动 */
@property (nonatomic, copy) NSString *driver;

/** 汽车引擎 */
@property (nonatomic, copy) NSString *engine;

/** 手/自动档 */
@property (nonatomic, copy) NSString *transmission;

/** 汽车指导价 */
@property (nonatomic, copy) NSString *guidePrice;

/** 汽车最低价 */
@property (nonatomic, copy) NSString *lowestPrice;
@end
