//
//  UNDataListInfo.h
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNDataBaseObject.h"

@interface UNDataListInfo<__covariant ObjectType> : UNDataBaseObject

@property (nullable, nonatomic)Class classType;
@property (nullable, nonatomic, strong) NSNumber *total;
@property (nullable, nonatomic, strong) NSMutableArray<ObjectType> *list;
@property (nullable, nonatomic, strong) NSString *nextSinceID;

- (nullable instancetype)initWithJsonDict:(nullable NSDictionary*)json objClass:(nonnull Class)objClass;
+ (nonnull NSDictionary*)createDictByArray:(nullable NSArray*)array;

@end
