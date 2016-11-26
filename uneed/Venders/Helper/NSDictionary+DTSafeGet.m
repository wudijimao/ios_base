//
//  NSDictionary+SafeGet.m
//  MovieSDKDemo
//
//  Created by ximiao on 15/12/24.
//  Copyright © 2015年 Sina. All rights reserved.
//

#import "NSDictionary+DTSafeGet.h"

@implementation NSDictionary(DTSafeGet)
- (NSDictionary*)dt_getDictWithKey:(NSObject*)key {
    NSDictionary *obj = [self objectForKey:key];
    if (![obj isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return obj;
}
- (NSArray*)dt_getArrayWithKey:(NSObject*)key {
    NSArray *obj = [self objectForKey:key];
    if (![obj isKindOfClass:[NSArray class]]) {
        return nil;
    }
    return obj;
}
- (NSNumber*)dt_getNumberWithKey:(NSObject*)key {
    NSNumber *obj = [self objectForKey:key];
    if (obj && ![obj isKindOfClass:[NSNumber class]]) {
        if ([obj isKindOfClass:[NSString class]]) {
            obj = [[NSNumberFormatter new] numberFromString:(NSString*)obj];
        } else {
            obj = nil;
        }
    }
    return obj;
}
- (BOOL)dt_getBoolWithKey:(NSObject*)key defaultVal:(BOOL)defaultVal {
    NSNumber *num = [self dt_getNumberWithKey:key];
    if (num) {
        return [num boolValue];
    } else {
        return defaultVal;
    }
}
- (NSString*)dt_getStringWithKey:(NSObject*)key {
    NSString *obj = [self objectForKey:key];
    if (obj && ![obj isKindOfClass:[NSString class]]) {
        if ([obj respondsToSelector:@selector(stringValue)]) {
            obj = [obj performSelector:@selector(stringValue)];
        } else {
            obj = @"";
        }
    }
    return obj;
}
@end
