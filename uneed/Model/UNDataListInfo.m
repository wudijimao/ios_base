//
//  UNDataListInfo.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNDataListInfo.h"

@implementation UNDataListInfo
+ (NSDictionary*)createDictByArray:(NSArray*)array {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:array, @"list", nil];
    return dict;
}
- (id)initWithJsonDict:(NSDictionary*)json objClass:(Class)objClass {
    self = [super init];
    if (self) {
        _classType = objClass;
        [self parser:json];
        
    }
    return self;
}
- (BOOL)parser:(NSDictionary *)dict {
    if ([dict isKindOfClass:[NSArray class]]) {
        dict = [UNDataListInfo createDictByArray:(NSArray*)dict];
    }
    if ([super parser:dict]) {
        self.total = [dict dt_getNumberWithKey:@"total"];
        if (!self.total) {
            self.total = [dict dt_getNumberWithKey:@"count"];
        }
        self.list = [NSMutableArray array];
        self.nextSinceID = [dict dt_getStringWithKey:@"next_since_id"];
        NSArray *datas = [dict dt_getArrayWithKey:@"list"];
        for (NSDictionary *data in datas)
        {
            if ([data isKindOfClass:[NSDictionary class]])
            {
                NSObject *obj = [[self.classType alloc] initWithJsonDict:data];
                if (obj) {
                    [_list addObject:obj];
                }
            }
        }
        return YES;
    }
    return NO;
}
- (id)copyWithZone:(NSZone *)zone {
    UNDataListInfo *copy = [[UNDataListInfo alloc] init];
    copy.list = [NSMutableArray array];
    for (NSObject *obj in self.list) {
        [copy.list addObject:[obj copy]];
    }
    copy.total = self.total;
    copy.nextSinceID = [self.nextSinceID copy];
    return copy;
}
@end
