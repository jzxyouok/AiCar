//
//  CarBrand.m
//  SunShineCar
//
//  Created by stellar on 16/4/11.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "CarBrand.h"

@implementation CarBrand

- (void)setLetter:(NSString *)letter
{
    _letter = letter;
    //小写字母变大写
    _letter = letter.uppercaseString;
}
@end
