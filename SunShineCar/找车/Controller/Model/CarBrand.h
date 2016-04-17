//
//  CarBrand.h
//  SunShineCar
//
//  Created by stellar on 16/4/11.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarBrand : NSObject
/** 汽车品牌 */
@property (nonatomic, strong) NSMutableArray *brands;
/** 品牌所有车型数目 */
@property (nonatomic, assign) NSInteger brandNum;

/** 品牌首字母 */
@property (nonatomic, copy) NSString *letter;
@end
