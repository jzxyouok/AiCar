//
//  HttpTools.h
//  SunShineCar
//
//  Created by stellar on 16/4/9.
//  Copyright © 2016年 stellar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTools : NSObject
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id data))success failure:(void (^)(NSError *error))failure;
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
