//
//  UNDataBaseObject.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNDataBaseObject.h"
#import <objc/runtime.h>

@implementation UNDataBaseObject

- (instancetype)initWithJsonDict:(NSDictionary *)dict
{
    self = [self init];
    if (self) {
        if ([self parser:dict]) {
        }
        return self;
    }
    return nil;
}
+ (instancetype)objectWithJsonDict:(NSDictionary *)dict {
    UNDataBaseObject *obj = [[self alloc] initWithJsonDict:dict];
    return obj;
}

- (BOOL)parser:(NSDictionary *)dict {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    return NO;
}

- (NSString *)description {
    NSMutableString *string = [[super description] mutableCopy];
    unsigned int propertyCount = 0;
    Class cls = [self class];
    while (cls != [NSObject class]) {
        objc_property_t *propertyList = class_copyPropertyList(cls, &propertyCount);
        for (unsigned int i = 0; i < propertyCount; i++ ) {
            objc_property_t *thisProperty = propertyList + i;
            const char* cPropertyName = property_getName(*thisProperty);
            NSString *propertyName = [NSString stringWithUTF8String:cPropertyName];
            id propertyValue = [self valueForKey:(NSString *)propertyName];
            [string appendFormat:@"\n%@:", propertyName];
            if (propertyValue != nil) {
                [string appendString:[propertyValue description]];
            } else {
                [string appendString:@"nil"];
            }
        }
        cls = class_getSuperclass(cls);
    }
    
    return string;
}

@end
