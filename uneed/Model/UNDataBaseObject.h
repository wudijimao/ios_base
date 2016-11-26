//
//  UNDataBaseObject.h
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+DTSafeGet.h"

@interface UNDataBaseObject : NSObject

+ (nullable instancetype)objectWithJsonDict:(nullable NSDictionary *)dict;
- (nullable instancetype)initWithJsonDict:(nullable NSDictionary *)dict;
- (BOOL)parser:(nullable NSDictionary *)dict;


@end
