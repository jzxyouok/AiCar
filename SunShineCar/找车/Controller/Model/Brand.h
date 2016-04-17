//
//  Brand.h
//  SunShineCar
//
//  Created by stellar on 16/4/11.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface Brand : NSObject<YYModel>
/** 车型图标 */
@property (nonatomic, copy) NSString *icon;

/** 车型名字 */
@property (nonatomic, copy) NSString *name;

/** 子品牌id */
@property (nonatomic, copy) NSString *ID;

@end
