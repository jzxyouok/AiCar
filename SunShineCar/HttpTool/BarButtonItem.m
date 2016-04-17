//
//  BarButtonItem.m
//  SunShineCar
//
//  Created by stellar on 16/4/10.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import "BarButtonItem.h"
#import "Public.h"

#define TSEBarButtonButtonImageRatio 0.9
@interface BarButton : UIButton

@end
@implementation BarButton

/**
 *  设置文本在button中的layout
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = contentRect.size.height * TSEBarButtonButtonImageRatio;
    CGFloat titleW = contentRect.size.width + 30;
    CGFloat titleH = contentRect.size.height * TSEBarButtonButtonImageRatio;
    CGFloat titleY = 0.0;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end

@interface BarButtonItem ()

@end
@implementation BarButtonItem
+ (UIBarButtonItem *)barButtonWithImage:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action {
    BarButton *barButton = [[BarButton alloc] init];
    [barButton setTitle:title forState:UIControlStateNormal];
    [barButton setTitleColor:YYColor(99, 194, 232) forState:UIControlStateNormal];
    [barButton setImage:[UIImage imageNamed:imageName]
               forState:UIControlStateNormal];
    barButton.bounds = (CGRect){CGPointZero, barButton.currentImage.size};
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    return [[UIBarButtonItem alloc] initWithCustomView:barButton];
}

+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *barButton = [[UIButton alloc] init];
    [barButton setTitle:title forState:UIControlStateNormal];
    [barButton setTitleColor:YYColor(178, 24, 18) forState:UIControlStateNormal];
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    barButton.bounds = CGRectMake(0.0, 0.0, 40.0, 40.0);
    return [[UIBarButtonItem alloc] initWithCustomView:barButton];
}

@end
