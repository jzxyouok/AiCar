//
//  BarButtonItem.h
//  SunShineCar
//
//  Created by stellar on 16/4/10.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarButtonItem : UIBarButtonItem
+ (UIBarButtonItem *)barButtonWithImage:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
@end
