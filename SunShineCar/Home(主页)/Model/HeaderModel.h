//
//  HeaderModel.h
//  SunShineCar
//
//  Created by stellar on 16/4/9.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderModel : NSObject
/** 图片链接 */
@property (nonatomic, copy) NSString *imgURL;

/** 新闻标题 */
@property (nonatomic, copy) NSString *title;

/** 详细新闻链接 */
@property (nonatomic, copy) NSString *newsLink;
@end
