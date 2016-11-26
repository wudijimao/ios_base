//
//  NSDictionary+SafeGet.h
//  MovieSDKDemo
//
//  Created by ximiao on 15/12/24.
//  Copyright © 2015年 wudijimao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(DTSafeGet)
// 在get不到时会默认返回nil
- (NSDictionary*)dt_getDictWithKey:(NSObject*)key;
- (NSArray*)dt_getArrayWithKey:(NSObject*)key;
- (NSNumber*)dt_getNumberWithKey:(NSObject*)key;
- (BOOL)dt_getBoolWithKey:(NSObject*)key defaultVal:(BOOL)defaultVal;
- (NSString*)dt_getStringWithKey:(NSObject*)key;
@end
