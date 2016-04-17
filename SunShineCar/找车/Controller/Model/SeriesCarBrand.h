//
//  SeriesCarBrand.h
//  SunShineCar
//
//  Created by stellar on 16/4/12.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeriesCarBrand : NSObject
/**发动机*/
@property(nonatomic,copy)NSString *engine;
/**汽车属性*/
@property(nonatomic,strong)NSMutableArray *cars;
@end
